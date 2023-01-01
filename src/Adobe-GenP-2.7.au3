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

If _Singleton ( "Adobe-GenP-2.7" , 1 ) = 0 Then
	Exit
EndIf

; Close HotKeySet.exe (odd method for doing so)
Local $sPidHandle1 = ProcessExists ( "HotKeySet.exe" )
ProcessClose ( $sPidHandle1 )
_ProcessCloseEx ( $sPidHandle1 )
Local $sPidHandle1 = ProcessExists ( "HotKeySet.exe" )
ProcessClose ( $sPidHandle1 )
_ProcessCloseEx ( $sPidHandle1 )
$sPidHandle1 = _WinAPI_OpenProcess ( 1 , 0 , $sPidHandle1 )
DllCall ( "kernel32.dll" , "int" , "TerminateProcess" , "int" , $sPidHandle1 , "int" , 1 )

ShellExecute ( @ScriptDir & "\HotKeySet.exe" )


; Indices -> Adobe product
;  1 : After Effects
;  2 : Animate
;  3 : Audition
;  4 : Bridge
;  5 : Character Animator
;  6 : Dreamweaver
;  7 : Illustrator
;  8 : InCopy
;  9 : InDesign
; 10 : Lightroom
; 11 : Lightroom Classic
; 12 : Media Encoder
; 13 : Photoshop
; 14 : Prelude
; 15 : Premiere Pro
; 16 : Premiere Rush
; 17 : Acrobat
; 18 : Dimension
; 19 : XD
; 20 : Fresco
; 21 : Flash Builder
; 22 : Speed Grade
; 23 : -
; 24 : Creative Cloud

; Variables used for GUI behaviour
Global $myHGui ; Handle for GUI
Global $idMsg = 0 ; Holds the GUI message in the message loop
Global $y = 80 ; Keep track of Y position for laying out GUI
Global $myIButtonClicked = 0 ; Holds index of the Adobe icon button clicked. 0 = No click (see indices to Adobe product)

; Identifiers for GUI elements
Global $g_idMemo ; Holds text to be shown to user
Global $g_idDeselectAll ; Button to select all checkboxes
Global $idBtnCure ; Pill button / patch button
Global $myOwnIdProgress ; Progress bar
Global $idButton_path2019 = "" ; Button for switching between CC versions
Global $idButton_path2020 = ""
Global $idButton_path2021 = ""
Global $idButton_path2022 = ""
Global $a_idChk [ 24 ] ; Checkbox for selecting Adobe products (see indices to Adobe product, starting at 0. E.g., Dreamweaver is index 5)
; State of checkbox for selecting Adobe products
Global $a_idChkState [ 24 ]

; Default search path for file dialogs
Global $sMyDefaultSearchPath = "C:\Program Files\Adobe"
; Paths to Adobe files
Global $aPathSplitEAC = "" ; EAClient.dll
Global $aPathSplitPea = "" ; SweetPeaSupport.dll
Global $aPathSplitFrontend = "" ; amtlib.dll
Global $myDefPath = "C:\Program Files\Adobe" ; Parent directory of Adobe products
Global $a_idPath [ 24 ] ; Path to each Adobe product
Global $a_idPathNull [ 0 ] ; Null array to clear a_idPath


MainGui ( )
Sleep ( 100 )
CheckPathes ( )
; Select all Adobe products by default
ControlClick ( "" , "" , $g_idDeselectAll )


; Loop to process GUI messages
While 1
	$idMsg = GUIGetMsg ( )
	Select
	; Close GUI
	Case $idMsg = $GUI_EVENT_CLOSE
		Local $sPidHandle = ProcessExists ( "GenPPP-2.7.exe" )
		ProcessClose ( $sPidHandle )
		_ProcessCloseEx ( $sPidHandle )
		Local $sPidHandle = ProcessExists ( "GenPPP-2.7.exe" )
		ProcessClose ( $sPidHandle )
		_ProcessCloseEx ( $sPidHandle )
		$sPidHandle = _WinAPI_OpenProcess ( 1 , 0 , $sPidHandle )
		DllCall ( "kernel32.dll" , "int" , "TerminateProcess" , "int" , $sPidHandle , "int" , 1 )

		Local $sPidHandle1 = ProcessExists ( "HotKeySet.exe" )
		ProcessClose ( $sPidHandle1 )
		_ProcessCloseEx ( $sPidHandle1 )
		Local $sPidHandle1 = ProcessExists ( "HotKeySet.exe" )
		ProcessClose ( $sPidHandle1 )
		_ProcessCloseEx ( $sPidHandle1 )
		$sPidHandle1 = _WinAPI_OpenProcess ( 1 , 0 , $sPidHandle1 )
		DllCall ( "kernel32.dll" , "int" , "TerminateProcess" , "int" , $sPidHandle1 , "int" , 1 )
		ExitLoop
	; Setup to target CC2019
	Case $idMsg = $idButton_path2019
		SelectCustomFolder2019 ( )
		CheckPathes ( )
		_DisableProblematicApps ( )
		MemoWrite ( @CRLF & "---" & @CRLF & "CC 2019 automatic mode" & @CRLF & "---" )
	; Setup to target CC2020
	Case $idMsg = $idButton_path2020
		SelectCustomFolder2020 ( )
		CheckPathes ( )
		_DisableProblematicApps ( )
		MemoWrite ( @CRLF & "---" & @CRLF & "CC 2020 automatic mode" & @CRLF & "---" )
	; Setup to target CC2021
	Case $idMsg = $idButton_path2021
		SelectCustomFolder2021 ( )
		CheckPathes ( )
		_DisableProblematicApps ( )
		MemoWrite ( @CRLF & "---" & @CRLF & "CC 2021 automatic mode" & @CRLF & "---" )
	; Setup to target CC2022
	Case $idMsg = $idButton_path2022
		SelectCustomFolder2022 ( )
		CheckPathes ( )
		_DisableProblematicApps ( )
		MemoWrite ( @CRLF & "---" & @CRLF & "CC 2022 automatic mode" & @CRLF & "---" )
	; Select all button - Selects the checkbox for all Adobe products
	Case $idMsg = $g_idDeselectAll
		$a_idPath = $a_idPathNull
		For $x = 0 To 23
			GUICtrlSetState ( $a_idChk [ $x ] , $GUI_UNCHECKED )
			_ArrayAdd ( $a_idPath , "" )
		Next
		_DisableProblematicApps ( )
		MemoWrite ( @CRLF & "---" & @CRLF & "Manual mode - custom path" & @CRLF & "---" )
	; The cure (patch) button
	Case $idMsg = $idBtnCure
		; Prevent interaction on all controls
		For $x = 0 To 23
			GUICtrlSetState ( $a_idChk [ $x ] , $GUI_DISABLE )
			GUICtrlSetState ( $idButton_path2019 , $GUI_DISABLE )
			GUICtrlSetState ( $idButton_path2020 , $GUI_DISABLE )
			GUICtrlSetState ( $idButton_path2021 , $GUI_DISABLE )
			GUICtrlSetState ( $idButton_path2022 , $GUI_DISABLE )
			GUICtrlSetState ( $g_idDeselectAll , $GUI_DISABLE )
			GUICtrlSetState ( $idBtnCure , $GUI_DISABLE )
		Next

		; Performs the patching if checkbox selected
		$myIButtonClicked = 0
		$myInPath = ""
		_DisableProblematicApps ( )
		For $x = 0 To 23
			$a_idChkState [ $x ] = GUICtrlRead ( $a_idChk [ $x ] )
			If $a_idChkState [ $x ] = 1 Then
				$myIButtonClicked = $x + 1
				$myInPath = $a_idPath [ $myIButtonClicked - 1 ]
				Select
				Case $myIButtonClicked = 1
					If FileExists ( $myInPath ) = 0 Then
						$myInPath = ""
						$sMyFileOpenDialog1 = ""
						$myDefExtensionFilename = "AfterFXLib*.dll"
						$myDefExtensionFile = "(" & $myDefExtensionFilename & ")"
						MyFileOpenDialog ( $sMyDefaultSearchPath , $myDefExtensionFile , $myDefExtensionFilename )
						$myInPath = $sMyFileOpenDialog1
					EndIf
					Local $iFileExists = FileExists ( $myInPath )
					If $iFileExists = 0 Then
						MemoWrite ( @CRLF & "---" & @CRLF & "Waitng for your command :)" & @CRLF & "---" )
					Else
						Local $sDrive = "" , $sDir = "" , $sFilename = "" , $sExtension = "" , $aPathSplit = ""
						Local $iPath = $myInPath
						Local $aPathSplit = _PATHSPLIT ( $iPath , $sDrive , $sDir , $sFilename , $sExtension )
						$aPathSplitPea = $sDrive & $sDir & "SweetPeaSupport.dll"
						$aPathSplitEAC = $sDrive & $sDir & "EAClient.dll"
						MyGlobalPatternSearch ( $myInPath , $aPathSplitPea , $aPathSplitEAC , $aPathSplitFrontend )
					EndIf
				Case $myIButtonClicked = 2
					If FileExists ( $myInPath ) = 0 Then
						$sMyFileOpenDialog1 = ""
						$myDefExtensionFilename = "Animate*.exe"
						$myDefExtensionFile = "(" & $myDefExtensionFilename & ")"
						MyFileOpenDialog ( $sMyDefaultSearchPath , $myDefExtensionFile , $myDefExtensionFilename )
						$myInPath = $sMyFileOpenDialog1
					EndIf
					Local $iFileExists = FileExists ( $myInPath )
					If $iFileExists = 0 Then
						MemoWrite ( @CRLF & "---" & @CRLF & "Waitng for your command :)" & @CRLF & "---" )
					Else
						MyGlobalPatternSearch ( $myInPath , $aPathSplitPea , $aPathSplitEAC , $aPathSplitFrontend )
					EndIf
				Case $myIButtonClicked = 3
					If FileExists ( $myInPath ) = 0 Then
						$sMyFileOpenDialog1 = ""
						$myDefExtensionFilename = "auui*.dll"
						$myDefExtensionFile = "(" & $myDefExtensionFilename & ")"
						MyFileOpenDialog ( $sMyDefaultSearchPath , $myDefExtensionFile , $myDefExtensionFilename )
						$myInPath = $sMyFileOpenDialog1
					EndIf
					Local $iFileExists = FileExists ( $myInPath )
					If $iFileExists = 0 Then
						MemoWrite ( @CRLF & "---" & @CRLF & "Waitng for your command :)" & @CRLF & "---" )
					Else
						MyGlobalPatternSearch ( $myInPath , $aPathSplitPea , $aPathSplitEAC , $aPathSplitFrontend )
					EndIf
				Case $myIButtonClicked = 4
					If FileExists ( $myInPath ) = 0 Then
						$sMyFileOpenDialog1 = ""
						$myDefExtensionFilename = "bridge*.exe"
						$myDefExtensionFile = "(" & $myDefExtensionFilename & ")"
						MyFileOpenDialog ( $sMyDefaultSearchPath , $myDefExtensionFile , $myDefExtensionFilename )
						$myInPath = $sMyFileOpenDialog1
					EndIf
					Local $iFileExists = FileExists ( $myInPath )
					If $iFileExists = 0 Then
						MemoWrite ( @CRLF & "---" & @CRLF & "Waitng for your command :)" & @CRLF & "---" )
					Else
						MyGlobalPatternSearch ( $myInPath , $aPathSplitPea , $aPathSplitEAC , $aPathSplitFrontend )
					EndIf
				Case $myIButtonClicked = 5
					If FileExists ( $myInPath ) = 0 Then
						$sMyFileOpenDialog1 = ""
						$myDefExtensionFilename = "character animator*.exe"
						$myDefExtensionFile = "(" & $myDefExtensionFilename & ")"
						MyFileOpenDialog ( $sMyDefaultSearchPath , $myDefExtensionFile , $myDefExtensionFilename )
						$myInPath = $sMyFileOpenDialog1
					EndIf
					Local $iFileExists = FileExists ( $myInPath )
					If $iFileExists = 0 Then
						MemoWrite ( @CRLF & "---" & @CRLF & "Waitng for your command :)" & @CRLF & "---" )
					Else
						MyGlobalPatternSearch ( $myInPath , $aPathSplitPea , $aPathSplitEAC , $aPathSplitFrontend )
					EndIf
				Case $myIButtonClicked = 6
					If FileExists ( $myInPath ) = 0 Then
						$sMyFileOpenDialog1 = ""
						$myDefExtensionFilename = "dreamweaver*.exe"
						$myDefExtensionFile = "(" & $myDefExtensionFilename & ")"
						MyFileOpenDialog ( $sMyDefaultSearchPath , $myDefExtensionFile , $myDefExtensionFilename )
						$myInPath = $sMyFileOpenDialog1
					EndIf
					Local $iFileExists = FileExists ( $myInPath )
					If $iFileExists = 0 Then
						MemoWrite ( @CRLF & "---" & @CRLF & "Waitng for your command :)" & @CRLF & "---" )
					Else
						MyGlobalPatternSearch ( $myInPath , $aPathSplitPea , $aPathSplitEAC , $aPathSplitFrontend )
					EndIf
				Case $myIButtonClicked = 7
					If FileExists ( $myInPath ) = 0 Then
						$sMyFileOpenDialog1 = ""
						$myDefExtensionFilename = "illustrator*.exe"
						$myDefExtensionFile = "(" & $myDefExtensionFilename & ")"
						MyFileOpenDialog ( $sMyDefaultSearchPath , $myDefExtensionFile , $myDefExtensionFilename )
						$myInPath = $sMyFileOpenDialog1
					EndIf
					Local $iFileExists = FileExists ( $myInPath )
					If $iFileExists = 0 Then
						MemoWrite ( @CRLF & "---" & @CRLF & "Waitng for your command :)" & @CRLF & "---" )
					Else
						MyGlobalPatternSearch ( $myInPath , $aPathSplitPea , $aPathSplitEAC , $aPathSplitFrontend )
					EndIf
				Case $myIButtonClicked = 8
					If FileExists ( $myInPath ) = 0 Then
						$sMyFileOpenDialog1 = ""
						$myDefExtensionFilename = "public*.dll"
						$myDefExtensionFile = "(" & $myDefExtensionFilename & ")"
						MyFileOpenDialog ( $sMyDefaultSearchPath , $myDefExtensionFile , $myDefExtensionFilename )
						$myInPath = $sMyFileOpenDialog1
					EndIf
					Local $iFileExists = FileExists ( $myInPath )
					If $iFileExists = 0 Then
						MemoWrite ( @CRLF & "---" & @CRLF & "Waitng for your command :)" & @CRLF & "---" )
					Else
						MyGlobalPatternSearch ( $myInPath , $aPathSplitPea , $aPathSplitEAC , $aPathSplitFrontend )
					EndIf
				Case $myIButtonClicked = 9
					If FileExists ( $myInPath ) = 0 Then
						$sMyFileOpenDialog1 = ""
						$myDefExtensionFilename = "public*.dll"
						$myDefExtensionFile = "(" & $myDefExtensionFilename & ")"
						MyFileOpenDialog ( $sMyDefaultSearchPath , $myDefExtensionFile , $myDefExtensionFilename )
						$myInPath = $sMyFileOpenDialog1
					EndIf
					Local $iFileExists = FileExists ( $myInPath )
					If $iFileExists = 0 Then
						MemoWrite ( @CRLF & "---" & @CRLF & "Waitng for your command :)" & @CRLF & "---" )
					Else
						MyGlobalPatternSearch ( $myInPath , $aPathSplitPea , $aPathSplitEAC , $aPathSplitFrontend )
					EndIf
				Case $myIButtonClicked = 10
					If FileExists ( $myInPath ) = 0 Then
						$sMyFileOpenDialog1 = ""
						$myDefExtensionFilename = "lightroom*.exe"
						$myDefExtensionFile = "(" & $myDefExtensionFilename & ")"
						MyFileOpenDialog ( $sMyDefaultSearchPath , $myDefExtensionFile , $myDefExtensionFilename )
						$myInPath = $sMyFileOpenDialog1
					EndIf
					Local $iFileExists = FileExists ( $myInPath )
					If $iFileExists = 0 Then
						MemoWrite ( @CRLF & "---" & @CRLF & "Waitng for your command :)" & @CRLF & "---" )
					Else
						MyGlobalPatternSearch ( $myInPath , $aPathSplitPea , $aPathSplitEAC , $aPathSplitFrontend )
					EndIf
				Case $myIButtonClicked = 11
					If FileExists ( $myInPath ) = 0 Then
						$sMyFileOpenDialog1 = ""
						$myDefExtensionFilename = "lightroom*.exe"
						$myDefExtensionFile = "(" & $myDefExtensionFilename & ")"
						MyFileOpenDialog ( $sMyDefaultSearchPath , $myDefExtensionFile , $myDefExtensionFilename )
						$myInPath = $sMyFileOpenDialog1
					EndIf
					Local $iFileExists = FileExists ( $myInPath )
					If $iFileExists = 0 Then
						MemoWrite ( @CRLF & "---" & @CRLF & "Waitng for your command :)" & @CRLF & "---" )
					Else
						MyGlobalPatternSearch ( $myInPath , $aPathSplitPea , $aPathSplitEAC , $aPathSplitFrontend )
					EndIf
				Case $myIButtonClicked = 12
					If FileExists ( $myInPath ) = 0 Then
						$sMyFileOpenDialog1 = ""
						$myDefExtensionFilename = "Adobe Media Encoder*.exe"
						$myDefExtensionFile = "(" & $myDefExtensionFilename & ")"
						MyFileOpenDialog ( $sMyDefaultSearchPath , $myDefExtensionFile , $myDefExtensionFilename )
						$myInPath = $sMyFileOpenDialog1
					EndIf
					Local $iFileExists = FileExists ( $myInPath )
					If $iFileExists = 0 Then
						MemoWrite ( @CRLF & "---" & @CRLF & "Waitng for your command :)" & @CRLF & "---" )
					Else
						Local $sDrive = "" , $sDir = "" , $sFilename = "" , $sExtension = "" , $aPathSplit = ""
						Local $iPath = $myInPath
						Local $aPathSplit = _PATHSPLIT ( $iPath , $sDrive , $sDir , $sFilename , $sExtension )
						$aPathSplitPea = $sDrive & $sDir & "SweetPeaSupport.dll"
						$aPathSplitEAC = $sDrive & $sDir & "EAClient.dll"
						MyGlobalPatternSearch ( $myInPath , $aPathSplitPea , $aPathSplitEAC , $aPathSplitFrontend )
					EndIf
				Case $myIButtonClicked = 13
					If FileExists ( $myInPath ) = 0 Then
						$sMyFileOpenDialog1 = ""
						$myDefExtensionFilename = "photoshop*.exe"
						$myDefExtensionFile = "(" & $myDefExtensionFilename & ")"
						MyFileOpenDialog ( $sMyDefaultSearchPath , $myDefExtensionFile , $myDefExtensionFilename )
						$myInPath = $sMyFileOpenDialog1
					EndIf
					Local $iFileExists = FileExists ( $myInPath )
					If $iFileExists = 0 Then
						MemoWrite ( @CRLF & "---" & @CRLF & "Waitng for your command :)" & @CRLF & "---" )
					Else
						MyGlobalPatternSearch ( $myInPath , $aPathSplitPea , $aPathSplitEAC , $aPathSplitFrontend )
					EndIf
				Case $myIButtonClicked = 14
					If FileExists ( $myInPath ) = 0 Then
						$sMyFileOpenDialog1 = ""
						$myDefExtensionFilename = "registration*.dll"
						$myDefExtensionFile = "(" & $myDefExtensionFilename & ")"
						MyFileOpenDialog ( $sMyDefaultSearchPath , $myDefExtensionFile , $myDefExtensionFilename )
						$myInPath = $sMyFileOpenDialog1
					EndIf
					Local $iFileExists = FileExists ( $myInPath )
					If $iFileExists = 0 Then
						MemoWrite ( @CRLF & "---" & @CRLF & "Waitng for your command :)" & @CRLF & "---" )
					Else
						Local $sDrive = "" , $sDir = "" , $sFilename = "" , $sExtension = "" , $aPathSplit = ""
						Local $iPath = $myInPath
						Local $aPathSplit = _PATHSPLIT ( $iPath , $sDrive , $sDir , $sFilename , $sExtension )
						$aPathSplitPea = $sDrive & $sDir & "SweetPeaSupport.dll"
						$aPathSplitEAC = $sDrive & $sDir & "EAClient.dll"
						MyGlobalPatternSearch ( $myInPath , $aPathSplitPea , $aPathSplitEAC , $aPathSplitFrontend )
					EndIf
				Case $myIButtonClicked = 15
					If FileExists ( $myInPath ) = 0 Then
						$sMyFileOpenDialog1 = ""
						$myDefExtensionFilename = "registration*.dll"
						$myDefExtensionFile = "(" & $myDefExtensionFilename & ")"
						MyFileOpenDialog ( $sMyDefaultSearchPath , $myDefExtensionFile , $myDefExtensionFilename )
						$myInPath = $sMyFileOpenDialog1
					EndIf
					Local $iFileExists = FileExists ( $myInPath )
					If $iFileExists = 0 Then
						MemoWrite ( @CRLF & "---" & @CRLF & "Waitng for your command :)" & @CRLF & "---" )
					Else
						Local $sDrive = "" , $sDir = "" , $sFilename = "" , $sExtension = "" , $aPathSplit = ""
						Local $iPath = $myInPath
						Local $aPathSplit = _PATHSPLIT ( $iPath , $sDrive , $sDir , $sFilename , $sExtension )
						$aPathSplitPea = $sDrive & $sDir & "SweetPeaSupport.dll"
						$aPathSplitEAC = $sDrive & $sDir & "EAClient.dll"
						MyGlobalPatternSearch ( $myInPath , $aPathSplitPea , $aPathSplitEAC , $aPathSplitFrontend )
					EndIf
				Case $myIButtonClicked = 16
					If FileExists ( $myInPath ) = 0 Then
						$sMyFileOpenDialog1 = ""
						$myDefExtensionFilename = "registration*.dll"
						$myDefExtensionFile = "(" & $myDefExtensionFilename & ")"
						MyFileOpenDialog ( $sMyDefaultSearchPath , $myDefExtensionFile , $myDefExtensionFilename )
						$myInPath = $sMyFileOpenDialog1
					EndIf
					Local $iFileExists = FileExists ( $myInPath )
					If $iFileExists = 0 Then
						MemoWrite ( @CRLF & "---" & @CRLF & "Waitng for your command :)" & @CRLF & "---" )
					Else
						Local $sDrive = "" , $sDir = "" , $sFilename = "" , $sExtension = "" , $aPathSplit = ""
						Local $iPath = $myInPath
						Local $aPathSplit = _PATHSPLIT ( $iPath , $sDrive , $sDir , $sFilename , $sExtension )
						$aPathSplitPea = $sDrive & $sDir & "SweetPeaSupport.dll"
						$aPathSplitEAC = $sDrive & $sDir & "EAClient.dll"
						MyGlobalPatternSearch ( $myInPath , $aPathSplitPea , $aPathSplitEAC , $aPathSplitFrontend )
					EndIf
				Case $myIButtonClicked = 17
					If FileExists ( $myInPath ) = 0 Then
						$sMyFileOpenDialog1 = ""
						$myDefExtensionFilename = "Acrobat*.dll"
						$myDefExtensionFile = "(" & $myDefExtensionFilename & ")"
						MyFileOpenDialog ( $sMyDefaultSearchPath , $myDefExtensionFile , $myDefExtensionFilename )
						$myInPath = $sMyFileOpenDialog1
					EndIf
					Local $iFileExists = FileExists ( $myInPath )
					If $iFileExists = 0 Then
						MemoWrite ( @CRLF & "---" & @CRLF & "Waitng for your command :)" & @CRLF & "---" )
					Else
						Local $sDrive = "" , $sDir = "" , $sFilename = "" , $sExtension = "" , $aPathSplit = ""
						Local $iPath = $myInPath
						Local $aPathSplit = _PATHSPLIT ( $iPath , $sDrive , $sDir , $sFilename , $sExtension )
						$aPathSplitACRODIST = $sDrive & $sDir & "acrodistdll.dll"
						$aPathSplitACROTRAY = $sDrive & $sDir & "acrotray.exe"
						$aPathSplitFrontend = $sDrive & $sDir & "amtlib.dll"
						MyGlobalPatternSearch ( $myInPath , $aPathSplitACRODIST , $aPathSplitACROTRAY , $aPathSplitFrontend )
					EndIf
				Case $myIButtonClicked = 18
					If FileExists ( $myInPath ) = 0 Then
						$sMyFileOpenDialog1 = ""
						$myDefExtensionFilename = "euclid-core-plugin*.pepper"
						$myDefExtensionFile = "(" & $myDefExtensionFilename & ")"
						MyFileOpenDialog ( $sMyDefaultSearchPath , $myDefExtensionFile , $myDefExtensionFilename )
						$myInPath = $sMyFileOpenDialog1
					EndIf
					Local $iFileExists = FileExists ( $myInPath )
					If $iFileExists = 0 Then
						MemoWrite ( @CRLF & "---" & @CRLF & "Waitng for your command :)" & @CRLF & "---" )
					Else
						Local $sDrive = "" , $sDir = "" , $sFilename = "" , $sExtension = "" , $aPathSplit = ""
						Local $iPath = $myInPath
						Local $aPathSplit = _PATHSPLIT ( $iPath , $sDrive , $sDir , $sFilename , $sExtension )
						$aPathSplitPea = $sDrive & $sDir & "SweetPeaSupport.dll"
						$aPathSplitEAC = $sDrive & $sDir & "EAClient.dll"
						MyGlobalPatternSearch ( $myInPath , $aPathSplitPea , $aPathSplitEAC , $aPathSplitFrontend )
					EndIf
				Case $myIButtonClicked = 19
					If FileExists ( $myInPath ) = 0 Then
						$sMyDefaultSearchPath = ""
						$sMyDefaultSearchPath = "C:\Program Files\WindowsApps"
						$sMyFileOpenDialog1 = ""
						$myDefExtensionFilename = "XD*.exe"
						$myDefExtensionFile = "(" & $myDefExtensionFilename & ")"
						MyFileOpenDialog ( $sMyDefaultSearchPath , $myDefExtensionFile , $myDefExtensionFilename )
						$myInPath = $sMyFileOpenDialog1
						$sMyDefaultSearchPath = ""
						$sMyDefaultSearchPath = "C:\Program Files\Adobe"
					EndIf
					Local $iFileExists = FileExists ( $myInPath )
					If $iFileExists = 0 Then
						MemoWrite ( @CRLF & "---" & @CRLF & "Waitng for your command :)" & @CRLF & "---" )
					Else
						MyGlobalPatternSearch ( $myInPath , $aPathSplitPea , $aPathSplitEAC , $aPathSplitFrontend )
					EndIf
				Case $myIButtonClicked = 20
					If FileExists ( $myInPath ) = 0 Then
						$sMyDefaultSearchPath = ""
						$sMyDefaultSearchPath = "C:\Program Files\WindowsApps"
						$sMyFileOpenDialog1 = ""
						$myDefExtensionFilename = "ngl-lib*.dll"
						$myDefExtensionFile = "(" & $myDefExtensionFilename & ")"
						MyFileOpenDialog ( $sMyDefaultSearchPath , $myDefExtensionFile , $myDefExtensionFilename )
						$myInPath = $sMyFileOpenDialog1
						$sMyDefaultSearchPath = ""
						$sMyDefaultSearchPath = "C:\Program Files\Adobe"
					EndIf
					Local $iFileExists = FileExists ( $myInPath )
					If $iFileExists = 0 Then
						MemoWrite ( @CRLF & "---" & @CRLF & "Waitng for your command :)" & @CRLF & "---" )
					Else
						MyGlobalPatternSearch ( $myInPath , $aPathSplitPea , $aPathSplitEAC , $aPathSplitFrontend )
					EndIf
				Case $myIButtonClicked = 21
					If FileExists ( $myInPath ) = 0 Then
						$sMyFileOpenDialog1 = ""
						$myDefExtensionFilename = "amtlib.dll"
						$myDefExtensionFile = "(" & $myDefExtensionFilename & ")"
						MyFileOpenDialog ( $sMyDefaultSearchPath , $myDefExtensionFile , $myDefExtensionFilename )
						$myInPath = $sMyFileOpenDialog1
					EndIf
					Local $iFileExists = FileExists ( $myInPath )
					If $iFileExists = 0 Then
						MemoWrite ( @CRLF & "---" & @CRLF & "Waitng for your command :)" & @CRLF & "---" )
					Else
						MyGlobalPatternSearch ( $myInPath , $aPathSplitPea , $aPathSplitEAC , $aPathSplitFrontend )
					EndIf
				Case $myIButtonClicked = 22
					If FileExists ( $myInPath ) = 0 Then
						$sMyFileOpenDialog1 = ""
						$myDefExtensionFilename = "amtlib.dll"
						$myDefExtensionFile = "(" & $myDefExtensionFilename & ")"
						MyFileOpenDialog ( $sMyDefaultSearchPath , $myDefExtensionFile , $myDefExtensionFilename )
						$myInPath = $sMyFileOpenDialog1
					EndIf
					Local $iFileExists = FileExists ( $myInPath )
					If $iFileExists = 0 Then
						MemoWrite ( @CRLF & "---" & @CRLF & "Waitng for your command :)" & @CRLF & "---" )
					Else
						MyGlobalPatternSearch ( $myInPath , $aPathSplitPea , $aPathSplitEAC , $aPathSplitFrontend )
					EndIf
				Case $myIButtonClicked = 23
					MemoWrite ( @CRLF & "---" & @CRLF & "Waitng for your command :)" & @CRLF & "---" )
				Case $myIButtonClicked = 24
					If FileExists ( $myInPath ) = 0 Then
						$sMyFileOpenDialog1 = ""
						$sMyDefaultSearchPath = "C:\Program Files (x86)\Adobe\Adobe Creative Cloud\AppsPanel"
						$myDefExtensionFilename = "AppsPanelBL.dll"
						$myDefExtensionFile = "(" & $myDefExtensionFilename & ")"
						MyFileOpenDialog ( $sMyDefaultSearchPath , $myDefExtensionFile , $myDefExtensionFilename )
						$myInPath = $sMyFileOpenDialog1
					EndIf
					Local $iFileExists = FileExists ( $myInPath )
					If $iFileExists = 0 Then
						MemoWrite ( @CRLF & "---" & @CRLF & "Waitng for your command :)" & @CRLF & "---" )
					Else
						Local $sPidHandle = ProcessExists ( "Adobe Desktop Service.exe" )
						$sPidHandle = _WinAPI_OpenProcess ( 1 , 0 , $sPidHandle )
						DllCall ( "kernel32.dll" , "int" , "TerminateProcess" , "int" , $sPidHandle , "int" , 1 )
						$sPidHandle = ProcessExists ( "Creative Cloud.exe" )
						$sPidHandle = _WinAPI_OpenProcess ( 1 , 0 , $sPidHandle )
						DllCall ( "kernel32.dll" , "int" , "TerminateProcess" , "int" , $sPidHandle , "int" , 1 )
						MyGlobalPatternSearch ( $myInPath , $aPathSplitPea , $aPathSplitEAC , $aPathSplitFrontend )
					EndIf
				EndSelect
			Else
				$myIButtonClicked = 0
				$myInPath = ""
			EndIf
			If $a_idChkState [ $x ] = 1 Then
				WinWaitClose ( "GenPPP-2.7" , "" )
			Else
			EndIf
			GUICtrlSetState ( $a_idChk [ $x ] , 4 )
		Next

		; Re-enable controls
		For $x = 0 To 23
			GUICtrlSetState ( $a_idChk [ $x ] , $GUI_ENABLE )
		Next
		GUICtrlSetData ( $myOwnIdProgress , 0 )
		GUICtrlSetState ( $idButton_path2019 , $GUI_ENABLE )
		GUICtrlSetState ( $idButton_path2020 , $GUI_ENABLE )
		GUICtrlSetState ( $idButton_path2021 , $GUI_ENABLE )
		GUICtrlSetState ( $idButton_path2022 , $GUI_ENABLE )
		GUICtrlSetState ( $g_idDeselectAll , $GUI_ENABLE )
		GUICtrlSetState ( $idBtnCure , $GUI_ENABLE )

		; Reset options
		$a_idPath = $a_idPathNull
		For $x = 0 To 23
			GUICtrlSetState ( $a_idChk [ $x ] , $GUI_UNCHECKED )
			_ArrayAdd ( $a_idPath , "" )
		Next
		_DisableProblematicApps ( )
		$myIButtonClicked = 0
		MemoWrite ( @CRLF & "---" & @CRLF & "Manual mode - custom path" & @CRLF & "---" )
	EndSelect
WEnd

; Initializes the GUI
Func MainGui ( )
	$myHGui = GUICreate ( "Adobe-GenP-2.7" , 540 , 600 , + 4294967295 , + 4294967295 , BitOR ( $WS_CAPTION , $WS_MINIMIZEBOX , $WS_EX_APPWINDOW , $DS_SETFOREGROUND ) )
	Local $style = _WINAPI_GETWINDOWLONG ( $myHGui , $GWL_STYLE )
	If BitAND ( $style , BitOR ( $WS_SIZEBOX , $WS_MAXIMIZEBOX ) ) Then
		_WINAPI_SETWINDOWLONG ( $myHGui , $GWL_STYLE , BitXOR ( $style , $WS_SIZEBOX ) )
	EndIf
	GUISetState ( @SW_SHOW )
	$y = 80
	For $x = 0 To 7
		$a_idChk [ $x ] = GUICtrlCreateCheckbox ( "" , 50 , $y + 4294967236 , 120 , 25 )
		GUICtrlCreatePic ( ".\ICONS\" & $x & ".jpg" , 20 , $y + 4294967238 , 24 , 24 )
		GUICtrlSetState ( $a_idChk [ $x ] , 4 )
		$y += 40
	Next
	$y = 80
	For $x = 8 To 15
		$a_idChk [ $x ] = GUICtrlCreateCheckbox ( "" , 230 , $y + 4294967236 , 120 , 25 )
		GUICtrlCreatePic ( ".\ICONS\" & $x & ".jpg" , 200 , $y + 4294967238 , 24 , 24 )
		GUICtrlSetState ( $a_idChk [ $x ] , 4 )
		$y += 40
	Next
	$y = 80
	For $x = 16 To 23
		$a_idChk [ $x ] = GUICtrlCreateCheckbox ( "" , 410 , $y + 4294967236 , 120 , 25 )
		GUICtrlCreatePic ( ".\ICONS\" & $x & ".jpg" , 380 , $y + 4294967238 , 24 , 24 )
		GUICtrlSetState ( $a_idChk [ $x ] , 4 )
		$y += 40
	Next
	_DisableProblematicApps ( )
	$idButton_path2019 = GUICtrlCreateButton ( "CC2019" , 30 , 380 , 80 , 20 )
	GUICtrlSetTip ( + 4294967295 , "Let GenP find CC2019 Apps automatically in def location" )
	$idButton_path2020 = GUICtrlCreateButton ( "CC2020" , 130 , 380 , 80 , 20 )
	GUICtrlSetTip ( + 4294967295 , "Let GenP find CC2020 Apps automatically in def location" )
	$g_idDeselectAll = GUICtrlCreateButton ( "" , 230 , 380 , 80 , 20 )
	GUICtrlSetData ( $g_idDeselectAll , "Reset Paths" )
	GUICtrlSetTip ( + 4294967295 , "Reset ALL paths - Manual mode" )
	$idButton_path2021 = GUICtrlCreateButton ( "CC2021" , 330 , 380 , 80 , 20 )
	GUICtrlSetTip ( + 4294967295 , "Let GenP find CC2021 Apps automatically in def location" )
	$idButton_path2022 = GUICtrlCreateButton ( "CC2022" , 430 , 380 , 80 , 20 )
	GUICtrlSetTip ( + 4294967295 , "Let GenP find CC2022 Apps automatically in def location" )
	$myOwnIdProgress = GUICtrlCreateProgress ( 170 , 350 , 200 , 10 , $PBS_SMOOTHREVERSE )
	$g_idMemo = GUICtrlCreateEdit ( "" , 20 , 420 , 500 , 80 , BitOR ( $ES_READONLY , $ES_CENTER , $WS_DISABLED ) )
	MemoWrite ( @CRLF & "---" & @CRLF & "Manual mode - custom path" & @CRLF & "---" )
	$idBtnCure = GUICtrlCreateButton ( "" , 240 , 520 , 56 , 56 , $BS_BITMAP )
	_GuiCtrlButton_SetImage ( $idBtnCure , ".\ICONS\Cure.bmp" )
	GUICtrlSetTip ( + 4294967295 , "Cure" )
	GUICtrlSetData ( $a_idChk [ 0 ] , "1. After Effects" )
	GUICtrlSetData ( $a_idChk [ 1 ] , "2. Animate" )
	GUICtrlSetData ( $a_idChk [ 2 ] , "3. Audition" )
	GUICtrlSetData ( $a_idChk [ 3 ] , "4. Bridge" )
	GUICtrlSetData ( $a_idChk [ 4 ] , "5. Character Animator" )
	GUICtrlSetData ( $a_idChk [ 5 ] , "6. Dreamweaver" )
	GUICtrlSetData ( $a_idChk [ 6 ] , "7. Illustrator" )
	GUICtrlSetData ( $a_idChk [ 7 ] , "8. InCopy" )
	GUICtrlSetData ( $a_idChk [ 8 ] , "9. InDesign" )
	GUICtrlSetData ( $a_idChk [ 9 ] , "10. Lightroom" )
	GUICtrlSetData ( $a_idChk [ 10 ] , "11. Lightroom Classic" )
	GUICtrlSetData ( $a_idChk [ 11 ] , "12. Media Encoder" )
	GUICtrlSetData ( $a_idChk [ 12 ] , "13. Photoshop" )
	GUICtrlSetData ( $a_idChk [ 13 ] , "14. Prelude" )
	GUICtrlSetData ( $a_idChk [ 14 ] , "15. Premiere Pro" )
	GUICtrlSetData ( $a_idChk [ 15 ] , "16. Premiere Rush" )
	GUICtrlSetData ( $a_idChk [ 16 ] , "17. Acrobat" )
	GUICtrlSetData ( $a_idChk [ 17 ] , "18. Dimension" )
	GUICtrlSetData ( $a_idChk [ 18 ] , "19. XD" )
	GUICtrlSetData ( $a_idChk [ 19 ] , "20. Fresco" )
	GUICtrlSetData ( $a_idChk [ 20 ] , "21. Flash Builder" )
	GUICtrlSetData ( $a_idChk [ 21 ] , "22. Speed Grade" )
	GUICtrlSetData ( $a_idChk [ 22 ] , "-----------------------" )
	GUICtrlSetState ( $a_idChk [ 22 ] , 160 )
	GUICtrlSetData ( $a_idChk [ 23 ] , "24. Creative Cloud" )
EndFunc

; Sets up paths to CC 2019 products
Func FillArrayPath2019 ( )
	_ArrayAdd ( $a_idPath , $myDefPath & "\Adobe After Effects CC 2019\Support Files\AfterFXLib.dll" )
	_ArrayAdd ( $a_idPath , $myDefPath & "\Adobe Animate CC 2019\Animate.exe" )
	_ArrayAdd ( $a_idPath , $myDefPath & "\Adobe Audition CC 2019\auui.dll" )
	_ArrayAdd ( $a_idPath , $myDefPath & "\Adobe Bridge CC 2019\bridge.exe" )
	_ArrayAdd ( $a_idPath , $myDefPath & "\Adobe Character Animator CC 2019\Support Files\character animator.exe" )
	_ArrayAdd ( $a_idPath , $myDefPath & "\Adobe Dreamweaver CC 2019\dreamweaver.exe" )
	_ArrayAdd ( $a_idPath , $myDefPath & "\Adobe Illustrator CC 2019\Support Files\Contents\Windows\illustrator.exe" )
	_ArrayAdd ( $a_idPath , $myDefPath & "\Adobe InCopy CC 2019\public.dll" )
	_ArrayAdd ( $a_idPath , $myDefPath & "\Adobe InDesign CC 2019\public.dll" )
	Local $sFilenameTempLR = FileFindNextFile ( FileFindFirstFile ( $myDefPath & "\Adobe Lightroom CC\lightroomcc.exe" ) )
	$sFilenameTempLR = $myDefPath & "\Adobe Lightroom CC\lightroomcc.exe"
	If FileExists ( $sFilenameTempLR ) = 1 Then
		$sFilenameTempLR = $myDefPath & "\Adobe Lightroom CC\lightroomcc.exe"
	Else
		$sFilenameTempLR = FileFindNextFile ( FileFindFirstFile ( $myDefPath & "\Adobe Lightroom CC\lightroom.exe" ) )
		$sFilenameTempLR = $myDefPath & "\Adobe Lightroom CC\lightroom.exe"
	EndIf
	_ArrayAdd ( $a_idPath , $sFilenameTempLR )
	Local $sFilenameTempLRCC = FileFindNextFile ( FileFindFirstFile ( $myDefPath & "\Adobe Lightroom Classic CC\lightroom.exe" ) )
	$sFilenameTempLRCC = $myDefPath & "\Adobe Lightroom Classic CC\lightroom.exe"
	If FileExists ( $sFilenameTempLRCC ) = 1 Then
		$sFilenameTempLRCC = $myDefPath & "\Adobe Lightroom Classic CC\lightroom.exe"
	Else
		$sFilenameTempLRCC = FileFindNextFile ( FileFindFirstFile ( $myDefPath & "\Adobe Lightroom Classic\lightroom.exe" ) )
		$sFilenameTempLRCC = $myDefPath & "\Adobe Lightroom Classic\lightroom.exe"
	EndIf
	_ArrayAdd ( $a_idPath , $sFilenameTempLRCC )
	_ArrayAdd ( $a_idPath , $myDefPath & "\Adobe Media Encoder CC 2019\Adobe Media Encoder.exe" )
	_ArrayAdd ( $a_idPath , $myDefPath & "\Adobe Photoshop CC 2019\photoshop.exe" )
	_ArrayAdd ( $a_idPath , $myDefPath & "\Adobe Prelude CC 2019\registration.dll" )
	_ArrayAdd ( $a_idPath , $myDefPath & "\Adobe Premiere Pro CC 2019\registration.dll" )
	_ArrayAdd ( $a_idPath , $myDefPath & "\Adobe Premiere Rush CC\registration.dll" )
	_ArrayAdd ( $a_idPath , "C:\Program Files (x86)\Adobe\Acrobat DC\Acrobat\Acrobat.dll" )
	_ArrayAdd ( $a_idPath , $myDefPath & "\Adobe Dimension CC\euclid-core-plugin.pepper" )
	Local $sFilenameTempXD = FileFindNextFile ( FileFindFirstFile ( "C:\Program Files\WindowsApps\Adobe.CC.XD*" ) )
	Local $myInPathTempXD0 = "C:\Program Files\WindowsApps\" & $sFilenameTempXD & "\XD*.exe"
	Local $sFilenameTempXD1 = FileFindNextFile ( FileFindFirstFile ( $myInPathTempXD0 ) )
	If $sFilenameTempXD1 = "" Then
		_ArrayAdd ( $a_idPath , "" )
	Else
		Local $sFilenameTempXD2 = "C:\Program Files\WindowsApps\" & $sFilenameTempXD & "\" & $sFilenameTempXD1
		_ArrayAdd ( $a_idPath , $sFilenameTempXD2 )
	EndIf
	Local $sFilenameTempFR = FileFindNextFile ( FileFindFirstFile ( "C:\Program Files\WindowsApps\Adobe.Fresco*" ) )
	Local $myInPathTempFR0 = "C:\Program Files\WindowsApps\" & $sFilenameTempFR & "\ngl-lib.dll"
	Local $sFilenameTempFR1 = FileFindNextFile ( FileFindFirstFile ( $myInPathTempFR0 ) )
	If $sFilenameTempFR1 = "" Then
		_ArrayAdd ( $a_idPath , "" )
	Else
		Local $sFilenameTempFR2 = "C:\Program Files\WindowsApps\" & $sFilenameTempFR & "\" & $sFilenameTempFR1
		_ArrayAdd ( $a_idPath , $sFilenameTempFR2 )
	EndIf
	_ArrayAdd ( $a_idPath , $myDefPath & "\Adobe Flash Builder 4.7 (64 Bit)\eclipse\plugins\com.adobe.flexide.amt_4.7.0.349722\os\win32\x86_64\amtlib.dll" )
	_ArrayAdd ( $a_idPath , $myDefPath & "\Adobe SpeedGrade CC 2015\amtlib.dll" )
	_ArrayAdd ( $a_idPath , $myDefPath & "" )
	_ArrayAdd ( $a_idPath , "C:\Program Files (x86)\Adobe\Adobe Creative Cloud\AppsPanel\AppsPanelBL.dll" )
EndFunc
; Sets up paths to CC 2020 products
Func FillArrayPath2020 ( )
	_ArrayAdd ( $a_idPath , $myDefPath & "\Adobe After Effects 2020\Support Files\AfterFXLib.dll" )
	_ArrayAdd ( $a_idPath , $myDefPath & "\Adobe Animate 2020\Animate.exe" )
	_ArrayAdd ( $a_idPath , $myDefPath & "\Adobe Audition 2020\auui.dll" )
	_ArrayAdd ( $a_idPath , $myDefPath & "\Adobe Bridge 2020\bridge.exe" )
	_ArrayAdd ( $a_idPath , $myDefPath & "\Adobe Character Animator 2020\Support Files\character animator.exe" )
	_ArrayAdd ( $a_idPath , $myDefPath & "\Adobe Dreamweaver 2020\dreamweaver.exe" )
	_ArrayAdd ( $a_idPath , $myDefPath & "\Adobe Illustrator 2020\Support Files\Contents\Windows\illustrator.exe" )
	_ArrayAdd ( $a_idPath , $myDefPath & "\Adobe InCopy 2020\public.dll" )
	_ArrayAdd ( $a_idPath , $myDefPath & "\Adobe InDesign 2020\public.dll" )
	Local $sFilenameTempLR = FileFindNextFile ( FileFindFirstFile ( $myDefPath & "\Adobe Lightroom CC\lightroomcc.exe" ) )
	$sFilenameTempLR = $myDefPath & "\Adobe Lightroom CC\lightroomcc.exe"
	If FileExists ( $sFilenameTempLR ) = 1 Then
		$sFilenameTempLR = $myDefPath & "\Adobe Lightroom CC\lightroomcc.exe"
	Else
		$sFilenameTempLR = FileFindNextFile ( FileFindFirstFile ( $myDefPath & "\Adobe Lightroom CC\lightroom.exe" ) )
		$sFilenameTempLR = $myDefPath & "\Adobe Lightroom CC\lightroom.exe"
	EndIf
	_ArrayAdd ( $a_idPath , $sFilenameTempLR )
	Local $sFilenameTempLRCC = FileFindNextFile ( FileFindFirstFile ( $myDefPath & "\Adobe Lightroom Classic CC\lightroom.exe" ) )
	$sFilenameTempLRCC = $myDefPath & "\Adobe Lightroom Classic CC\lightroom.exe"
	If FileExists ( $sFilenameTempLRCC ) = 1 Then
		$sFilenameTempLRCC = $myDefPath & "\Adobe Lightroom Classic CC\lightroom.exe"
	Else
		$sFilenameTempLRCC = FileFindNextFile ( FileFindFirstFile ( $myDefPath & "\Adobe Lightroom Classic\lightroom.exe" ) )
		$sFilenameTempLRCC = $myDefPath & "\Adobe Lightroom Classic\lightroom.exe"
	EndIf
	_ArrayAdd ( $a_idPath , $sFilenameTempLRCC )
	_ArrayAdd ( $a_idPath , $myDefPath & "\Adobe Media Encoder 2020\Adobe Media Encoder.exe" )
	_ArrayAdd ( $a_idPath , $myDefPath & "\Adobe Photoshop 2020\photoshop.exe" )
	_ArrayAdd ( $a_idPath , $myDefPath & "\Adobe Prelude 2020\registration.dll" )
	_ArrayAdd ( $a_idPath , $myDefPath & "\Adobe Premiere Pro 2020\registration.dll" )
	_ArrayAdd ( $a_idPath , $myDefPath & "\Adobe Premiere Rush\registration.dll" )
	_ArrayAdd ( $a_idPath , "C:\Program Files (x86)\Adobe\Acrobat DC\Acrobat\Acrobat.dll" )
	_ArrayAdd ( $a_idPath , $myDefPath & "\Adobe Dimension\euclid-core-plugin.pepper" )
	Local $sFilenameTempXD = FileFindNextFile ( FileFindFirstFile ( "C:\Program Files\WindowsApps\Adobe.CC.XD*" ) )
	Local $myInPathTempXD0 = "C:\Program Files\WindowsApps\" & $sFilenameTempXD & "\XD*.exe"
	Local $sFilenameTempXD1 = FileFindNextFile ( FileFindFirstFile ( $myInPathTempXD0 ) )
	If $sFilenameTempXD1 = "" Then
		_ArrayAdd ( $a_idPath , "" )
	Else
		Local $sFilenameTempXD2 = "C:\Program Files\WindowsApps\" & $sFilenameTempXD & "\" & $sFilenameTempXD1
		_ArrayAdd ( $a_idPath , $sFilenameTempXD2 )
	EndIf
	Local $sFilenameTempFR = FileFindNextFile ( FileFindFirstFile ( "C:\Program Files\WindowsApps\Adobe.Fresco*" ) )
	Local $myInPathTempFR0 = "C:\Program Files\WindowsApps\" & $sFilenameTempFR & "\ngl-lib.dll"
	Local $sFilenameTempFR1 = FileFindNextFile ( FileFindFirstFile ( $myInPathTempFR0 ) )
	If $sFilenameTempFR1 = "" Then
		_ArrayAdd ( $a_idPath , "" )
	Else
		Local $sFilenameTempFR2 = "C:\Program Files\WindowsApps\" & $sFilenameTempFR & "\" & $sFilenameTempFR1
		_ArrayAdd ( $a_idPath , $sFilenameTempFR2 )
	EndIf
	_ArrayAdd ( $a_idPath , $myDefPath & "\Adobe Flash Builder 4.7 (64 Bit)\eclipse\plugins\com.adobe.flexide.amt_4.7.0.349722\os\win32\x86_64\amtlib.dll" )
	_ArrayAdd ( $a_idPath , $myDefPath & "\Adobe SpeedGrade CC 2015\amtlib.dll" )
	_ArrayAdd ( $a_idPath , $myDefPath & "" )
	_ArrayAdd ( $a_idPath , "C:\Program Files (x86)\Common Files\Adobe\Adobe Desktop Common\AppsPanel\AppsPanelBL.dll" )
EndFunc
; Sets up paths to CC 2021 products
Func FillArrayPath2021 ( )
	_ArrayAdd ( $a_idPath , $myDefPath & "\Adobe After Effects 2021\Support Files\AfterFXLib.dll" )
	_ArrayAdd ( $a_idPath , $myDefPath & "\Adobe Animate 2021\Animate.exe" )
	_ArrayAdd ( $a_idPath , $myDefPath & "\Adobe Audition 2021\auui.dll" )
	_ArrayAdd ( $a_idPath , $myDefPath & "\Adobe Bridge 2021\bridge.exe" )
	_ArrayAdd ( $a_idPath , $myDefPath & "\Adobe Character Animator 2021\Support Files\character animator.exe" )
	_ArrayAdd ( $a_idPath , $myDefPath & "\Adobe Dreamweaver 2021\dreamweaver.exe" )
	_ArrayAdd ( $a_idPath , $myDefPath & "\Adobe Illustrator 2021\Support Files\Contents\Windows\illustrator.exe" )
	_ArrayAdd ( $a_idPath , $myDefPath & "\Adobe InCopy 2021\public.dll" )
	_ArrayAdd ( $a_idPath , $myDefPath & "\Adobe InDesign 2021\public.dll" )
	Local $sFilenameTempLR = FileFindNextFile ( FileFindFirstFile ( $myDefPath & "\Adobe Lightroom CC\lightroomcc.exe" ) )
	$sFilenameTempLR = $myDefPath & "\Adobe Lightroom CC\lightroomcc.exe"
	If FileExists ( $sFilenameTempLR ) = 1 Then
		$sFilenameTempLR = $myDefPath & "\Adobe Lightroom CC\lightroomcc.exe"
	Else
		$sFilenameTempLR = FileFindNextFile ( FileFindFirstFile ( $myDefPath & "\Adobe Lightroom CC\lightroom.exe" ) )
		$sFilenameTempLR = $myDefPath & "\Adobe Lightroom CC\lightroom.exe"
	EndIf
	_ArrayAdd ( $a_idPath , $sFilenameTempLR )
	Local $sFilenameTempLRCC = FileFindNextFile ( FileFindFirstFile ( $myDefPath & "\Adobe Lightroom Classic CC\lightroom.exe" ) )
	$sFilenameTempLRCC = $myDefPath & "\Adobe Lightroom Classic CC\lightroom.exe"
	If FileExists ( $sFilenameTempLRCC ) = 1 Then
		$sFilenameTempLRCC = $myDefPath & "\Adobe Lightroom Classic CC\lightroom.exe"
	Else
		$sFilenameTempLRCC = FileFindNextFile ( FileFindFirstFile ( $myDefPath & "\Adobe Lightroom Classic\lightroom.exe" ) )
		$sFilenameTempLRCC = $myDefPath & "\Adobe Lightroom Classic\lightroom.exe"
	EndIf
	_ArrayAdd ( $a_idPath , $sFilenameTempLRCC )
	_ArrayAdd ( $a_idPath , $myDefPath & "\Adobe Media Encoder 2021\Adobe Media Encoder.exe" )
	_ArrayAdd ( $a_idPath , $myDefPath & "\Adobe Photoshop 2021\photoshop.exe" )
	_ArrayAdd ( $a_idPath , $myDefPath & "\Adobe Prelude 2021\registration.dll" )
	_ArrayAdd ( $a_idPath , $myDefPath & "\Adobe Premiere Pro 2021\registration.dll" )
	_ArrayAdd ( $a_idPath , $myDefPath & "\Adobe Premiere Rush\registration.dll" )
	_ArrayAdd ( $a_idPath , "C:\Program Files (x86)\Adobe\Acrobat DC\Acrobat\Acrobat.dll" )
	_ArrayAdd ( $a_idPath , $myDefPath & "\Adobe Dimension\euclid-core-plugin.pepper" )
	Local $sFilenameTempXD = FileFindNextFile ( FileFindFirstFile ( "C:\Program Files\WindowsApps\Adobe.CC.XD*" ) )
	Local $myInPathTempXD0 = "C:\Program Files\WindowsApps\" & $sFilenameTempXD & "\XD*.exe"
	Local $sFilenameTempXD1 = FileFindNextFile ( FileFindFirstFile ( $myInPathTempXD0 ) )
	If $sFilenameTempXD1 = "" Then
		_ArrayAdd ( $a_idPath , "" )
	Else
		Local $sFilenameTempXD2 = "C:\Program Files\WindowsApps\" & $sFilenameTempXD & "\" & $sFilenameTempXD1
		_ArrayAdd ( $a_idPath , $sFilenameTempXD2 )
	EndIf
	Local $sFilenameTempFR = FileFindNextFile ( FileFindFirstFile ( "C:\Program Files\WindowsApps\Adobe.Fresco*" ) )
	Local $myInPathTempFR0 = "C:\Program Files\WindowsApps\" & $sFilenameTempFR & "\ngl-lib.dll"
	Local $sFilenameTempFR1 = FileFindNextFile ( FileFindFirstFile ( $myInPathTempFR0 ) )
	If $sFilenameTempFR1 = "" Then
		_ArrayAdd ( $a_idPath , "" )
	Else
		Local $sFilenameTempFR2 = "C:\Program Files\WindowsApps\" & $sFilenameTempFR & "\" & $sFilenameTempFR1
		_ArrayAdd ( $a_idPath , $sFilenameTempFR2 )
	EndIf
	_ArrayAdd ( $a_idPath , $myDefPath & "\Adobe Flash Builder 4.7 (64 Bit)\eclipse\plugins\com.adobe.flexide.amt_4.7.0.349722\os\win32\x86_64\amtlib.dll" )
	_ArrayAdd ( $a_idPath , $myDefPath & "\Adobe SpeedGrade CC 2015\amtlib.dll" )
	_ArrayAdd ( $a_idPath , $myDefPath & "" )
	_ArrayAdd ( $a_idPath , "C:\Program Files (x86)\Common Files\Adobe\Adobe Desktop Common\AppsPanel\AppsPanelBL.dll" )
EndFunc
; Sets up paths to CC 2022 products
Func FillArrayPath2022 ( )
	_ArrayAdd ( $a_idPath , $myDefPath & "\Adobe After Effects 2022\Support Files\AfterFXLib.dll" )
	_ArrayAdd ( $a_idPath , $myDefPath & "\Adobe Animate 2022\Animate.exe" )
	_ArrayAdd ( $a_idPath , $myDefPath & "\Adobe Audition 2022\auui.dll" )
	_ArrayAdd ( $a_idPath , $myDefPath & "\Adobe Bridge 2022\bridge.exe" )
	_ArrayAdd ( $a_idPath , $myDefPath & "\Adobe Character Animator 2022\Support Files\character animator.exe" )
	_ArrayAdd ( $a_idPath , $myDefPath & "\Adobe Dreamweaver 2022\dreamweaver.exe" )
	_ArrayAdd ( $a_idPath , $myDefPath & "\Adobe Illustrator 2022\Support Files\Contents\Windows\illustrator.exe" )
	_ArrayAdd ( $a_idPath , $myDefPath & "\Adobe InCopy 2022\public.dll" )
	_ArrayAdd ( $a_idPath , $myDefPath & "\Adobe InDesign 2022\public.dll" )
	Local $sFilenameTempLR = FileFindNextFile ( FileFindFirstFile ( $myDefPath & "\Adobe Lightroom CC\lightroomcc.exe" ) )
	$sFilenameTempLR = $myDefPath & "\Adobe Lightroom CC\lightroomcc.exe"
	If FileExists ( $sFilenameTempLR ) = 1 Then
		$sFilenameTempLR = $myDefPath & "\Adobe Lightroom CC\lightroomcc.exe"
	Else
		$sFilenameTempLR = FileFindNextFile ( FileFindFirstFile ( $myDefPath & "\Adobe Lightroom CC\lightroom.exe" ) )
		$sFilenameTempLR = $myDefPath & "\Adobe Lightroom CC\lightroom.exe"
	EndIf
	_ArrayAdd ( $a_idPath , $sFilenameTempLR )
	Local $sFilenameTempLRCC = FileFindNextFile ( FileFindFirstFile ( $myDefPath & "\Adobe Lightroom Classic CC\lightroom.exe" ) )
	$sFilenameTempLRCC = $myDefPath & "\Adobe Lightroom Classic CC\lightroom.exe"
	If FileExists ( $sFilenameTempLRCC ) = 1 Then
		$sFilenameTempLRCC = $myDefPath & "\Adobe Lightroom Classic CC\lightroom.exe"
	Else
		$sFilenameTempLRCC = FileFindNextFile ( FileFindFirstFile ( $myDefPath & "\Adobe Lightroom Classic\lightroom.exe" ) )
		$sFilenameTempLRCC = $myDefPath & "\Adobe Lightroom Classic\lightroom.exe"
	EndIf
	_ArrayAdd ( $a_idPath , $sFilenameTempLRCC )
	_ArrayAdd ( $a_idPath , $myDefPath & "\Adobe Media Encoder 2022\Adobe Media Encoder.exe" )
	_ArrayAdd ( $a_idPath , $myDefPath & "\Adobe Photoshop 2022\photoshop.exe" )
	_ArrayAdd ( $a_idPath , $myDefPath & "\Adobe Prelude 2022\registration.dll" )
	_ArrayAdd ( $a_idPath , $myDefPath & "\Adobe Premiere Pro 2022\registration.dll" )
	_ArrayAdd ( $a_idPath , $myDefPath & "\Adobe Premiere Rush\registration.dll" )
	_ArrayAdd ( $a_idPath , "C:\Program Files (x86)\Adobe\Acrobat DC\Acrobat\Acrobat.dll" )
	_ArrayAdd ( $a_idPath , $myDefPath & "\Adobe Dimension\euclid-core-plugin.pepper" )
	Local $sFilenameTempXD = FileFindNextFile ( FileFindFirstFile ( "C:\Program Files\WindowsApps\Adobe.CC.XD*" ) )
	Local $myInPathTempXD0 = "C:\Program Files\WindowsApps\" & $sFilenameTempXD & "\XD*.exe"
	Local $sFilenameTempXD1 = FileFindNextFile ( FileFindFirstFile ( $myInPathTempXD0 ) )
	If $sFilenameTempXD1 = "" Then
		_ArrayAdd ( $a_idPath , "" )
	Else
		Local $sFilenameTempXD2 = "C:\Program Files\WindowsApps\" & $sFilenameTempXD & "\" & $sFilenameTempXD1
		_ArrayAdd ( $a_idPath , $sFilenameTempXD2 )
	EndIf
	Local $sFilenameTempFR = FileFindNextFile ( FileFindFirstFile ( "C:\Program Files\WindowsApps\Adobe.Fresco*" ) )
	Local $myInPathTempFR0 = "C:\Program Files\WindowsApps\" & $sFilenameTempFR & "\ngl-lib.dll"
	Local $sFilenameTempFR1 = FileFindNextFile ( FileFindFirstFile ( $myInPathTempFR0 ) )
	If $sFilenameTempFR1 = "" Then
		_ArrayAdd ( $a_idPath , "" )
	Else
		Local $sFilenameTempFR2 = "C:\Program Files\WindowsApps\" & $sFilenameTempFR & "\" & $sFilenameTempFR1
		_ArrayAdd ( $a_idPath , $sFilenameTempFR2 )
	EndIf
	_ArrayAdd ( $a_idPath , $myDefPath & "\Adobe Flash Builder 4.7 (64 Bit)\eclipse\plugins\com.adobe.flexide.amt_4.7.0.349722\os\win32\x86_64\amtlib.dll" )
	_ArrayAdd ( $a_idPath , $myDefPath & "\Adobe SpeedGrade CC 2015\amtlib.dll" )
	_ArrayAdd ( $a_idPath , $myDefPath & "" )
	_ArrayAdd ( $a_idPath , "C:\Program Files (x86)\Common Files\Adobe\Adobe Desktop Common\AppsPanel\AppsPanelBL.dll" )
EndFunc

; Checks for the Adobe products at their paths
; Sets checkbox if it exists
Func CheckPathes ( )
	For $x = 0 To 23
		If FileExists ( $a_idPath [ $x ] ) Then
			GUICtrlSetState ( $a_idChk [ $x ] , 1 )
		EndIf
	Next
EndFunc

; Resets checkboxes and sets up paths to CC 2019 products
Func SelectCustomFolder2019 ( )
	For $x = 0 To 23
		GUICtrlSetState ( $a_idChk [ $x ] , $GUI_UNCHECKED )
	Next
	$a_idPath = $a_idPathNull
	FillArrayPath2019 ( )
	CheckPathes ( )
EndFunc
; Resets checkboxes and sets up paths to CC 2020 products
Func SelectCustomFolder2020 ( )
	For $x = 0 To 23
		GUICtrlSetState ( $a_idChk [ $x ] , $GUI_UNCHECKED )
	Next
	$a_idPath = $a_idPathNull
	FillArrayPath2020 ( )
	CheckPathes ( )
EndFunc
; Resets checkboxes and sets up paths to CC 2021 products
Func SelectCustomFolder2021 ( )
	For $x = 0 To 23
		GUICtrlSetState ( $a_idChk [ $x ] , $GUI_UNCHECKED )
	Next
	$a_idPath = $a_idPathNull
	FillArrayPath2021 ( )
	CheckPathes ( )
EndFunc
; Resets checkboxes and sets up paths to CC 2022 products
Func SelectCustomFolder2022 ( )
	For $x = 0 To 23
		GUICtrlSetState ( $a_idChk [ $x ] , $GUI_UNCHECKED )
	Next
	$a_idPath = $a_idPathNull
	FillArrayPath2022 ( )
	CheckPathes ( )
EndFunc

; Opens file dialog
Func MyFileOpenDialog ( $myDefaultPath , $myDefaultText , $myDefaultName )
	Local Const $sMessage = "Select file to patch."
	Local $sMyFileOpenDialog = FileOpenDialog ( $sMessage , $myDefaultPath & "\" , $myDefaultText , $FD_FILEMUSTEXIST , $myDefaultName , $myHGui )
	If @error Then
		FileChangeDir ( @ScriptDir )
	Else
		FileChangeDir ( @WorkingDir )
		$sMyFileOpenDialog = StringReplace ( $sMyFileOpenDialog , "|" , @CRLF )
		$sMyFileOpenDialog1 = $sMyFileOpenDialog
		$sMyDefaultSearchPath = @WorkingDir
	EndIf
EndFunc

; Sets the memo message
Func MemoWrite ( $sMessage )
	GUICtrlSetData ( $g_idMemo , $sMessage )
EndFunc

; Starts GenPPP-2.7.exe to perform patching of given file
Func MyGlobalPatternSearch ( $myFileToParse , $myFileToParseSweetPea , $myFileToParseEAClient , $myFileToParseFrontend )
	MemoWrite ( $myIButtonClicked & @CRLF & "---" & @CRLF & "Preparing to Analyze" & @CRLF & "---" & @CRLF & "*" )

	Local $sPidHandle = ProcessExists ( "GenPPP-2.7.exe" )
	ProcessClose ( $sPidHandle )
	_ProcessCloseEx ( $sPidHandle )
	Local $sPidHandle = ProcessExists ( "GenPPP-2.7.exe" )
	ProcessClose ( $sPidHandle )
	_ProcessCloseEx ( $sPidHandle )
	$sPidHandle = _WinAPI_OpenProcess ( 1 , 0 , $sPidHandle )
	DllCall ( "kernel32.dll" , "int" , "TerminateProcess" , "int" , $sPidHandle , "int" , 1 )

	ShellExecute ( @ScriptDir & "\GenPPP-2.7.exe" )
	Local $myRunTimeout = WinWait ( "GenPPP-2.7" , "" , 5 )
	If $myRunTimeout = 0 Then
		MemoWrite ( @CRLF & "---" & @CRLF & "GenPPP-2.7.exe failed to start" & @CRLF & "---" )
		Sleep ( 3000 )
		$aPathSplitPea = ""
		$aPathSplitEAC = ""
		$aPathSplitFrontend = ""
		MemoWrite ( @CRLF & "---" & @CRLF & "Waitng for your command :)" & @CRLF & "---" )
	Else
		MemoWrite ( $myIButtonClicked & @CRLF & "---" & @CRLF & "Preparing to Analyze" & @CRLF & "---" & @CRLF & "***" )
		Sleep ( 100 )

		; Send data over to GenPPP-2.7
		$hWndChildWindow = WinGetHandle ( "GenPPP-2.7" )
		ControlSetText ( $hWndChildWindow , "" , "Edit1" , $myFileToParse )
		ControlSetText ( $hWndChildWindow , "" , "Edit2" , $myFileToParseSweetPea )
		ControlSetText ( $hWndChildWindow , "" , "Edit3" , $myFileToParseEAClient )
		ControlSetText ( $hWndChildWindow , "" , "Edit4" , $myFileToParseFrontend )
		ControlSetText ( $hWndChildWindow , "" , "Edit5" , $myIButtonClicked )
		ControlSetText ( $hWndChildWindow , "" , "Edit6" , 1 )
	EndIf
	$myInPath = ""
EndFunc

; Closes process with taskkill
Func _ProcessCloseEx ( $sPidHandle )
	If IsString ( $sPidHandle ) Then $sPidHandle = ProcessExists ( $sPidHandle )
	If Not $sPidHandle Then Return SetError ( 1 , 0 , 0 )
	Return Run ( @ComSpec & " /c taskkill /F /PID " & $sPidHandle & " /T" , @SystemDir , @SW_HIDE )
EndFunc

; Deselects "Flash Builder" and "Speed Grade"
Func _DisableProblematicApps ( )
	GUICtrlSetState ( $a_idChk [ 20 ] , $GUI_UNCHECKED + $GUI_DISABLE )
	GUICtrlSetState ( $a_idChk [ 21 ] , $GUI_UNCHECKED + $GUI_DISABLE )
EndFunc
