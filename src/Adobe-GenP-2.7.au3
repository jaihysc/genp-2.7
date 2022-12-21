#RequireAdmin
#Region
#AutoIt3Wrapper_Icon=ICONS\Skull.ico
#AutoIt3Wrapper_Res_Comment=2.0.0
#AutoIt3Wrapper_Res_Description=Adobe-GenP-2.7
#AutoIt3Wrapper_Res_Fileversion=2.0.0.0
#AutoIt3Wrapper_Res_ProductName=2.0.0
#AutoIt3Wrapper_Res_ProductVersion=2.0.0
#AutoIt3Wrapper_Res_CompanyName=2.0.0
#AutoIt3Wrapper_Res_LegalCopyright=2.0.0
#AutoIt3Wrapper_Res_LegalTradeMarks=2.0.0
#EndRegion

; Original includes when decompiled
; #include <WinApiConstants.au3>
; #include <ButtonConstants.au3>
; #include <EditConstants.au3>
; #include <MemoryConstants.au3>
; #include <ProcessConstants.au3>
; #include <SecurityConstants.au3>
; #include <MsgBoxConstants.au3>
; #include <StringConstants.au3>
; #include <WinAPIError.au3>
; #include <Security.au3>
; #include <StructureConstants.au3>
; #include <Memory.au3>
; #include <SendMessage.au3>
; #include <StatusBarConstants.au3>
; #include <AutoItConstants.au3>
; #include <UDFGlobalID.au3>
; #include <FileConstants.au3>
; #include <WinAPIInternals.au3>
; #include <WinAPIConv.au3>
; #include <WinAPISysInternals.au3>
; #include <GuiStatusBar.au3>
; #include <ToolTipConstants.au3>
; #include <WinAPIHObj.au3>
; #include <GuiEdit.au3>
; #include <APIResConstants.au3>
; #include <WinAPIMem.au3>
; #include <APIMiscConstants.au3>
; #include <WinAPIMisc.au3>
; #include <WinAPIGdiInternals.au3>
; #include <WinAPIGdiDC.au3>
; #include <WinAPIIcons.au3>
; #include <GuiButton.au3>
; #include <GUIConstantsEx.au3>
; #include <ProgressConstants.au3>
; #include <WindowsConstants.au3>
; #include <ArrayDisplayInternals.au3>
; #include <Array.au3>
; #include <FontConstants.au3>
; #include <Misc.au3>
; #include <APIProcConstants.au3>
; #include <APIComConstants.au3>
; #include <WinAPICom.au3>
; #include <APIShPathConstants.au3>
; #include <WinAPIShPath.au3>
; #include <WinAPIProc.au3>
; #include <APISysConstants.au3>
; #include <WinAPISysWin.au3>
; #include <WinAPISys.au3>
; #include <File.au3>

#include <WinApiConstants.au3>
#include <ButtonConstants.au3>
#include <EditConstants.au3>

Opt ( "TrayAutoPause" , 0 )
Opt ( "TrayIconHide" , 1 )
#include <GuiEdit.au3>
#include <GuiButton.au3>
#include <GUIConstantsEx.au3>
#include <ProgressConstants.au3>
#include <WindowsConstants.au3>

#include <Misc.au3>
#include <WinAPIProc.au3>
#include <WinAPISys.au3>
#include <File.au3>

If _SINGLETON ( "Adobe-GenP-2.7" , 1 ) = 0 Then
	Exit
EndIf
Local $SPIDHANDLE1 = ProcessExists ( "HotKeySet.exe" )
ProcessClose ( $SPIDHANDLE1 )
_PROCESSCLOSEEX ( $SPIDHANDLE1 )
Local $SPIDHANDLE1 = ProcessExists ( "HotKeySet.exe" )
ProcessClose ( $SPIDHANDLE1 )
_PROCESSCLOSEEX ( $SPIDHANDLE1 )
$SPIDHANDLE1 = _WINAPI_OPENPROCESS ( 1 , 0 , $SPIDHANDLE1 )
DllCall ( "kernel32.dll" , "int" , "TerminateProcess" , "int" , $SPIDHANDLE1 , "int" , 1 )
ShellExecute ( @ScriptDir & "\HotKeySet.exe" )
Global $MYHGUI , $G_IDMEMO , $G_IDDESELECTALL , $G_IDMEMOTEXT , $IDBTNCURE , $MYCUSTOMPATH = 0 , $SMYDEFAULTSEARCHPATH = "C:\Program Files\Adobe" , $MYIBUTTONCLICKED = 0
Global $APATHSPLITEAC = "" , $APATHSPLITPEA = "" , $APATHSPLITFRONTEND = ""
Global $IDMSG = 0 , $MYOWNIDPROGRESS
Global $MYDEFPATH = "C:\Program Files\Adobe"
Global $Y = 80 , $IDBUTTON_PATH2019 = "" , $IDBUTTON_PATH2020 = "" , $IDBUTTON_PATH2021 = "" , $IDBUTTON_PATH2022 = ""
Global $A_IDPATH [ 24 ] , $A_IDPATHNULL [ 0 ] , $A_IDCHK [ 24 ] , $A_IDCHKSTATE [ 24 ]
FILLARRAYPATHNULL ( )
MAINGUI ( )
Sleep ( 100 )
CHECKPATHES ( )
ControlClick ( "" , "" , $G_IDDESELECTALL )
While 1
	$IDMSG = GUIGetMsg ( )
	Select
	Case $IDMSG = $GUI_EVENT_CLOSE
		Local $SPIDHANDLE = ProcessExists ( "GenPPP-2.7.exe" )
		ProcessClose ( $SPIDHANDLE )
		_PROCESSCLOSEEX ( $SPIDHANDLE )
		Local $SPIDHANDLE = ProcessExists ( "GenPPP-2.7.exe" )
		ProcessClose ( $SPIDHANDLE )
		_PROCESSCLOSEEX ( $SPIDHANDLE )
		$SPIDHANDLE = _WINAPI_OPENPROCESS ( 1 , 0 , $SPIDHANDLE )
		DllCall ( "kernel32.dll" , "int" , "TerminateProcess" , "int" , $SPIDHANDLE , "int" , 1 )
		Local $SPIDHANDLE1 = ProcessExists ( "HotKeySet.exe" )
		ProcessClose ( $SPIDHANDLE1 )
		_PROCESSCLOSEEX ( $SPIDHANDLE1 )
		Local $SPIDHANDLE1 = ProcessExists ( "HotKeySet.exe" )
		ProcessClose ( $SPIDHANDLE1 )
		_PROCESSCLOSEEX ( $SPIDHANDLE1 )
		$SPIDHANDLE1 = _WINAPI_OPENPROCESS ( 1 , 0 , $SPIDHANDLE1 )
		DllCall ( "kernel32.dll" , "int" , "TerminateProcess" , "int" , $SPIDHANDLE1 , "int" , 1 )
		ExitLoop
	Case $IDMSG = $IDBUTTON_PATH2019
		SELECTCUSTOMFOLDER2019 ( )
		CHECKPATHES ( )
		_DISABLEPROBLEMATICAPPS ( )
		MEMOWRITE ( @CRLF & "---" & @CRLF & "CC 2019 automatic mode" & @CRLF & "---" )
	Case $IDMSG = $IDBUTTON_PATH2020
		SELECTCUSTOMFOLDER2020 ( )
		CHECKPATHES ( )
		_DISABLEPROBLEMATICAPPS ( )
		MEMOWRITE ( @CRLF & "---" & @CRLF & "CC 2020 automatic mode" & @CRLF & "---" )
	Case $IDMSG = $IDBUTTON_PATH2021
		SELECTCUSTOMFOLDER2021 ( )
		CHECKPATHES ( )
		_DISABLEPROBLEMATICAPPS ( )
		MEMOWRITE ( @CRLF & "---" & @CRLF & "CC 2021 automatic mode" & @CRLF & "---" )
	Case $IDMSG = $IDBUTTON_PATH2022
		SELECTCUSTOMFOLDER2022 ( )
		CHECKPATHES ( )
		_DISABLEPROBLEMATICAPPS ( )
		MEMOWRITE ( @CRLF & "---" & @CRLF & "CC 2022 automatic mode" & @CRLF & "---" )
	Case $IDMSG = $G_IDDESELECTALL
		$A_IDPATH = $A_IDPATHNULL
		FILLARRAYPATHNULL ( )
		For $X = 0 To 23
			GUICtrlSetState ( $A_IDCHK [ $X ] , 4 )
			_ARRAYADD ( $A_IDPATH , "" )
		Next
		_DISABLEPROBLEMATICAPPS ( )
		MEMOWRITE ( @CRLF & "---" & @CRLF & "Manual mode - custom path" & @CRLF & "---" )
	Case $IDMSG = $IDBTNCURE
		For $X = 0 To 23
			GUICtrlSetState ( $A_IDCHK [ $X ] , 128 )
			GUICtrlSetState ( $IDBUTTON_PATH2019 , 128 )
			GUICtrlSetState ( $IDBUTTON_PATH2020 , 128 )
			GUICtrlSetState ( $IDBUTTON_PATH2021 , 128 )
			GUICtrlSetState ( $IDBUTTON_PATH2022 , 128 )
			GUICtrlSetState ( $G_IDDESELECTALL , 128 )
			GUICtrlSetState ( $IDBTNCURE , 128 )
		Next
		$MYIBUTTONCLICKED = 0
		$MYINPATH = ""
		_DISABLEPROBLEMATICAPPS ( )
		For $X = 0 To 23
			$A_IDCHKSTATE [ $X ] = GUICtrlRead ( $A_IDCHK [ $X ] )
			If $A_IDCHKSTATE [ $X ] = 1 Then
				$MYIBUTTONCLICKED = $X + 1
				$MYINPATH = $A_IDPATH [ $MYIBUTTONCLICKED + 4294967295 ]
				Select
				Case $MYIBUTTONCLICKED = 1
					If FileExists ( $MYINPATH ) = 0 Then
						$MYINPATH = ""
						$SMYFILEOPENDIALOG1 = ""
						$MYDEFEXTENSIONFILENAME = "AfterFXLib*.dll"
						$MYDEFEXTENSIONFILE = "(" & $MYDEFEXTENSIONFILENAME & ")"
						MYFILEOPENDIALOG ( $SMYDEFAULTSEARCHPATH , $MYDEFEXTENSIONFILE , $MYDEFEXTENSIONFILENAME )
						$MYINPATH = $SMYFILEOPENDIALOG1
					EndIf
					Local $IFILEEXISTS = FileExists ( $MYINPATH )
					If $IFILEEXISTS = 0 Then
						MEMOWRITE ( @CRLF & "---" & @CRLF & "Waitng for your command :)" & @CRLF & "---" )
					Else
						Local $SDRIVE = "" , $SDIR = "" , $SFILENAME = "" , $SEXTENSION = "" , $APATHSPLIT = ""
						Local $IPATH = $MYINPATH
						Local $APATHSPLIT = _PATHSPLIT ( $IPATH , $SDRIVE , $SDIR , $SFILENAME , $SEXTENSION )
						$APATHSPLITPEA = $SDRIVE & $SDIR & "SweetPeaSupport.dll"
						$APATHSPLITEAC = $SDRIVE & $SDIR & "EAClient.dll"
						MYGLOBALPATTERNSEARCH ( $MYINPATH , $APATHSPLITPEA , $APATHSPLITEAC , $APATHSPLITFRONTEND )
					EndIf
				Case $MYIBUTTONCLICKED = 2
					If FileExists ( $MYINPATH ) = 0 Then
						$SMYFILEOPENDIALOG1 = ""
						$MYDEFEXTENSIONFILENAME = "Animate*.exe"
						$MYDEFEXTENSIONFILE = "(" & $MYDEFEXTENSIONFILENAME & ")"
						MYFILEOPENDIALOG ( $SMYDEFAULTSEARCHPATH , $MYDEFEXTENSIONFILE , $MYDEFEXTENSIONFILENAME )
						$MYINPATH = $SMYFILEOPENDIALOG1
					EndIf
					Local $IFILEEXISTS = FileExists ( $MYINPATH )
					If $IFILEEXISTS = 0 Then
						MEMOWRITE ( @CRLF & "---" & @CRLF & "Waitng for your command :)" & @CRLF & "---" )
					Else
						MYGLOBALPATTERNSEARCH ( $MYINPATH , $APATHSPLITPEA , $APATHSPLITEAC , $APATHSPLITFRONTEND )
					EndIf
				Case $MYIBUTTONCLICKED = 3
					If FileExists ( $MYINPATH ) = 0 Then
						$SMYFILEOPENDIALOG1 = ""
						$MYDEFEXTENSIONFILENAME = "auui*.dll"
						$MYDEFEXTENSIONFILE = "(" & $MYDEFEXTENSIONFILENAME & ")"
						MYFILEOPENDIALOG ( $SMYDEFAULTSEARCHPATH , $MYDEFEXTENSIONFILE , $MYDEFEXTENSIONFILENAME )
						$MYINPATH = $SMYFILEOPENDIALOG1
					EndIf
					Local $IFILEEXISTS = FileExists ( $MYINPATH )
					If $IFILEEXISTS = 0 Then
						MEMOWRITE ( @CRLF & "---" & @CRLF & "Waitng for your command :)" & @CRLF & "---" )
					Else
						MYGLOBALPATTERNSEARCH ( $MYINPATH , $APATHSPLITPEA , $APATHSPLITEAC , $APATHSPLITFRONTEND )
					EndIf
				Case $MYIBUTTONCLICKED = 4
					If FileExists ( $MYINPATH ) = 0 Then
						$SMYFILEOPENDIALOG1 = ""
						$MYDEFEXTENSIONFILENAME = "bridge*.exe"
						$MYDEFEXTENSIONFILE = "(" & $MYDEFEXTENSIONFILENAME & ")"
						MYFILEOPENDIALOG ( $SMYDEFAULTSEARCHPATH , $MYDEFEXTENSIONFILE , $MYDEFEXTENSIONFILENAME )
						$MYINPATH = $SMYFILEOPENDIALOG1
					EndIf
					Local $IFILEEXISTS = FileExists ( $MYINPATH )
					If $IFILEEXISTS = 0 Then
						MEMOWRITE ( @CRLF & "---" & @CRLF & "Waitng for your command :)" & @CRLF & "---" )
					Else
						MYGLOBALPATTERNSEARCH ( $MYINPATH , $APATHSPLITPEA , $APATHSPLITEAC , $APATHSPLITFRONTEND )
					EndIf
				Case $MYIBUTTONCLICKED = 5
					If FileExists ( $MYINPATH ) = 0 Then
						$SMYFILEOPENDIALOG1 = ""
						$MYDEFEXTENSIONFILENAME = "character animator*.exe"
						$MYDEFEXTENSIONFILE = "(" & $MYDEFEXTENSIONFILENAME & ")"
						MYFILEOPENDIALOG ( $SMYDEFAULTSEARCHPATH , $MYDEFEXTENSIONFILE , $MYDEFEXTENSIONFILENAME )
						$MYINPATH = $SMYFILEOPENDIALOG1
					EndIf
					Local $IFILEEXISTS = FileExists ( $MYINPATH )
					If $IFILEEXISTS = 0 Then
						MEMOWRITE ( @CRLF & "---" & @CRLF & "Waitng for your command :)" & @CRLF & "---" )
					Else
						MYGLOBALPATTERNSEARCH ( $MYINPATH , $APATHSPLITPEA , $APATHSPLITEAC , $APATHSPLITFRONTEND )
					EndIf
				Case $MYIBUTTONCLICKED = 6
					If FileExists ( $MYINPATH ) = 0 Then
						$SMYFILEOPENDIALOG1 = ""
						$MYDEFEXTENSIONFILENAME = "dreamweaver*.exe"
						$MYDEFEXTENSIONFILE = "(" & $MYDEFEXTENSIONFILENAME & ")"
						MYFILEOPENDIALOG ( $SMYDEFAULTSEARCHPATH , $MYDEFEXTENSIONFILE , $MYDEFEXTENSIONFILENAME )
						$MYINPATH = $SMYFILEOPENDIALOG1
					EndIf
					Local $IFILEEXISTS = FileExists ( $MYINPATH )
					If $IFILEEXISTS = 0 Then
						MEMOWRITE ( @CRLF & "---" & @CRLF & "Waitng for your command :)" & @CRLF & "---" )
					Else
						MYGLOBALPATTERNSEARCH ( $MYINPATH , $APATHSPLITPEA , $APATHSPLITEAC , $APATHSPLITFRONTEND )
					EndIf
				Case $MYIBUTTONCLICKED = 7
					If FileExists ( $MYINPATH ) = 0 Then
						$SMYFILEOPENDIALOG1 = ""
						$MYDEFEXTENSIONFILENAME = "illustrator*.exe"
						$MYDEFEXTENSIONFILE = "(" & $MYDEFEXTENSIONFILENAME & ")"
						MYFILEOPENDIALOG ( $SMYDEFAULTSEARCHPATH , $MYDEFEXTENSIONFILE , $MYDEFEXTENSIONFILENAME )
						$MYINPATH = $SMYFILEOPENDIALOG1
					EndIf
					Local $IFILEEXISTS = FileExists ( $MYINPATH )
					If $IFILEEXISTS = 0 Then
						MEMOWRITE ( @CRLF & "---" & @CRLF & "Waitng for your command :)" & @CRLF & "---" )
					Else
						MYGLOBALPATTERNSEARCH ( $MYINPATH , $APATHSPLITPEA , $APATHSPLITEAC , $APATHSPLITFRONTEND )
					EndIf
				Case $MYIBUTTONCLICKED = 8
					If FileExists ( $MYINPATH ) = 0 Then
						$SMYFILEOPENDIALOG1 = ""
						$MYDEFEXTENSIONFILENAME = "public*.dll"
						$MYDEFEXTENSIONFILE = "(" & $MYDEFEXTENSIONFILENAME & ")"
						MYFILEOPENDIALOG ( $SMYDEFAULTSEARCHPATH , $MYDEFEXTENSIONFILE , $MYDEFEXTENSIONFILENAME )
						$MYINPATH = $SMYFILEOPENDIALOG1
					EndIf
					Local $IFILEEXISTS = FileExists ( $MYINPATH )
					If $IFILEEXISTS = 0 Then
						MEMOWRITE ( @CRLF & "---" & @CRLF & "Waitng for your command :)" & @CRLF & "---" )
					Else
						MYGLOBALPATTERNSEARCH ( $MYINPATH , $APATHSPLITPEA , $APATHSPLITEAC , $APATHSPLITFRONTEND )
					EndIf
				Case $MYIBUTTONCLICKED = 9
					If FileExists ( $MYINPATH ) = 0 Then
						$SMYFILEOPENDIALOG1 = ""
						$MYDEFEXTENSIONFILENAME = "public*.dll"
						$MYDEFEXTENSIONFILE = "(" & $MYDEFEXTENSIONFILENAME & ")"
						MYFILEOPENDIALOG ( $SMYDEFAULTSEARCHPATH , $MYDEFEXTENSIONFILE , $MYDEFEXTENSIONFILENAME )
						$MYINPATH = $SMYFILEOPENDIALOG1
					EndIf
					Local $IFILEEXISTS = FileExists ( $MYINPATH )
					If $IFILEEXISTS = 0 Then
						MEMOWRITE ( @CRLF & "---" & @CRLF & "Waitng for your command :)" & @CRLF & "---" )
					Else
						MYGLOBALPATTERNSEARCH ( $MYINPATH , $APATHSPLITPEA , $APATHSPLITEAC , $APATHSPLITFRONTEND )
					EndIf
				Case $MYIBUTTONCLICKED = 10
					If FileExists ( $MYINPATH ) = 0 Then
						$SMYFILEOPENDIALOG1 = ""
						$MYDEFEXTENSIONFILENAME = "lightroom*.exe"
						$MYDEFEXTENSIONFILE = "(" & $MYDEFEXTENSIONFILENAME & ")"
						MYFILEOPENDIALOG ( $SMYDEFAULTSEARCHPATH , $MYDEFEXTENSIONFILE , $MYDEFEXTENSIONFILENAME )
						$MYINPATH = $SMYFILEOPENDIALOG1
					EndIf
					Local $IFILEEXISTS = FileExists ( $MYINPATH )
					If $IFILEEXISTS = 0 Then
						MEMOWRITE ( @CRLF & "---" & @CRLF & "Waitng for your command :)" & @CRLF & "---" )
					Else
						MYGLOBALPATTERNSEARCH ( $MYINPATH , $APATHSPLITPEA , $APATHSPLITEAC , $APATHSPLITFRONTEND )
					EndIf
				Case $MYIBUTTONCLICKED = 11
					If FileExists ( $MYINPATH ) = 0 Then
						$SMYFILEOPENDIALOG1 = ""
						$MYDEFEXTENSIONFILENAME = "lightroom*.exe"
						$MYDEFEXTENSIONFILE = "(" & $MYDEFEXTENSIONFILENAME & ")"
						MYFILEOPENDIALOG ( $SMYDEFAULTSEARCHPATH , $MYDEFEXTENSIONFILE , $MYDEFEXTENSIONFILENAME )
						$MYINPATH = $SMYFILEOPENDIALOG1
					EndIf
					Local $IFILEEXISTS = FileExists ( $MYINPATH )
					If $IFILEEXISTS = 0 Then
						MEMOWRITE ( @CRLF & "---" & @CRLF & "Waitng for your command :)" & @CRLF & "---" )
					Else
						MYGLOBALPATTERNSEARCH ( $MYINPATH , $APATHSPLITPEA , $APATHSPLITEAC , $APATHSPLITFRONTEND )
					EndIf
				Case $MYIBUTTONCLICKED = 12
					If FileExists ( $MYINPATH ) = 0 Then
						$SMYFILEOPENDIALOG1 = ""
						$MYDEFEXTENSIONFILENAME = "Adobe Media Encoder*.exe"
						$MYDEFEXTENSIONFILE = "(" & $MYDEFEXTENSIONFILENAME & ")"
						MYFILEOPENDIALOG ( $SMYDEFAULTSEARCHPATH , $MYDEFEXTENSIONFILE , $MYDEFEXTENSIONFILENAME )
						$MYINPATH = $SMYFILEOPENDIALOG1
					EndIf
					Local $IFILEEXISTS = FileExists ( $MYINPATH )
					If $IFILEEXISTS = 0 Then
						MEMOWRITE ( @CRLF & "---" & @CRLF & "Waitng for your command :)" & @CRLF & "---" )
					Else
						Local $SDRIVE = "" , $SDIR = "" , $SFILENAME = "" , $SEXTENSION = "" , $APATHSPLIT = ""
						Local $IPATH = $MYINPATH
						Local $APATHSPLIT = _PATHSPLIT ( $IPATH , $SDRIVE , $SDIR , $SFILENAME , $SEXTENSION )
						$APATHSPLITPEA = $SDRIVE & $SDIR & "SweetPeaSupport.dll"
						$APATHSPLITEAC = $SDRIVE & $SDIR & "EAClient.dll"
						MYGLOBALPATTERNSEARCH ( $MYINPATH , $APATHSPLITPEA , $APATHSPLITEAC , $APATHSPLITFRONTEND )
					EndIf
				Case $MYIBUTTONCLICKED = 13
					If FileExists ( $MYINPATH ) = 0 Then
						$SMYFILEOPENDIALOG1 = ""
						$MYDEFEXTENSIONFILENAME = "photoshop*.exe"
						$MYDEFEXTENSIONFILE = "(" & $MYDEFEXTENSIONFILENAME & ")"
						MYFILEOPENDIALOG ( $SMYDEFAULTSEARCHPATH , $MYDEFEXTENSIONFILE , $MYDEFEXTENSIONFILENAME )
						$MYINPATH = $SMYFILEOPENDIALOG1
					EndIf
					Local $IFILEEXISTS = FileExists ( $MYINPATH )
					If $IFILEEXISTS = 0 Then
						MEMOWRITE ( @CRLF & "---" & @CRLF & "Waitng for your command :)" & @CRLF & "---" )
					Else
						MYGLOBALPATTERNSEARCH ( $MYINPATH , $APATHSPLITPEA , $APATHSPLITEAC , $APATHSPLITFRONTEND )
					EndIf
				Case $MYIBUTTONCLICKED = 14
					If FileExists ( $MYINPATH ) = 0 Then
						$SMYFILEOPENDIALOG1 = ""
						$MYDEFEXTENSIONFILENAME = "registration*.dll"
						$MYDEFEXTENSIONFILE = "(" & $MYDEFEXTENSIONFILENAME & ")"
						MYFILEOPENDIALOG ( $SMYDEFAULTSEARCHPATH , $MYDEFEXTENSIONFILE , $MYDEFEXTENSIONFILENAME )
						$MYINPATH = $SMYFILEOPENDIALOG1
					EndIf
					Local $IFILEEXISTS = FileExists ( $MYINPATH )
					If $IFILEEXISTS = 0 Then
						MEMOWRITE ( @CRLF & "---" & @CRLF & "Waitng for your command :)" & @CRLF & "---" )
					Else
						Local $SDRIVE = "" , $SDIR = "" , $SFILENAME = "" , $SEXTENSION = "" , $APATHSPLIT = ""
						Local $IPATH = $MYINPATH
						Local $APATHSPLIT = _PATHSPLIT ( $IPATH , $SDRIVE , $SDIR , $SFILENAME , $SEXTENSION )
						$APATHSPLITPEA = $SDRIVE & $SDIR & "SweetPeaSupport.dll"
						$APATHSPLITEAC = $SDRIVE & $SDIR & "EAClient.dll"
						MYGLOBALPATTERNSEARCH ( $MYINPATH , $APATHSPLITPEA , $APATHSPLITEAC , $APATHSPLITFRONTEND )
					EndIf
				Case $MYIBUTTONCLICKED = 15
					If FileExists ( $MYINPATH ) = 0 Then
						$SMYFILEOPENDIALOG1 = ""
						$MYDEFEXTENSIONFILENAME = "registration*.dll"
						$MYDEFEXTENSIONFILE = "(" & $MYDEFEXTENSIONFILENAME & ")"
						MYFILEOPENDIALOG ( $SMYDEFAULTSEARCHPATH , $MYDEFEXTENSIONFILE , $MYDEFEXTENSIONFILENAME )
						$MYINPATH = $SMYFILEOPENDIALOG1
					EndIf
					Local $IFILEEXISTS = FileExists ( $MYINPATH )
					If $IFILEEXISTS = 0 Then
						MEMOWRITE ( @CRLF & "---" & @CRLF & "Waitng for your command :)" & @CRLF & "---" )
					Else
						Local $SDRIVE = "" , $SDIR = "" , $SFILENAME = "" , $SEXTENSION = "" , $APATHSPLIT = ""
						Local $IPATH = $MYINPATH
						Local $APATHSPLIT = _PATHSPLIT ( $IPATH , $SDRIVE , $SDIR , $SFILENAME , $SEXTENSION )
						$APATHSPLITPEA = $SDRIVE & $SDIR & "SweetPeaSupport.dll"
						$APATHSPLITEAC = $SDRIVE & $SDIR & "EAClient.dll"
						MYGLOBALPATTERNSEARCH ( $MYINPATH , $APATHSPLITPEA , $APATHSPLITEAC , $APATHSPLITFRONTEND )
					EndIf
				Case $MYIBUTTONCLICKED = 16
					If FileExists ( $MYINPATH ) = 0 Then
						$SMYFILEOPENDIALOG1 = ""
						$MYDEFEXTENSIONFILENAME = "registration*.dll"
						$MYDEFEXTENSIONFILE = "(" & $MYDEFEXTENSIONFILENAME & ")"
						MYFILEOPENDIALOG ( $SMYDEFAULTSEARCHPATH , $MYDEFEXTENSIONFILE , $MYDEFEXTENSIONFILENAME )
						$MYINPATH = $SMYFILEOPENDIALOG1
					EndIf
					Local $IFILEEXISTS = FileExists ( $MYINPATH )
					If $IFILEEXISTS = 0 Then
						MEMOWRITE ( @CRLF & "---" & @CRLF & "Waitng for your command :)" & @CRLF & "---" )
					Else
						Local $SDRIVE = "" , $SDIR = "" , $SFILENAME = "" , $SEXTENSION = "" , $APATHSPLIT = ""
						Local $IPATH = $MYINPATH
						Local $APATHSPLIT = _PATHSPLIT ( $IPATH , $SDRIVE , $SDIR , $SFILENAME , $SEXTENSION )
						$APATHSPLITPEA = $SDRIVE & $SDIR & "SweetPeaSupport.dll"
						$APATHSPLITEAC = $SDRIVE & $SDIR & "EAClient.dll"
						MYGLOBALPATTERNSEARCH ( $MYINPATH , $APATHSPLITPEA , $APATHSPLITEAC , $APATHSPLITFRONTEND )
					EndIf
				Case $MYIBUTTONCLICKED = 17
					If FileExists ( $MYINPATH ) = 0 Then
						$SMYFILEOPENDIALOG1 = ""
						$MYDEFEXTENSIONFILENAME = "Acrobat*.dll"
						$MYDEFEXTENSIONFILE = "(" & $MYDEFEXTENSIONFILENAME & ")"
						MYFILEOPENDIALOG ( $SMYDEFAULTSEARCHPATH , $MYDEFEXTENSIONFILE , $MYDEFEXTENSIONFILENAME )
						$MYINPATH = $SMYFILEOPENDIALOG1
					EndIf
					Local $IFILEEXISTS = FileExists ( $MYINPATH )
					If $IFILEEXISTS = 0 Then
						MEMOWRITE ( @CRLF & "---" & @CRLF & "Waitng for your command :)" & @CRLF & "---" )
					Else
						Local $SDRIVE = "" , $SDIR = "" , $SFILENAME = "" , $SEXTENSION = "" , $APATHSPLIT = ""
						Local $IPATH = $MYINPATH
						Local $APATHSPLIT = _PATHSPLIT ( $IPATH , $SDRIVE , $SDIR , $SFILENAME , $SEXTENSION )
						$APATHSPLITACRODIST = $SDRIVE & $SDIR & "acrodistdll.dll"
						$APATHSPLITACROTRAY = $SDRIVE & $SDIR & "acrotray.exe"
						$APATHSPLITFRONTEND = $SDRIVE & $SDIR & "amtlib.dll"
						MYGLOBALPATTERNSEARCH ( $MYINPATH , $APATHSPLITACRODIST , $APATHSPLITACROTRAY , $APATHSPLITFRONTEND )
					EndIf
				Case $MYIBUTTONCLICKED = 18
					If FileExists ( $MYINPATH ) = 0 Then
						$SMYFILEOPENDIALOG1 = ""
						$MYDEFEXTENSIONFILENAME = "euclid-core-plugin*.pepper"
						$MYDEFEXTENSIONFILE = "(" & $MYDEFEXTENSIONFILENAME & ")"
						MYFILEOPENDIALOG ( $SMYDEFAULTSEARCHPATH , $MYDEFEXTENSIONFILE , $MYDEFEXTENSIONFILENAME )
						$MYINPATH = $SMYFILEOPENDIALOG1
					EndIf
					Local $IFILEEXISTS = FileExists ( $MYINPATH )
					If $IFILEEXISTS = 0 Then
						MEMOWRITE ( @CRLF & "---" & @CRLF & "Waitng for your command :)" & @CRLF & "---" )
					Else
						Local $SDRIVE = "" , $SDIR = "" , $SFILENAME = "" , $SEXTENSION = "" , $APATHSPLIT = ""
						Local $IPATH = $MYINPATH
						Local $APATHSPLIT = _PATHSPLIT ( $IPATH , $SDRIVE , $SDIR , $SFILENAME , $SEXTENSION )
						$APATHSPLITPEA = $SDRIVE & $SDIR & "SweetPeaSupport.dll"
						$APATHSPLITEAC = $SDRIVE & $SDIR & "EAClient.dll"
						MYGLOBALPATTERNSEARCH ( $MYINPATH , $APATHSPLITPEA , $APATHSPLITEAC , $APATHSPLITFRONTEND )
					EndIf
				Case $MYIBUTTONCLICKED = 19
					If FileExists ( $MYINPATH ) = 0 Then
						$SMYDEFAULTSEARCHPATH = ""
						$SMYDEFAULTSEARCHPATH = "C:\Program Files\WindowsApps"
						$SMYFILEOPENDIALOG1 = ""
						$MYDEFEXTENSIONFILENAME = "XD*.exe"
						$MYDEFEXTENSIONFILE = "(" & $MYDEFEXTENSIONFILENAME & ")"
						MYFILEOPENDIALOG ( $SMYDEFAULTSEARCHPATH , $MYDEFEXTENSIONFILE , $MYDEFEXTENSIONFILENAME )
						$MYINPATH = $SMYFILEOPENDIALOG1
						$SMYDEFAULTSEARCHPATH = ""
						$SMYDEFAULTSEARCHPATH = "C:\Program Files\Adobe"
					EndIf
					Local $IFILEEXISTS = FileExists ( $MYINPATH )
					If $IFILEEXISTS = 0 Then
						MEMOWRITE ( @CRLF & "---" & @CRLF & "Waitng for your command :)" & @CRLF & "---" )
					Else
						MYGLOBALPATTERNSEARCH ( $MYINPATH , $APATHSPLITPEA , $APATHSPLITEAC , $APATHSPLITFRONTEND )
					EndIf
				Case $MYIBUTTONCLICKED = 20
					If FileExists ( $MYINPATH ) = 0 Then
						$SMYDEFAULTSEARCHPATH = ""
						$SMYDEFAULTSEARCHPATH = "C:\Program Files\WindowsApps"
						$SMYFILEOPENDIALOG1 = ""
						$MYDEFEXTENSIONFILENAME = "ngl-lib*.dll"
						$MYDEFEXTENSIONFILE = "(" & $MYDEFEXTENSIONFILENAME & ")"
						MYFILEOPENDIALOG ( $SMYDEFAULTSEARCHPATH , $MYDEFEXTENSIONFILE , $MYDEFEXTENSIONFILENAME )
						$MYINPATH = $SMYFILEOPENDIALOG1
						$SMYDEFAULTSEARCHPATH = ""
						$SMYDEFAULTSEARCHPATH = "C:\Program Files\Adobe"
					EndIf
					Local $IFILEEXISTS = FileExists ( $MYINPATH )
					If $IFILEEXISTS = 0 Then
						MEMOWRITE ( @CRLF & "---" & @CRLF & "Waitng for your command :)" & @CRLF & "---" )
					Else
						MYGLOBALPATTERNSEARCH ( $MYINPATH , $APATHSPLITPEA , $APATHSPLITEAC , $APATHSPLITFRONTEND )
					EndIf
				Case $MYIBUTTONCLICKED = 21
					If FileExists ( $MYINPATH ) = 0 Then
						$SMYFILEOPENDIALOG1 = ""
						$MYDEFEXTENSIONFILENAME = "amtlib.dll"
						$MYDEFEXTENSIONFILE = "(" & $MYDEFEXTENSIONFILENAME & ")"
						MYFILEOPENDIALOG ( $SMYDEFAULTSEARCHPATH , $MYDEFEXTENSIONFILE , $MYDEFEXTENSIONFILENAME )
						$MYINPATH = $SMYFILEOPENDIALOG1
					EndIf
					Local $IFILEEXISTS = FileExists ( $MYINPATH )
					If $IFILEEXISTS = 0 Then
						MEMOWRITE ( @CRLF & "---" & @CRLF & "Waitng for your command :)" & @CRLF & "---" )
					Else
						MYGLOBALPATTERNSEARCH ( $MYINPATH , $APATHSPLITPEA , $APATHSPLITEAC , $APATHSPLITFRONTEND )
					EndIf
				Case $MYIBUTTONCLICKED = 22
					If FileExists ( $MYINPATH ) = 0 Then
						$SMYFILEOPENDIALOG1 = ""
						$MYDEFEXTENSIONFILENAME = "amtlib.dll"
						$MYDEFEXTENSIONFILE = "(" & $MYDEFEXTENSIONFILENAME & ")"
						MYFILEOPENDIALOG ( $SMYDEFAULTSEARCHPATH , $MYDEFEXTENSIONFILE , $MYDEFEXTENSIONFILENAME )
						$MYINPATH = $SMYFILEOPENDIALOG1
					EndIf
					Local $IFILEEXISTS = FileExists ( $MYINPATH )
					If $IFILEEXISTS = 0 Then
						MEMOWRITE ( @CRLF & "---" & @CRLF & "Waitng for your command :)" & @CRLF & "---" )
					Else
						MYGLOBALPATTERNSEARCH ( $MYINPATH , $APATHSPLITPEA , $APATHSPLITEAC , $APATHSPLITFRONTEND )
					EndIf
				Case $MYIBUTTONCLICKED = 23
					MEMOWRITE ( @CRLF & "---" & @CRLF & "Waitng for your command :)" & @CRLF & "---" )
				Case $MYIBUTTONCLICKED = 24
					If FileExists ( $MYINPATH ) = 0 Then
						$SMYFILEOPENDIALOG1 = ""
						$SMYDEFAULTSEARCHPATH = "C:\Program Files (x86)\Adobe\Adobe Creative Cloud\AppsPanel"
						$MYDEFEXTENSIONFILENAME = "AppsPanelBL.dll"
						$MYDEFEXTENSIONFILE = "(" & $MYDEFEXTENSIONFILENAME & ")"
						MYFILEOPENDIALOG ( $SMYDEFAULTSEARCHPATH , $MYDEFEXTENSIONFILE , $MYDEFEXTENSIONFILENAME )
						$MYINPATH = $SMYFILEOPENDIALOG1
					EndIf
					Local $IFILEEXISTS = FileExists ( $MYINPATH )
					If $IFILEEXISTS = 0 Then
						MEMOWRITE ( @CRLF & "---" & @CRLF & "Waitng for your command :)" & @CRLF & "---" )
					Else
						Local $SPIDHANDLE = ProcessExists ( "Adobe Desktop Service.exe" )
						$SPIDHANDLE = _WINAPI_OPENPROCESS ( 1 , 0 , $SPIDHANDLE )
						DllCall ( "kernel32.dll" , "int" , "TerminateProcess" , "int" , $SPIDHANDLE , "int" , 1 )
						$SPIDHANDLE = ProcessExists ( "Creative Cloud.exe" )
						$SPIDHANDLE = _WINAPI_OPENPROCESS ( 1 , 0 , $SPIDHANDLE )
						DllCall ( "kernel32.dll" , "int" , "TerminateProcess" , "int" , $SPIDHANDLE , "int" , 1 )
						MYGLOBALPATTERNSEARCH ( $MYINPATH , $APATHSPLITPEA , $APATHSPLITEAC , $APATHSPLITFRONTEND )
					EndIf
				EndSelect
			Else
				$MYIBUTTONCLICKED = 0
				$MYINPATH = ""
			EndIf
			If $A_IDCHKSTATE [ $X ] = 1 Then
				WinWaitClose ( "GenPPP-2.7" , "" )
			Else
			EndIf
			GUICtrlSetState ( $A_IDCHK [ $X ] , 4 )
		Next
		For $X = 0 To 23
			GUICtrlSetState ( $A_IDCHK [ $X ] , 64 )
		Next
		GUICtrlSetData ( $MYOWNIDPROGRESS , 0 )
		GUICtrlSetState ( $IDBUTTON_PATH2019 , 64 )
		GUICtrlSetState ( $IDBUTTON_PATH2020 , 64 )
		GUICtrlSetState ( $IDBUTTON_PATH2021 , 64 )
		GUICtrlSetState ( $IDBUTTON_PATH2022 , 64 )
		GUICtrlSetState ( $G_IDDESELECTALL , 64 )
		GUICtrlSetState ( $IDBTNCURE , 64 )
		$A_IDPATH = $A_IDPATHNULL
		FILLARRAYPATHNULL ( )
		For $X = 0 To 23
			GUICtrlSetState ( $A_IDCHK [ $X ] , 4 )
			_ARRAYADD ( $A_IDPATH , "" )
		Next
		_DISABLEPROBLEMATICAPPS ( )
		$MYIBUTTONCLICKED = 0
		MEMOWRITE ( @CRLF & "---" & @CRLF & "Manual mode - custom path" & @CRLF & "---" )
	EndSelect
WEnd
Func MAINGUI ( )
	$MYHGUI = GUICreate ( "Adobe-GenP-2.7" , 540 , 600 , + 4294967295 , + 4294967295 , BitOR ( $WS_CAPTION , $WS_MINIMIZEBOX , $WS_EX_APPWINDOW , $DS_SETFOREGROUND ) )
	Local $STYLE = _WINAPI_GETWINDOWLONG ( $MYHGUI , $GWL_STYLE )
	If BitAND ( $STYLE , BitOR ( $WS_SIZEBOX , $WS_MAXIMIZEBOX ) ) Then
		_WINAPI_SETWINDOWLONG ( $MYHGUI , $GWL_STYLE , BitXOR ( $STYLE , $WS_SIZEBOX ) )
	EndIf
	GUISetState ( @SW_SHOW )
	$Y = 80
	For $X = 0 To 7
		$A_IDCHK [ $X ] = GUICtrlCreateCheckbox ( "" , 50 , $Y + 4294967236 , 120 , 25 )
		GUICtrlCreatePic ( ".\ICONS\" & $X & ".jpg" , 20 , $Y + 4294967238 , 24 , 24 )
		GUICtrlSetState ( $A_IDCHK [ $X ] , 4 )
		$Y += 40
	Next
	$Y = 80
	For $X = 8 To 15
		$A_IDCHK [ $X ] = GUICtrlCreateCheckbox ( "" , 230 , $Y + 4294967236 , 120 , 25 )
		GUICtrlCreatePic ( ".\ICONS\" & $X & ".jpg" , 200 , $Y + 4294967238 , 24 , 24 )
		GUICtrlSetState ( $A_IDCHK [ $X ] , 4 )
		$Y += 40
	Next
	$Y = 80
	For $X = 16 To 23
		$A_IDCHK [ $X ] = GUICtrlCreateCheckbox ( "" , 410 , $Y + 4294967236 , 120 , 25 )
		GUICtrlCreatePic ( ".\ICONS\" & $X & ".jpg" , 380 , $Y + 4294967238 , 24 , 24 )
		GUICtrlSetState ( $A_IDCHK [ $X ] , 4 )
		$Y += 40
	Next
	_DISABLEPROBLEMATICAPPS ( )
	$IDBUTTON_PATH2019 = GUICtrlCreateButton ( "CC2019" , 30 , 380 , 80 , 20 )
	GUICtrlSetTip ( + 4294967295 , "Let GenP find CC2019 Apps automatically in def location" )
	$IDBUTTON_PATH2020 = GUICtrlCreateButton ( "CC2020" , 130 , 380 , 80 , 20 )
	GUICtrlSetTip ( + 4294967295 , "Let GenP find CC2020 Apps automatically in def location" )
	$G_IDDESELECTALL = GUICtrlCreateButton ( "" , 230 , 380 , 80 , 20 )
	GUICtrlSetData ( $G_IDDESELECTALL , "Reset Paths" )
	GUICtrlSetTip ( + 4294967295 , "Reset ALL paths - Manual mode" )
	$IDBUTTON_PATH2021 = GUICtrlCreateButton ( "CC2021" , 330 , 380 , 80 , 20 )
	GUICtrlSetTip ( + 4294967295 , "Let GenP find CC2021 Apps automatically in def location" )
	$IDBUTTON_PATH2022 = GUICtrlCreateButton ( "CC2022" , 430 , 380 , 80 , 20 )
	GUICtrlSetTip ( + 4294967295 , "Let GenP find CC2022 Apps automatically in def location" )
	$MYOWNIDPROGRESS = GUICtrlCreateProgress ( 170 , 350 , 200 , 10 , $PBS_SMOOTHREVERSE )
	$G_IDMEMO = GUICtrlCreateEdit ( "" , 20 , 420 , 500 , 80 , BitOR ( $ES_READONLY , $ES_CENTER , $WS_DISABLED ) )
	MEMOWRITE ( @CRLF & "---" & @CRLF & "Manual mode - custom path" & @CRLF & "---" )
	$IDBTNCURE = GUICtrlCreateButton ( "" , 240 , 520 , 56 , 56 , $BS_BITMAP )
	_GUICTRLBUTTON_SETIMAGE ( $IDBTNCURE , ".\ICONS\Cure.bmp" )
	GUICtrlSetTip ( + 4294967295 , "Cure" )
	GUICtrlSetData ( $A_IDCHK [ 0 ] , "1. After Effects" )
	GUICtrlSetData ( $A_IDCHK [ 1 ] , "2. Animate" )
	GUICtrlSetData ( $A_IDCHK [ 2 ] , "3. Audition" )
	GUICtrlSetData ( $A_IDCHK [ 3 ] , "4. Bridge" )
	GUICtrlSetData ( $A_IDCHK [ 4 ] , "5. Character Animator" )
	GUICtrlSetData ( $A_IDCHK [ 5 ] , "6. Dreamweaver" )
	GUICtrlSetData ( $A_IDCHK [ 6 ] , "7. Illustrator" )
	GUICtrlSetData ( $A_IDCHK [ 7 ] , "8. InCopy" )
	GUICtrlSetData ( $A_IDCHK [ 8 ] , "9. InDesign" )
	GUICtrlSetData ( $A_IDCHK [ 9 ] , "10. Lightroom" )
	GUICtrlSetData ( $A_IDCHK [ 10 ] , "11. Lightroom Classic" )
	GUICtrlSetData ( $A_IDCHK [ 11 ] , "12. Media Encoder" )
	GUICtrlSetData ( $A_IDCHK [ 12 ] , "13. Photoshop" )
	GUICtrlSetData ( $A_IDCHK [ 13 ] , "14. Prelude" )
	GUICtrlSetData ( $A_IDCHK [ 14 ] , "15. Premiere Pro" )
	GUICtrlSetData ( $A_IDCHK [ 15 ] , "16. Premiere Rush" )
	GUICtrlSetData ( $A_IDCHK [ 16 ] , "17. Acrobat" )
	GUICtrlSetData ( $A_IDCHK [ 17 ] , "18. Dimension" )
	GUICtrlSetData ( $A_IDCHK [ 18 ] , "19. XD" )
	GUICtrlSetData ( $A_IDCHK [ 19 ] , "20. Fresco" )
	GUICtrlSetData ( $A_IDCHK [ 20 ] , "21. Flash Builder" )
	GUICtrlSetData ( $A_IDCHK [ 21 ] , "22. Speed Grade" )
	GUICtrlSetData ( $A_IDCHK [ 22 ] , "-----------------------" )
	GUICtrlSetState ( $A_IDCHK [ 22 ] , 160 )
	GUICtrlSetData ( $A_IDCHK [ 23 ] , "24. Creative Cloud" )
EndFunc
Func FILLARRAYPATHNULL ( )
EndFunc
Func FILLARRAYPATH2019 ( )
	_ARRAYADD ( $A_IDPATH , $MYDEFPATH & "\Adobe After Effects CC 2019\Support Files\AfterFXLib.dll" )
	_ARRAYADD ( $A_IDPATH , $MYDEFPATH & "\Adobe Animate CC 2019\Animate.exe" )
	_ARRAYADD ( $A_IDPATH , $MYDEFPATH & "\Adobe Audition CC 2019\auui.dll" )
	_ARRAYADD ( $A_IDPATH , $MYDEFPATH & "\Adobe Bridge CC 2019\bridge.exe" )
	_ARRAYADD ( $A_IDPATH , $MYDEFPATH & "\Adobe Character Animator CC 2019\Support Files\character animator.exe" )
	_ARRAYADD ( $A_IDPATH , $MYDEFPATH & "\Adobe Dreamweaver CC 2019\dreamweaver.exe" )
	_ARRAYADD ( $A_IDPATH , $MYDEFPATH & "\Adobe Illustrator CC 2019\Support Files\Contents\Windows\illustrator.exe" )
	_ARRAYADD ( $A_IDPATH , $MYDEFPATH & "\Adobe InCopy CC 2019\public.dll" )
	_ARRAYADD ( $A_IDPATH , $MYDEFPATH & "\Adobe InDesign CC 2019\public.dll" )
	Local $SFILENAMETEMPLR = FileFindNextFile ( FileFindFirstFile ( $MYDEFPATH & "\Adobe Lightroom CC\lightroomcc.exe" ) )
	$SFILENAMETEMPLR = $MYDEFPATH & "\Adobe Lightroom CC\lightroomcc.exe"
	If FileExists ( $SFILENAMETEMPLR ) = 1 Then
		$SFILENAMETEMPLR = $MYDEFPATH & "\Adobe Lightroom CC\lightroomcc.exe"
	Else
		$SFILENAMETEMPLR = FileFindNextFile ( FileFindFirstFile ( $MYDEFPATH & "\Adobe Lightroom CC\lightroom.exe" ) )
		$SFILENAMETEMPLR = $MYDEFPATH & "\Adobe Lightroom CC\lightroom.exe"
	EndIf
	_ARRAYADD ( $A_IDPATH , $SFILENAMETEMPLR )
	Local $SFILENAMETEMPLRCC = FileFindNextFile ( FileFindFirstFile ( $MYDEFPATH & "\Adobe Lightroom Classic CC\lightroom.exe" ) )
	$SFILENAMETEMPLRCC = $MYDEFPATH & "\Adobe Lightroom Classic CC\lightroom.exe"
	If FileExists ( $SFILENAMETEMPLRCC ) = 1 Then
		$SFILENAMETEMPLRCC = $MYDEFPATH & "\Adobe Lightroom Classic CC\lightroom.exe"
	Else
		$SFILENAMETEMPLRCC = FileFindNextFile ( FileFindFirstFile ( $MYDEFPATH & "\Adobe Lightroom Classic\lightroom.exe" ) )
		$SFILENAMETEMPLRCC = $MYDEFPATH & "\Adobe Lightroom Classic\lightroom.exe"
	EndIf
	_ARRAYADD ( $A_IDPATH , $SFILENAMETEMPLRCC )
	_ARRAYADD ( $A_IDPATH , $MYDEFPATH & "\Adobe Media Encoder CC 2019\Adobe Media Encoder.exe" )
	_ARRAYADD ( $A_IDPATH , $MYDEFPATH & "\Adobe Photoshop CC 2019\photoshop.exe" )
	_ARRAYADD ( $A_IDPATH , $MYDEFPATH & "\Adobe Prelude CC 2019\registration.dll" )
	_ARRAYADD ( $A_IDPATH , $MYDEFPATH & "\Adobe Premiere Pro CC 2019\registration.dll" )
	_ARRAYADD ( $A_IDPATH , $MYDEFPATH & "\Adobe Premiere Rush CC\registration.dll" )
	_ARRAYADD ( $A_IDPATH , "C:\Program Files (x86)\Adobe\Acrobat DC\Acrobat\Acrobat.dll" )
	_ARRAYADD ( $A_IDPATH , $MYDEFPATH & "\Adobe Dimension CC\euclid-core-plugin.pepper" )
	Local $SFILENAMETEMPXD = FileFindNextFile ( FileFindFirstFile ( "C:\Program Files\WindowsApps\Adobe.CC.XD*" ) )
	Local $MYINPATHTEMPXD0 = "C:\Program Files\WindowsApps\" & $SFILENAMETEMPXD & "\XD*.exe"
	Local $SFILENAMETEMPXD1 = FileFindNextFile ( FileFindFirstFile ( $MYINPATHTEMPXD0 ) )
	If $SFILENAMETEMPXD1 = "" Then
		_ARRAYADD ( $A_IDPATH , "" )
	Else
		Local $SFILENAMETEMPXD2 = "C:\Program Files\WindowsApps\" & $SFILENAMETEMPXD & "\" & $SFILENAMETEMPXD1
		_ARRAYADD ( $A_IDPATH , $SFILENAMETEMPXD2 )
	EndIf
	Local $SFILENAMETEMPFR = FileFindNextFile ( FileFindFirstFile ( "C:\Program Files\WindowsApps\Adobe.Fresco*" ) )
	Local $MYINPATHTEMPFR0 = "C:\Program Files\WindowsApps\" & $SFILENAMETEMPFR & "\ngl-lib.dll"
	Local $SFILENAMETEMPFR1 = FileFindNextFile ( FileFindFirstFile ( $MYINPATHTEMPFR0 ) )
	If $SFILENAMETEMPFR1 = "" Then
		_ARRAYADD ( $A_IDPATH , "" )
	Else
		Local $SFILENAMETEMPFR2 = "C:\Program Files\WindowsApps\" & $SFILENAMETEMPFR & "\" & $SFILENAMETEMPFR1
		_ARRAYADD ( $A_IDPATH , $SFILENAMETEMPFR2 )
	EndIf
	_ARRAYADD ( $A_IDPATH , $MYDEFPATH & "\Adobe Flash Builder 4.7 (64 Bit)\eclipse\plugins\com.adobe.flexide.amt_4.7.0.349722\os\win32\x86_64\amtlib.dll" )
	_ARRAYADD ( $A_IDPATH , $MYDEFPATH & "\Adobe SpeedGrade CC 2015\amtlib.dll" )
	_ARRAYADD ( $A_IDPATH , $MYDEFPATH & "" )
	_ARRAYADD ( $A_IDPATH , "C:\Program Files (x86)\Adobe\Adobe Creative Cloud\AppsPanel\AppsPanelBL.dll" )
EndFunc
Func FILLARRAYPATH2020 ( )
	_ARRAYADD ( $A_IDPATH , $MYDEFPATH & "\Adobe After Effects 2020\Support Files\AfterFXLib.dll" )
	_ARRAYADD ( $A_IDPATH , $MYDEFPATH & "\Adobe Animate 2020\Animate.exe" )
	_ARRAYADD ( $A_IDPATH , $MYDEFPATH & "\Adobe Audition 2020\auui.dll" )
	_ARRAYADD ( $A_IDPATH , $MYDEFPATH & "\Adobe Bridge 2020\bridge.exe" )
	_ARRAYADD ( $A_IDPATH , $MYDEFPATH & "\Adobe Character Animator 2020\Support Files\character animator.exe" )
	_ARRAYADD ( $A_IDPATH , $MYDEFPATH & "\Adobe Dreamweaver 2020\dreamweaver.exe" )
	_ARRAYADD ( $A_IDPATH , $MYDEFPATH & "\Adobe Illustrator 2020\Support Files\Contents\Windows\illustrator.exe" )
	_ARRAYADD ( $A_IDPATH , $MYDEFPATH & "\Adobe InCopy 2020\public.dll" )
	_ARRAYADD ( $A_IDPATH , $MYDEFPATH & "\Adobe InDesign 2020\public.dll" )
	Local $SFILENAMETEMPLR = FileFindNextFile ( FileFindFirstFile ( $MYDEFPATH & "\Adobe Lightroom CC\lightroomcc.exe" ) )
	$SFILENAMETEMPLR = $MYDEFPATH & "\Adobe Lightroom CC\lightroomcc.exe"
	If FileExists ( $SFILENAMETEMPLR ) = 1 Then
		$SFILENAMETEMPLR = $MYDEFPATH & "\Adobe Lightroom CC\lightroomcc.exe"
	Else
		$SFILENAMETEMPLR = FileFindNextFile ( FileFindFirstFile ( $MYDEFPATH & "\Adobe Lightroom CC\lightroom.exe" ) )
		$SFILENAMETEMPLR = $MYDEFPATH & "\Adobe Lightroom CC\lightroom.exe"
	EndIf
	_ARRAYADD ( $A_IDPATH , $SFILENAMETEMPLR )
	Local $SFILENAMETEMPLRCC = FileFindNextFile ( FileFindFirstFile ( $MYDEFPATH & "\Adobe Lightroom Classic CC\lightroom.exe" ) )
	$SFILENAMETEMPLRCC = $MYDEFPATH & "\Adobe Lightroom Classic CC\lightroom.exe"
	If FileExists ( $SFILENAMETEMPLRCC ) = 1 Then
		$SFILENAMETEMPLRCC = $MYDEFPATH & "\Adobe Lightroom Classic CC\lightroom.exe"
	Else
		$SFILENAMETEMPLRCC = FileFindNextFile ( FileFindFirstFile ( $MYDEFPATH & "\Adobe Lightroom Classic\lightroom.exe" ) )
		$SFILENAMETEMPLRCC = $MYDEFPATH & "\Adobe Lightroom Classic\lightroom.exe"
	EndIf
	_ARRAYADD ( $A_IDPATH , $SFILENAMETEMPLRCC )
	_ARRAYADD ( $A_IDPATH , $MYDEFPATH & "\Adobe Media Encoder 2020\Adobe Media Encoder.exe" )
	_ARRAYADD ( $A_IDPATH , $MYDEFPATH & "\Adobe Photoshop 2020\photoshop.exe" )
	_ARRAYADD ( $A_IDPATH , $MYDEFPATH & "\Adobe Prelude 2020\registration.dll" )
	_ARRAYADD ( $A_IDPATH , $MYDEFPATH & "\Adobe Premiere Pro 2020\registration.dll" )
	_ARRAYADD ( $A_IDPATH , $MYDEFPATH & "\Adobe Premiere Rush\registration.dll" )
	_ARRAYADD ( $A_IDPATH , "C:\Program Files (x86)\Adobe\Acrobat DC\Acrobat\Acrobat.dll" )
	_ARRAYADD ( $A_IDPATH , $MYDEFPATH & "\Adobe Dimension\euclid-core-plugin.pepper" )
	Local $SFILENAMETEMPXD = FileFindNextFile ( FileFindFirstFile ( "C:\Program Files\WindowsApps\Adobe.CC.XD*" ) )
	Local $MYINPATHTEMPXD0 = "C:\Program Files\WindowsApps\" & $SFILENAMETEMPXD & "\XD*.exe"
	Local $SFILENAMETEMPXD1 = FileFindNextFile ( FileFindFirstFile ( $MYINPATHTEMPXD0 ) )
	If $SFILENAMETEMPXD1 = "" Then
		_ARRAYADD ( $A_IDPATH , "" )
	Else
		Local $SFILENAMETEMPXD2 = "C:\Program Files\WindowsApps\" & $SFILENAMETEMPXD & "\" & $SFILENAMETEMPXD1
		_ARRAYADD ( $A_IDPATH , $SFILENAMETEMPXD2 )
	EndIf
	Local $SFILENAMETEMPFR = FileFindNextFile ( FileFindFirstFile ( "C:\Program Files\WindowsApps\Adobe.Fresco*" ) )
	Local $MYINPATHTEMPFR0 = "C:\Program Files\WindowsApps\" & $SFILENAMETEMPFR & "\ngl-lib.dll"
	Local $SFILENAMETEMPFR1 = FileFindNextFile ( FileFindFirstFile ( $MYINPATHTEMPFR0 ) )
	If $SFILENAMETEMPFR1 = "" Then
		_ARRAYADD ( $A_IDPATH , "" )
	Else
		Local $SFILENAMETEMPFR2 = "C:\Program Files\WindowsApps\" & $SFILENAMETEMPFR & "\" & $SFILENAMETEMPFR1
		_ARRAYADD ( $A_IDPATH , $SFILENAMETEMPFR2 )
	EndIf
	_ARRAYADD ( $A_IDPATH , $MYDEFPATH & "\Adobe Flash Builder 4.7 (64 Bit)\eclipse\plugins\com.adobe.flexide.amt_4.7.0.349722\os\win32\x86_64\amtlib.dll" )
	_ARRAYADD ( $A_IDPATH , $MYDEFPATH & "\Adobe SpeedGrade CC 2015\amtlib.dll" )
	_ARRAYADD ( $A_IDPATH , $MYDEFPATH & "" )
	_ARRAYADD ( $A_IDPATH , "C:\Program Files (x86)\Common Files\Adobe\Adobe Desktop Common\AppsPanel\AppsPanelBL.dll" )
EndFunc
Func FILLARRAYPATH2021 ( )
	_ARRAYADD ( $A_IDPATH , $MYDEFPATH & "\Adobe After Effects 2021\Support Files\AfterFXLib.dll" )
	_ARRAYADD ( $A_IDPATH , $MYDEFPATH & "\Adobe Animate 2021\Animate.exe" )
	_ARRAYADD ( $A_IDPATH , $MYDEFPATH & "\Adobe Audition 2021\auui.dll" )
	_ARRAYADD ( $A_IDPATH , $MYDEFPATH & "\Adobe Bridge 2021\bridge.exe" )
	_ARRAYADD ( $A_IDPATH , $MYDEFPATH & "\Adobe Character Animator 2021\Support Files\character animator.exe" )
	_ARRAYADD ( $A_IDPATH , $MYDEFPATH & "\Adobe Dreamweaver 2021\dreamweaver.exe" )
	_ARRAYADD ( $A_IDPATH , $MYDEFPATH & "\Adobe Illustrator 2021\Support Files\Contents\Windows\illustrator.exe" )
	_ARRAYADD ( $A_IDPATH , $MYDEFPATH & "\Adobe InCopy 2021\public.dll" )
	_ARRAYADD ( $A_IDPATH , $MYDEFPATH & "\Adobe InDesign 2021\public.dll" )
	Local $SFILENAMETEMPLR = FileFindNextFile ( FileFindFirstFile ( $MYDEFPATH & "\Adobe Lightroom CC\lightroomcc.exe" ) )
	$SFILENAMETEMPLR = $MYDEFPATH & "\Adobe Lightroom CC\lightroomcc.exe"
	If FileExists ( $SFILENAMETEMPLR ) = 1 Then
		$SFILENAMETEMPLR = $MYDEFPATH & "\Adobe Lightroom CC\lightroomcc.exe"
	Else
		$SFILENAMETEMPLR = FileFindNextFile ( FileFindFirstFile ( $MYDEFPATH & "\Adobe Lightroom CC\lightroom.exe" ) )
		$SFILENAMETEMPLR = $MYDEFPATH & "\Adobe Lightroom CC\lightroom.exe"
	EndIf
	_ARRAYADD ( $A_IDPATH , $SFILENAMETEMPLR )
	Local $SFILENAMETEMPLRCC = FileFindNextFile ( FileFindFirstFile ( $MYDEFPATH & "\Adobe Lightroom Classic CC\lightroom.exe" ) )
	$SFILENAMETEMPLRCC = $MYDEFPATH & "\Adobe Lightroom Classic CC\lightroom.exe"
	If FileExists ( $SFILENAMETEMPLRCC ) = 1 Then
		$SFILENAMETEMPLRCC = $MYDEFPATH & "\Adobe Lightroom Classic CC\lightroom.exe"
	Else
		$SFILENAMETEMPLRCC = FileFindNextFile ( FileFindFirstFile ( $MYDEFPATH & "\Adobe Lightroom Classic\lightroom.exe" ) )
		$SFILENAMETEMPLRCC = $MYDEFPATH & "\Adobe Lightroom Classic\lightroom.exe"
	EndIf
	_ARRAYADD ( $A_IDPATH , $SFILENAMETEMPLRCC )
	_ARRAYADD ( $A_IDPATH , $MYDEFPATH & "\Adobe Media Encoder 2021\Adobe Media Encoder.exe" )
	_ARRAYADD ( $A_IDPATH , $MYDEFPATH & "\Adobe Photoshop 2021\photoshop.exe" )
	_ARRAYADD ( $A_IDPATH , $MYDEFPATH & "\Adobe Prelude 2021\registration.dll" )
	_ARRAYADD ( $A_IDPATH , $MYDEFPATH & "\Adobe Premiere Pro 2021\registration.dll" )
	_ARRAYADD ( $A_IDPATH , $MYDEFPATH & "\Adobe Premiere Rush\registration.dll" )
	_ARRAYADD ( $A_IDPATH , "C:\Program Files (x86)\Adobe\Acrobat DC\Acrobat\Acrobat.dll" )
	_ARRAYADD ( $A_IDPATH , $MYDEFPATH & "\Adobe Dimension\euclid-core-plugin.pepper" )
	Local $SFILENAMETEMPXD = FileFindNextFile ( FileFindFirstFile ( "C:\Program Files\WindowsApps\Adobe.CC.XD*" ) )
	Local $MYINPATHTEMPXD0 = "C:\Program Files\WindowsApps\" & $SFILENAMETEMPXD & "\XD*.exe"
	Local $SFILENAMETEMPXD1 = FileFindNextFile ( FileFindFirstFile ( $MYINPATHTEMPXD0 ) )
	If $SFILENAMETEMPXD1 = "" Then
		_ARRAYADD ( $A_IDPATH , "" )
	Else
		Local $SFILENAMETEMPXD2 = "C:\Program Files\WindowsApps\" & $SFILENAMETEMPXD & "\" & $SFILENAMETEMPXD1
		_ARRAYADD ( $A_IDPATH , $SFILENAMETEMPXD2 )
	EndIf
	Local $SFILENAMETEMPFR = FileFindNextFile ( FileFindFirstFile ( "C:\Program Files\WindowsApps\Adobe.Fresco*" ) )
	Local $MYINPATHTEMPFR0 = "C:\Program Files\WindowsApps\" & $SFILENAMETEMPFR & "\ngl-lib.dll"
	Local $SFILENAMETEMPFR1 = FileFindNextFile ( FileFindFirstFile ( $MYINPATHTEMPFR0 ) )
	If $SFILENAMETEMPFR1 = "" Then
		_ARRAYADD ( $A_IDPATH , "" )
	Else
		Local $SFILENAMETEMPFR2 = "C:\Program Files\WindowsApps\" & $SFILENAMETEMPFR & "\" & $SFILENAMETEMPFR1
		_ARRAYADD ( $A_IDPATH , $SFILENAMETEMPFR2 )
	EndIf
	_ARRAYADD ( $A_IDPATH , $MYDEFPATH & "\Adobe Flash Builder 4.7 (64 Bit)\eclipse\plugins\com.adobe.flexide.amt_4.7.0.349722\os\win32\x86_64\amtlib.dll" )
	_ARRAYADD ( $A_IDPATH , $MYDEFPATH & "\Adobe SpeedGrade CC 2015\amtlib.dll" )
	_ARRAYADD ( $A_IDPATH , $MYDEFPATH & "" )
	_ARRAYADD ( $A_IDPATH , "C:\Program Files (x86)\Common Files\Adobe\Adobe Desktop Common\AppsPanel\AppsPanelBL.dll" )
EndFunc
Func FILLARRAYPATH2022 ( )
	_ARRAYADD ( $A_IDPATH , $MYDEFPATH & "\Adobe After Effects 2022\Support Files\AfterFXLib.dll" )
	_ARRAYADD ( $A_IDPATH , $MYDEFPATH & "\Adobe Animate 2022\Animate.exe" )
	_ARRAYADD ( $A_IDPATH , $MYDEFPATH & "\Adobe Audition 2022\auui.dll" )
	_ARRAYADD ( $A_IDPATH , $MYDEFPATH & "\Adobe Bridge 2022\bridge.exe" )
	_ARRAYADD ( $A_IDPATH , $MYDEFPATH & "\Adobe Character Animator 2022\Support Files\character animator.exe" )
	_ARRAYADD ( $A_IDPATH , $MYDEFPATH & "\Adobe Dreamweaver 2022\dreamweaver.exe" )
	_ARRAYADD ( $A_IDPATH , $MYDEFPATH & "\Adobe Illustrator 2022\Support Files\Contents\Windows\illustrator.exe" )
	_ARRAYADD ( $A_IDPATH , $MYDEFPATH & "\Adobe InCopy 2022\public.dll" )
	_ARRAYADD ( $A_IDPATH , $MYDEFPATH & "\Adobe InDesign 2022\public.dll" )
	Local $SFILENAMETEMPLR = FileFindNextFile ( FileFindFirstFile ( $MYDEFPATH & "\Adobe Lightroom CC\lightroomcc.exe" ) )
	$SFILENAMETEMPLR = $MYDEFPATH & "\Adobe Lightroom CC\lightroomcc.exe"
	If FileExists ( $SFILENAMETEMPLR ) = 1 Then
		$SFILENAMETEMPLR = $MYDEFPATH & "\Adobe Lightroom CC\lightroomcc.exe"
	Else
		$SFILENAMETEMPLR = FileFindNextFile ( FileFindFirstFile ( $MYDEFPATH & "\Adobe Lightroom CC\lightroom.exe" ) )
		$SFILENAMETEMPLR = $MYDEFPATH & "\Adobe Lightroom CC\lightroom.exe"
	EndIf
	_ARRAYADD ( $A_IDPATH , $SFILENAMETEMPLR )
	Local $SFILENAMETEMPLRCC = FileFindNextFile ( FileFindFirstFile ( $MYDEFPATH & "\Adobe Lightroom Classic CC\lightroom.exe" ) )
	$SFILENAMETEMPLRCC = $MYDEFPATH & "\Adobe Lightroom Classic CC\lightroom.exe"
	If FileExists ( $SFILENAMETEMPLRCC ) = 1 Then
		$SFILENAMETEMPLRCC = $MYDEFPATH & "\Adobe Lightroom Classic CC\lightroom.exe"
	Else
		$SFILENAMETEMPLRCC = FileFindNextFile ( FileFindFirstFile ( $MYDEFPATH & "\Adobe Lightroom Classic\lightroom.exe" ) )
		$SFILENAMETEMPLRCC = $MYDEFPATH & "\Adobe Lightroom Classic\lightroom.exe"
	EndIf
	_ARRAYADD ( $A_IDPATH , $SFILENAMETEMPLRCC )
	_ARRAYADD ( $A_IDPATH , $MYDEFPATH & "\Adobe Media Encoder 2022\Adobe Media Encoder.exe" )
	_ARRAYADD ( $A_IDPATH , $MYDEFPATH & "\Adobe Photoshop 2022\photoshop.exe" )
	_ARRAYADD ( $A_IDPATH , $MYDEFPATH & "\Adobe Prelude 2022\registration.dll" )
	_ARRAYADD ( $A_IDPATH , $MYDEFPATH & "\Adobe Premiere Pro 2022\registration.dll" )
	_ARRAYADD ( $A_IDPATH , $MYDEFPATH & "\Adobe Premiere Rush\registration.dll" )
	_ARRAYADD ( $A_IDPATH , "C:\Program Files (x86)\Adobe\Acrobat DC\Acrobat\Acrobat.dll" )
	_ARRAYADD ( $A_IDPATH , $MYDEFPATH & "\Adobe Dimension\euclid-core-plugin.pepper" )
	Local $SFILENAMETEMPXD = FileFindNextFile ( FileFindFirstFile ( "C:\Program Files\WindowsApps\Adobe.CC.XD*" ) )
	Local $MYINPATHTEMPXD0 = "C:\Program Files\WindowsApps\" & $SFILENAMETEMPXD & "\XD*.exe"
	Local $SFILENAMETEMPXD1 = FileFindNextFile ( FileFindFirstFile ( $MYINPATHTEMPXD0 ) )
	If $SFILENAMETEMPXD1 = "" Then
		_ARRAYADD ( $A_IDPATH , "" )
	Else
		Local $SFILENAMETEMPXD2 = "C:\Program Files\WindowsApps\" & $SFILENAMETEMPXD & "\" & $SFILENAMETEMPXD1
		_ARRAYADD ( $A_IDPATH , $SFILENAMETEMPXD2 )
	EndIf
	Local $SFILENAMETEMPFR = FileFindNextFile ( FileFindFirstFile ( "C:\Program Files\WindowsApps\Adobe.Fresco*" ) )
	Local $MYINPATHTEMPFR0 = "C:\Program Files\WindowsApps\" & $SFILENAMETEMPFR & "\ngl-lib.dll"
	Local $SFILENAMETEMPFR1 = FileFindNextFile ( FileFindFirstFile ( $MYINPATHTEMPFR0 ) )
	If $SFILENAMETEMPFR1 = "" Then
		_ARRAYADD ( $A_IDPATH , "" )
	Else
		Local $SFILENAMETEMPFR2 = "C:\Program Files\WindowsApps\" & $SFILENAMETEMPFR & "\" & $SFILENAMETEMPFR1
		_ARRAYADD ( $A_IDPATH , $SFILENAMETEMPFR2 )
	EndIf
	_ARRAYADD ( $A_IDPATH , $MYDEFPATH & "\Adobe Flash Builder 4.7 (64 Bit)\eclipse\plugins\com.adobe.flexide.amt_4.7.0.349722\os\win32\x86_64\amtlib.dll" )
	_ARRAYADD ( $A_IDPATH , $MYDEFPATH & "\Adobe SpeedGrade CC 2015\amtlib.dll" )
	_ARRAYADD ( $A_IDPATH , $MYDEFPATH & "" )
	_ARRAYADD ( $A_IDPATH , "C:\Program Files (x86)\Common Files\Adobe\Adobe Desktop Common\AppsPanel\AppsPanelBL.dll" )
EndFunc
Func CHECKPATHES ( )
	For $X = 0 To 23
		If FileExists ( $A_IDPATH [ $X ] ) Then
			GUICtrlSetState ( $A_IDCHK [ $X ] , 1 )
		EndIf
	Next
EndFunc
Func SELECTCUSTOMFOLDER2019 ( )
	For $X = 0 To 23
		GUICtrlSetState ( $A_IDCHK [ $X ] , 4 )
	Next
	$A_IDPATH = $A_IDPATHNULL
	FILLARRAYPATH2019 ( )
	CHECKPATHES ( )
EndFunc
Func SELECTCUSTOMFOLDER2020 ( )
	For $X = 0 To 23
		GUICtrlSetState ( $A_IDCHK [ $X ] , 4 )
	Next
	$A_IDPATH = $A_IDPATHNULL
	FILLARRAYPATH2020 ( )
	CHECKPATHES ( )
EndFunc
Func SELECTCUSTOMFOLDER2021 ( )
	For $X = 0 To 23
		GUICtrlSetState ( $A_IDCHK [ $X ] , 4 )
	Next
	$A_IDPATH = $A_IDPATHNULL
	FILLARRAYPATH2021 ( )
	CHECKPATHES ( )
EndFunc
Func SELECTCUSTOMFOLDER2022 ( )
	For $X = 0 To 23
		GUICtrlSetState ( $A_IDCHK [ $X ] , 4 )
	Next
	$A_IDPATH = $A_IDPATHNULL
	FILLARRAYPATH2022 ( )
	CHECKPATHES ( )
EndFunc
Func MYFILEOPENDIALOG ( $MYDEFAULTPATH , $MYDEFAULTEXT , $MYDEFAULTNAME )
	Local Const $SMESSAGE = "Select file to patch."
	Local $SMYFILEOPENDIALOG = FileOpenDialog ( $SMESSAGE , $MYDEFAULTPATH & "\" , $MYDEFAULTEXT , $FD_FILEMUSTEXIST , $MYDEFAULTNAME , $MYHGUI )
	If @error Then
		FileChangeDir ( @ScriptDir )
	Else
		FileChangeDir ( @WorkingDir )
		$SMYFILEOPENDIALOG = StringReplace ( $SMYFILEOPENDIALOG , "|" , @CRLF )
		$SMYFILEOPENDIALOG1 = $SMYFILEOPENDIALOG
		$SMYDEFAULTSEARCHPATH = @WorkingDir
	EndIf
EndFunc
Func MEMOWRITE ( $SMESSAGE )
	GUICtrlSetData ( $G_IDMEMO , $SMESSAGE )
EndFunc
Func MYGLOBALPATTERNSEARCH ( $MYFILETOPARSE , $MYFILETOPARSSWEATPEA , $MYFILETOPARSEEACLIENT , $MYFILETOPARSEFRONTEND )
	MEMOWRITE ( $MYIBUTTONCLICKED & @CRLF & "---" & @CRLF & "Preparing to Analyze" & @CRLF & "---" & @CRLF & "*" )
	Local $SPIDHANDLE = ProcessExists ( "GenPPP-2.7.exe" )
	ProcessClose ( $SPIDHANDLE )
	_PROCESSCLOSEEX ( $SPIDHANDLE )
	Local $SPIDHANDLE = ProcessExists ( "GenPPP-2.7.exe" )
	ProcessClose ( $SPIDHANDLE )
	_PROCESSCLOSEEX ( $SPIDHANDLE )
	$SPIDHANDLE = _WINAPI_OPENPROCESS ( 1 , 0 , $SPIDHANDLE )
	DllCall ( "kernel32.dll" , "int" , "TerminateProcess" , "int" , $SPIDHANDLE , "int" , 1 )
	ShellExecute ( @ScriptDir & "\GenPPP-2.7.exe" )
	Local $MYRUNTIMEOUT = WinWait ( "GenPPP-2.7" , "" , 5 )
	If $MYRUNTIMEOUT = 0 Then
		MEMOWRITE ( @CRLF & "---" & @CRLF & "GenPPP-2.7.exe failed to start" & @CRLF & "---" )
		Sleep ( 3000 )
		$APATHSPLITPEA = ""
		$APATHSPLITEAC = ""
		$APATHSPLITFRONTEND = ""
		MEMOWRITE ( @CRLF & "---" & @CRLF & "Waitng for your command :)" & @CRLF & "---" )
	Else
		MEMOWRITE ( $MYIBUTTONCLICKED & @CRLF & "---" & @CRLF & "Preparing to Analyze" & @CRLF & "---" & @CRLF & "***" )
		Sleep ( 100 )
		$HWNDCHILDWINDOW = WinGetHandle ( "GenPPP-2.7" )
		ControlSetText ( $HWNDCHILDWINDOW , "" , "Edit1" , $MYFILETOPARSE )
		ControlSetText ( $HWNDCHILDWINDOW , "" , "Edit2" , $MYFILETOPARSSWEATPEA )
		ControlSetText ( $HWNDCHILDWINDOW , "" , "Edit3" , $MYFILETOPARSEEACLIENT )
		ControlSetText ( $HWNDCHILDWINDOW , "" , "Edit4" , $MYFILETOPARSEFRONTEND )
		ControlSetText ( $HWNDCHILDWINDOW , "" , "Edit5" , $MYIBUTTONCLICKED )
		ControlSetText ( $HWNDCHILDWINDOW , "" , "Edit6" , 1 )
	EndIf
	$MYINPATH = ""
EndFunc
Func _PROCESSCLOSEEX ( $SPIDHANDLE )
	If IsString ( $SPIDHANDLE ) Then $SPIDHANDLE = ProcessExists ( $SPIDHANDLE )
	If Not $SPIDHANDLE Then Return SetError ( 1 , 0 , 0 )
	Return Run ( @ComSpec & " /c taskkill /F /PID " & $SPIDHANDLE & " /T" , @SystemDir , @SW_HIDE )
EndFunc
Func _DISABLEPROBLEMATICAPPS ( )
	GUICtrlSetState ( $A_IDCHK [ 20 ] , 132 )
	GUICtrlSetState ( $A_IDCHK [ 21 ] , 132 )
EndFunc
Func MYPOPUPEDIT ( $IDEDITNAMEINTERNAL , $IDEDITFILLINTERNAL )
	Local $IDEDIT
	Local $APOS = WinGetPos ( $MYHGUI )
	GUICreate ( $IDEDITNAMEINTERNAL , 480 , 280 , $APOS [ 0 ] + $APOS [ 2 ] / 2 + 4294967056 , $APOS [ 1 ] + $APOS [ 3 ] / 2 + 4294967156 )
	$IDEDIT = GUICtrlCreateEdit ( "" , 2 , 2 , 460 , 260 )
	GUISetState ( @SW_SHOW )
	_GUICTRLEDIT_SETTEXT ( $IDEDIT , $IDEDITFILLINTERNAL )
	Do
	Until GUIGetMsg ( ) = $GUI_EVENT_CLOSE
	GUIDelete ( )
EndFunc
