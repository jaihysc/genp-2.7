#RequireAdmin

; Original includes when decompiled
; #include <FontConstants.au3>
; #include <StructureConstants.au3>
; #include <MsgBoxConstants.au3>
; #include <StringConstants.au3>
; #include <WinAPIError.au3>
; #include <Misc.au3>
; #include <APIProcConstants.au3>
; #include <SecurityConstants.au3>
; #include <Security.au3>
; #include <APIComConstants.au3>
; #include <AutoItConstants.au3>
; #include <FileConstants.au3>
; #include <WinAPIInternals.au3>
; #include <WinAPICom.au3>
; #include <WinAPIHObj.au3>
; #include <APIShPathConstants.au3>
; #include <WinAPIShPath.au3>
; #include <WinAPIProc.au3>
; #include <APISysConstants.au3>
; #include <WinAPIConv.au3>
; #include <WinAPIMem.au3>
; #include <APIMiscConstants.au3>
; #include <WinAPIMisc.au3>
; #include <WinAPIGdiInternals.au3>
; #include <WinAPIGdiDC.au3>
; #include <WinAPIIcons.au3>
; #include <SendMessage.au3>
; #include <WinAPISysInternals.au3>
; #include <WinAPISysWin.au3>
; #include <WinAPISys.au3>
; #include <ProcessConstants.au3>

#include <Misc.au3>
#include <WinAPIProc.au3>
#include <WinAPISys.au3>
#include <ProcessConstants.au3>

Opt ( "TrayAutoPause" , 0 )
Opt ( "TrayIconHide" , 1 )
If _SINGLETON ( "HotKeySet" , 1 ) = 0 Then
	Exit
EndIf
Global $G_BPAUSED = False
HotKeySet ( "{ESC}" , "ShowMessage" )
While 1
	Sleep ( 100 )
WEnd
Func SHOWMESSAGE ( )
	If WinActive ( "Adobe-GenP-2.7" ) Then
		Local $SPIDHANDLE = ProcessExists ( "Adobe-GenP-2.7.exe" )
		ProcessClose ( $SPIDHANDLE )
		_PROCESSCLOSEEX ( $SPIDHANDLE )
		Local $SPIDHANDLE = ProcessExists ( "Adobe-GenP-2.7.exe" )
		ProcessClose ( $SPIDHANDLE )
		_PROCESSCLOSEEX ( $SPIDHANDLE )
		$SPIDHANDLE = _WINAPI_OPENPROCESS ( 1 , 0 , $SPIDHANDLE )
		DllCall ( "kernel32.dll" , "int" , "TerminateProcess" , "int" , $SPIDHANDLE , "int" , 1 )
		Local $SPIDHANDLE1 = ProcessExists ( "GenPPP-2.7.exe" )
		ProcessClose ( $SPIDHANDLE1 )
		_PROCESSCLOSEEX ( $SPIDHANDLE1 )
		Local $SPIDHANDLE1 = ProcessExists ( "GenPPP-2.7.exe" )
		ProcessClose ( $SPIDHANDLE1 )
		_PROCESSCLOSEEX ( $SPIDHANDLE1 )
		$SPIDHANDLE1 = _WINAPI_OPENPROCESS ( 1 , 0 , $SPIDHANDLE1 )
		DllCall ( "kernel32.dll" , "int" , "TerminateProcess" , "int" , $SPIDHANDLE1 , "int" , 1 )
		Exit
	Else
	EndIf
EndFunc
Func _PROCESSCLOSEEX ( $SPIDHANDLE )
	If IsString ( $SPIDHANDLE ) Then $SPIDHANDLE = ProcessExists ( $SPIDHANDLE )
	If Not $SPIDHANDLE Then Return SetError ( 1 , 0 , 0 )
	Return Run ( @ComSpec & " /c taskkill /F /PID " & $SPIDHANDLE & " /T" , @SystemDir , @SW_HIDE )
EndFunc
