#include <iostream>
#include <string>

#include <Windows.h>
#include <WtsApi32.h>
#include <Userenv.h>

#pragma comment(lib, "Userenv.lib")
#pragma comment(lib, "WtsApi32.lib")

bool NSudoCreateProcess(LPCWSTR commandLine, LPCWSTR currentDirectory) {
	bool success = true;

	DWORD sessionID = static_cast<DWORD>(-1);
	HANDLE processToken = INVALID_HANDLE_VALUE; // Current token
	HANDLE systemToken = INVALID_HANDLE_VALUE; // For SYSTEM user
	HANDLE trustedInstallerToken = INVALID_HANDLE_VALUE;


	// 1. Session id
	std::cout << "1. Get session ID\n";

	// Get the session id
	{
		DWORD count = 0;
		PWTS_SESSION_INFOW pSessionInfo = nullptr;
		if (WTSEnumerateSessionsW(
			WTS_CURRENT_SERVER_HANDLE,
			0,
			1,
			&pSessionInfo,
			&count)) {
			for (DWORD i = 0; i < count; ++i) {
				if (pSessionInfo[i].State == WTS_CONNECTSTATE_CLASS::WTSActive) {
					sessionID = pSessionInfo[i].SessionId;
					break;
				}
			}
			WTSFreeMemory(pSessionInfo);
		}
		if (sessionID == static_cast<DWORD>(-1)) {
			goto error;
		}
	}


	// 2. Setup thread token
	std::cout << "2. Setup thread token\n";

	// Copy current process token
	{
		HANDLE originalToken = INVALID_HANDLE_VALUE;
		if (!OpenProcessToken(GetCurrentProcess(), MAXIMUM_ALLOWED, &originalToken)) goto error;

		auto result = DuplicateTokenEx(
			originalToken,
			MAXIMUM_ALLOWED,
			nullptr,
			SecurityImpersonation,
			TokenImpersonation,
			&processToken);
		CloseHandle(originalToken);
		if (!result) goto error;
	}
	// Request priviledge to adjust memory of another process
	{
		// Lookup the privilege we are interested in
		LUID_AND_ATTRIBUTES requestedPrivilege;
		if (!LookupPrivilegeValueW(nullptr, SE_DEBUG_NAME, &requestedPrivilege.Luid)) goto error; // Lookup LUID
		requestedPrivilege.Attributes = SE_PRIVILEGE_ENABLED; // We want it enabled

		TOKEN_PRIVILEGES newState;
		newState.PrivilegeCount = 1;
		newState.Privileges[0] = requestedPrivilege;

		if (!AdjustTokenPrivileges(
			processToken,
			FALSE,
			&newState,
			sizeof(DWORD) + sizeof(LUID_AND_ATTRIBUTES),
			nullptr,
			nullptr)) goto error;
	}
	if (!SetThreadToken(nullptr, processToken)) goto error;


	// 3. Setup SYSTEM token
	std::cout << "3. Setup SYSTEM token\n";

	// Obtains a copy of the primary access token of the SYSTEM user
	// Must:
	// - Running within the context of Administrator account
	// - Have SE_DEBUG_NAME privilege enabled.
	{
		// If the specified process is the System Idle Process (0x00000000), the
		// function fails and the last error code is ERROR_INVALID_PARAMETER.
		// So this is why 0 is the default value of dwLsassPID and dwWinLogonPID.

		DWORD dwLsassPID = 0;
		DWORD dwWinLogonPID = 0;
		PWTS_PROCESS_INFOW pProcesses = nullptr;
		DWORD dwProcessCount = 0;

		// Look for lsass.exe and winlogon.exe
		if (WTSEnumerateProcessesW(
			WTS_CURRENT_SERVER_HANDLE,
			0,
			1,
			&pProcesses,
			&dwProcessCount)) {
			for (DWORD i = 0; i < dwProcessCount; ++i) {
				PWTS_PROCESS_INFOW pProcess = &pProcesses[i];

				if ((!pProcess->pProcessName) ||
					(!pProcess->pUserSid) ||
					(!IsWellKnownSid(
						pProcess->pUserSid,
						WELL_KNOWN_SID_TYPE::WinLocalSystemSid))) {
					continue;
				}

				if ((0 == dwLsassPID) &&
					(0 == pProcess->SessionId) &&
					(0 == _wcsicmp(L"lsass.exe", pProcess->pProcessName))) {
					dwLsassPID = pProcess->ProcessId;
					continue;
				}

				if ((0 == dwWinLogonPID) &&
					(sessionID == pProcess->SessionId) &&
					(0 == _wcsicmp(L"winlogon.exe", pProcess->pProcessName))) {
					dwWinLogonPID = pProcess->ProcessId;
					continue;
				}
			}

			WTSFreeMemory(pProcesses);
		}

		BOOL result = FALSE;
		HANDLE systemProcess = INVALID_HANDLE_VALUE;

		// Get handle to lsass.exe, otherwise try winlogon.exe as fallback
		systemProcess = OpenProcess(
			PROCESS_QUERY_INFORMATION,
			FALSE,
			dwLsassPID);
		if (!systemProcess) {
			systemProcess = OpenProcess(
				PROCESS_QUERY_INFORMATION,
				FALSE,
				dwWinLogonPID);
		}
		if (!systemProcess) goto error;

		// Duplicate the token
		HANDLE originalSystemToken = INVALID_HANDLE_VALUE;
		if (OpenProcessToken(
			systemProcess,
			TOKEN_DUPLICATE,
			&originalSystemToken)) {
			result = DuplicateTokenEx(
				originalSystemToken,
				MAXIMUM_ALLOWED,
				nullptr,
				SecurityImpersonation,
				TokenImpersonation,
				&systemToken);

			CloseHandle(originalSystemToken);
		}

		CloseHandle(systemProcess);

		if (!result) goto error;
	}
	// Enables all privileges in SYSTEM token
	{
		// Fetch token privileges
		BOOL result = FALSE;

		DWORD length = 0;
		GetTokenInformation(
			systemToken,
			TokenPrivileges,
			nullptr,
			0,
			&length);
		TOKEN_PRIVILEGES* tokenPrivileges = nullptr;
		if (ERROR_INSUFFICIENT_BUFFER == GetLastError()) {
			tokenPrivileges = (TOKEN_PRIVILEGES*)HeapAlloc(GetProcessHeap(), HEAP_ZERO_MEMORY, length);
			if (!tokenPrivileges) goto error;

			result = GetTokenInformation(
				systemToken,
				TokenPrivileges,
				tokenPrivileges,
				length,
				&length);

			if (!result) {
				HeapFree(GetProcessHeap(), 0, tokenPrivileges);
				goto error;
			}
		}
		else {
			goto error;
		}
		// Enable all privileges
		for (DWORD i = 0; i < tokenPrivileges->PrivilegeCount; ++i) {
			tokenPrivileges->Privileges[i].Attributes = SE_PRIVILEGE_ENABLED;
		}
		result = AdjustTokenPrivileges(
			systemToken,
			FALSE,
			tokenPrivileges,
			sizeof(DWORD) + sizeof(LUID_AND_ATTRIBUTES) * tokenPrivileges->PrivilegeCount,
			nullptr,
			nullptr);

		HeapFree(GetProcessHeap(), 0, tokenPrivileges);
		if (!result) goto error;
	}
	if (!SetThreadToken(nullptr, systemToken)) goto error;


	// 4. Setup TrustedInstaller token
	std::cout << "4. Setup TrustedInstaller token\n";

	{
		// Start TrustedInstaller service

		const auto serviceName = L"TrustedInstaller";

		SERVICE_STATUS_PROCESS serviceStatus;
		memset(&serviceStatus, 0, sizeof(SERVICE_STATUS_PROCESS));

		// Get connection to service control manager
		SC_HANDLE hSCM = OpenSCManagerW(nullptr, nullptr, SC_MANAGER_CONNECT);
		if (!hSCM) goto error;

		// Open handle to service
		SC_HANDLE hService = OpenServiceW(hSCM, serviceName, SERVICE_QUERY_STATUS | SERVICE_START);
		CloseServiceHandle(hSCM);
		if (!hService) goto error;

		DWORD nBytesNeeded = 0;
		DWORD nOldCheckPoint = 0;
		ULONGLONG nLastTick = 0;
		bool bStartServiceWCalled = false;

		// Start the service
		BOOL result = TRUE;
		while (QueryServiceStatusEx(
			hService,
			SC_STATUS_PROCESS_INFO,
			reinterpret_cast<LPBYTE>(&serviceStatus),
			sizeof(SERVICE_STATUS_PROCESS),
			&nBytesNeeded)) {

			// Start it if stopped
			if (SERVICE_STOPPED == serviceStatus.dwCurrentState) {
				// Failed if the service had stopped again.
				if (bStartServiceWCalled) {
					result = FALSE;
					break;
				}

				if (!StartServiceW(hService, 0, nullptr)) {
					result = FALSE;
					break;
				}
				bStartServiceWCalled = true;
			}
			// Wait a little and see if it successfully starts
			else if (SERVICE_STOP_PENDING == serviceStatus.dwCurrentState ||
				SERVICE_START_PENDING == serviceStatus.dwCurrentState) {

				ULONGLONG nCurrentTick = GetTickCount64();

				if (!nLastTick) {
					nLastTick = nCurrentTick;
					nOldCheckPoint = serviceStatus.dwCheckPoint;

					// Same as the .Net System.ServiceProcess, wait 250ms.
					SleepEx(250, FALSE);
				}
				else {
					// Check the timeout if the checkpoint is not increased.
					if (serviceStatus.dwCheckPoint <= nOldCheckPoint) {
						ULONGLONG nDiff = nCurrentTick - nLastTick;
						if (nDiff > serviceStatus.dwWaitHint) {
							result = FALSE;
							break;
						}
					}
					// Continue looping.
					nLastTick = 0;
				}
			}
			else {
				// Service started
				break;
			}
		}
		CloseServiceHandle(hService);
		if (!result) goto error;

		// Take a copy of TrustedInstaller token
		HANDLE processHandle = OpenProcess(PROCESS_QUERY_INFORMATION, FALSE, serviceStatus.dwProcessId);
		if (!processHandle) goto error;

		HANDLE originalToken = INVALID_HANDLE_VALUE;
		result = OpenProcessToken(processHandle, MAXIMUM_ALLOWED, &originalToken);
		if (result) {
			result = DuplicateTokenEx(
				originalToken,
				MAXIMUM_ALLOWED,
				nullptr,
				SecurityIdentification,
				TokenPrimary,
				&trustedInstallerToken);
			CloseHandle(originalToken);
		}
		CloseHandle(processHandle);
		if (!result) goto error;
	}
	// Change TrustedInstaller token sessionID to current sessionID
	if (!SetTokenInformation(
		trustedInstallerToken,
		TokenSessionId,
		(PVOID)&sessionID,
		sizeof(DWORD))) goto error;


	// 5. Start requested process in command line as TrustedInstaller
	std::cout << "5. Start requested process as TrustedInstaller\n";

	{
		LPVOID lpEnvironment = nullptr;

		// Retrieve environmental variables to expand command line
		BOOL result = TRUE;
		if (!CreateEnvironmentBlock(&lpEnvironment, trustedInstallerToken, TRUE)) goto error;

		std::wstring expandedCmdln;
		std::wstring cmdln(commandLine);

		UINT length = ExpandEnvironmentStringsW(cmdln.c_str(), nullptr, 0);
		if (length) {
			expandedCmdln.resize(length);
			length = ExpandEnvironmentStringsW(cmdln.c_str(), &expandedCmdln[0], length);
			if (!length) result = FALSE;
		}
		else {
			result = FALSE;
		}

		// Start the requested process in the command line as TrustedInstaller
		if (result) {
			STARTUPINFOW startupInfo = { 0 };
			startupInfo.cb = sizeof(STARTUPINFOW);
			startupInfo.lpDesktop = const_cast<LPWSTR>(L"WinSta0\\Default");
			startupInfo.dwFlags |= STARTF_USESHOWWINDOW;
			startupInfo.wShowWindow = SW_SHOW;

			PROCESS_INFORMATION processInfo = { 0 };
			result = CreateProcessAsUserW(
				trustedInstallerToken,
				nullptr,
				const_cast<LPWSTR>(expandedCmdln.c_str()),
				nullptr,
				nullptr,
				FALSE,
				CREATE_SUSPENDED | CREATE_UNICODE_ENVIRONMENT | CREATE_NEW_CONSOLE,
				lpEnvironment,
				currentDirectory,
				&startupInfo,
				&processInfo);

			if (result) {
				SetPriorityClass(processInfo.hProcess, NORMAL_PRIORITY_CLASS);

				ResumeThread(processInfo.hThread);

				WaitForSingleObjectEx(processInfo.hProcess, 0, FALSE);

				CloseHandle(processInfo.hProcess);
				CloseHandle(processInfo.hThread);
			}
		}

		DestroyEnvironmentBlock(lpEnvironment);
		if (!result) goto error;
	}

	std::cout << "Success!\n";
	goto cleanup;

error:
	success = false;

cleanup:
	if (processToken != INVALID_HANDLE_VALUE) CloseHandle(processToken);
	if (systemToken != INVALID_HANDLE_VALUE) CloseHandle(systemToken);
	if (trustedInstallerToken != INVALID_HANDLE_VALUE) CloseHandle(trustedInstallerToken);
	SetThreadToken(nullptr, nullptr);

	return success;
}

int main()
{
	CoInitializeEx(nullptr, COINIT_APARTMENTTHREADED | COINIT_DISABLE_OLE1DDE);

	LPWSTR* argv;
	int argc;
	argv = CommandLineToArgvW(GetCommandLineW(), &argc);
	if (!argv) {
		std::cout << "Failed to parse command line\n";
		return -1;
	}

	int status = 0;
	if (argc == 2) {
		// Get application path
		// 32767 is the maximum path length without the terminating null character.
		std::wstring appPath(32767, L'\0');
		appPath.resize(GetModuleFileNameW(nullptr, &appPath[0], static_cast<DWORD>(appPath.size())));
		wcsrchr(&appPath[0], L'\\')[0] = L'\0';
		appPath.resize(wcslen(appPath.c_str()));

		if (!NSudoCreateProcess(argv[1], appPath.c_str())) {
			std::cout << "An error occurred: Code 0x" << std::hex << GetLastError() << "\n";
			status = -1;
		}
	}
	else {
		status = -1;
		std::cout << "Usage: NSudo.exe <Path to process>\n";
	}

	LocalFree(argv);
	return status;
}
