#RequireAdmin

; Original includes when decompiled
; #include <EditConstants.au3>
; #include <SendMessage.au3>
; #include <ProgressConstants.au3>
; #include <AutoItConstants.au3>
; #include <MsgBoxConstants.au3>
; #include <StringConstants.au3>
; #include <ArrayDisplayInternals.au3>
; #include <Array.au3>
; #include <FileConstants.au3>
; #include <File.au3>
; #include <FontConstants.au3>
; #include <StructureConstants.au3>
; #include <WinAPIError.au3>
; #include <Misc.au3>
; #include <MemoryConstants.au3>
; #include <ProcessConstants.au3>
; #include <SecurityConstants.au3>
; #include <Security.au3>
; #include <Memory.au3>
; #include <StatusBarConstants.au3>
; #include <UDFGlobalID.au3>
; #include <WinAPIInternals.au3>
; #include <WinAPIConv.au3>
; #include <WinAPISysInternals.au3>
; #include <GuiStatusBar.au3>
; #include <ToolTipConstants.au3>
; #include <WinAPIHObj.au3>
; #include <GuiEdit.au3>
; #include <GUIConstantsEx.au3>
; #include <WindowsConstants.au3>
; #include <StringSize.au3>
; #include <GDIPlusConstants.au3>
; #include <APIComConstants.au3>
; #include <WinAPICom.au3>
; #include <APIGdiConstants.au3>
; #include <WinAPIMem.au3>
; #include <APIMiscConstants.au3>
; #include <WinAPIMisc.au3>
; #include <WinAPIGdiInternals.au3>
; #include <WinAPIGdiDC.au3>
; #include <WinAPIIcons.au3>
; #include <WinAPIGdi.au3>
; #include <GDIPlus.au3>
; #include <APISysConstants.au3>
; #include <WinAPISysWin.au3>
; #include <WinAPISys>
; #include <ExtMsgBox.au3>

#include <EditConstants.au3>
#include <SendMessage.au3>
#include <ProgressConstants.au3>

; Regex patterns to search for and its replacement in Adobe products
; First is pattern to search for, second is its replacement
;
; For replaements that are an array, that is because the search has capturing groups. The contents around the capturing group are replaced
; The replacement is of the form below, for an replacement array of length n
; ReplacePattern[0] CapturingGroup[0] ReplacePattern[1] CapturingGroup[1] ... ReplacePattern[n-2] CapturingGroup[n-2] ReplacePattern[n-1]
;
; Example for below
; Given the occurrence
;     85C075AAAAAAAAAA750AB892010000E9
;           ~~~~~~~~~~ Capturing group
; Replacement is thus
;     31C075AAAAAAAAAA7500B800000000E9
;           ~~~~~~~~~~ Capturing group remains
Global $iPatternPROFILE_EXPIREDS = "85C075(.{8,10})750AB892010000E9"
Global $iPatternPROFILE_EXPIREDR [ 2 ] = [ "31C075" , "7500B800000000E9" ]

Global $iPatternValidateLicenseS = "83F80175(.{2})BA94010000"
Global $iPatternValidateLicenseR [ 2 ] = [ "83F80175" , "BA00000000" ]

Global $iPatternValidateLicense1S = "83F8040F95C281C293010000"
Global $iPatternValidateLicense1R [ 1 ] = [ "83F8040F95C2BA0000000090" ]

Global $iPatternValidateLicense2S = "83F8040F95C181C193010000"
Global $iPatternValidateLicense2R [ 1 ] = [ "83F8040F95C1B90000000090" ]

Global $iPatternValidateLicense3S = "83BF(.{8})0175(.{2})C7(.{6})94010000"
Global $iPatternValidateLicense3R [ 4 ] = [ "83BF" , "0175" , "C7" , "00000000" ]

Global $iPatternCmpEax6S = "85C074(.{2})83F80674(.{4})83(.{4,6})007D"
Global $iPatternCmpEax6R [ 4 ] = [ "FFC074" , "90909074" , "83" , "00EB" ]

Global $iPatternProcessV2Profile1aS = "00007504488D4850"
Global $iPatternProcessV2Profile1aR [ 1 ] = [ "00007500488D4850" ]

Global $iPatternProcessV2Profile1a1S = "00007504488D5050"
Global $iPatternProcessV2Profile1a1R [ 1 ] = [ "00007500488D5050" ]

Global $iPatternProcessV2Profile1b1S = "84C00F85(.{4})000033DB"
Global $iPatternProcessV2Profile1b1R [ 2 ] = [ "30C00F85" , "000033DB" ]

Global $iPatternProcessV2Profile1b2S = "84C00F85(.{4})0000F30F7F85(.{8})8885(.{8})48"
Global $iPatternProcessV2Profile1b2R [ 4 ] = [ "30C00F85" , "0000F30F7F85" , "8885" , "48" ]

Global $iPatternProcessV2Profile1b3S = "84C00F85(.{4})0000F30F7F85(.{8})8885(.{8})48(.{12})E8(.{8})90"
Global $iPatternProcessV2Profile1b3R [ 6 ] = [ "30C00F85" , "0000F30F7F85" , "8885" , "48" , "E8" , "90" ]

Global $iPatternProcessV2Profile1b4S = "84C00F85(.{4})000048C785"
Global $iPatternProcessV2Profile1b4R [ 2 ] = [ "30C00F85" , "000048C785" ]

Global $iPatternProcessV2Profile1CnV1S = "84C075(.{2,10})BA91010000"
Global $iPatternProcessV2Profile1CnV1R [ 2 ] = [ "84C075" , "BA00000000" ]

Global $iPatternProcessV2Profile1CnV2S = "84C075(.{2})C744(.{4})91010000"
Global $iPatternProcessV2Profile1CnV2R [ 3 ] = [ "84C075" , "C744" , "00000000" ]

Global $iPatternProcessV2Profile1d1S = "0C0F84(.{2})000000BA(.{4})0000"
Global $iPatternProcessV2Profile1d1R [ 3 ] = [ "0C0F85" , "000000BA" , "0000" ]

Global $iPatternProcessV2Profile1d2S = "0C0F84(.{4})0000C744(.{8})0000"
Global $iPatternProcessV2Profile1d2R [ 3 ] = [ "0C0F85" , "0000C744" , "0000" ]

Global $iPatternPreventInstantShutdownS = "7504B001EB0232C08805"
Global $iPatternPreventInstantShutdownR [ 1 ] = [ "7500B001EB0232C08805" ]

Global $iPatternLightSubStatus1S = "85DB0F84(.{8})83EB010F84(.{8})83(.{2})02"
Global $iPatternLightSubStatus1R [ 4 ] = [ "B3030F84" , "83EB010F84" , "83" , "02" ]

Global $iPatternLightSubStatus2S = "0FB6(.{4})84C00F85(.{8})C7"
Global $iPatternLightSubStatus2R [ 3 ] = [ "0FB6" , "30C00F85" , "C7" ]

Global $iPatternBridgeCamRawS = "84C074(.{2})8B(.{2})83(.{2})0174(.{2})83(.{2})0174(.{2})83(.{2})01"
Global $iPatternBridgeCamRawR [ 8 ] = [ "84C074" , "8B" , "83" , "01EB" , "83" , "0174" , "83" , "01" ]

Global $iPatternXDCompleteS = "807909000F84"
Global $iPatternXDCompleteR [ 1 ] = [ "C64109010F84" ]

Global $iPatternInDesignSSWS = "4883EC2833D2488D4C2430E8"
Global $iPatternInDesignSSWR [ 1 ] = [ "31C0C32833D2488D4C2430E8" ]

Global $iPatternInCopySSWS = "4883EC2833D2488D4C2430E8"
Global $iPatternInCopySSWR [ 1 ] = [ "31C0C32833D2488D4C2430E8" ]

Global $iPatternPSEshSS1 = "8338010F94C04883C428C3"
Global $iPatternPSEshSR1 [ 1 ] = [ "8308010F94C04883C428C3" ]

Global $iPatternPSEshSS2 = "833F01400F94C74885F6"
Global $iPatternPSEshSR2 [ 1 ] = [ "830F01400F94C74885F6" ]

Global $iPatternPSAIEshSS3 = "80(.{4})0000000074(.{2})B9020000003BC1"
Global $iPatternPSAIEshSR3 [ 3 ] = [ "80" , "0000000074" , "B9030000003BC1" ]

Global $iPatternAIEshSS = "8338010F94C0880233C0C3"
Global $iPatternAIEshSR [ 1 ] = [ "8308010F94C0880233C0C3" ]

Global $iPatternAEPrruplTryoutS = "4883EC28E8(.{8})83F8010F94C04883C428C3"
Global $iPatternAEPrruplTryoutR [ 2 ] = [ "4883EC28E8" , "83F80131C0904883C428C3" ]

Global $iPatternIsLicCompS = "32C0C3(.{16})0FB605(.{8})C3(.{16})0FB605(.{8})C3"
Global $iPatternIsLicCompR [ 5 ] = [ "32C0C3" , "C605" , "01C3" , "0FB605" , "C3" ]

Global $iPatternPSvideoExportS = "488BC448894808574881EC9000000048C74088FEFFFFFF488958100F2970E80F"
Global $iPatternPSvideoExportR [ 1 ] = [ "488BC448894808C34881EC9000000048C74088FEFFFFFF488958100F2970E80F" ]

Global $iPatternHevcMpegEnabler1S = "8B(.{2})FF50380FB6"
Global $iPatternHevcMpegEnabler1R [ 2 ] = [ "8B" , "FFC0900FB6" ]

Global $iPatternHevcMpegEnabler2S = "8B(.{2})FF50380FB6"
Global $iPatternHevcMpegEnabler2R [ 2 ] = [ "8B" , "FFC0900FB6" ]

Global $iPatternHevcMpegEnabler3S = "8B(.{2})FF5038(.{2})0FB6"
Global $iPatternHevcMpegEnabler3R [ 3 ] = [ "8B" , "FFC090" , "0FB6" ]

Global $iPatternHevcMpegEnabler4S = "8B(.{2})FF5038(.{2})0FB6"
Global $iPatternHevcMpegEnabler4R [ 3 ] = [ "8B" , "FFC090" , "0FB6" ]

Global $iPatternTeamProjectEnablerAS = "84C07448488D4C242048895C2450"
Global $iPatternTeamProjectEnablerAR [ 1 ] = [ "FEC07448488D4C242048895C2450" ]

Global $iPatternTeamProjectEnablerBS = "E8(.{8})84C074(.{2})488D4C24(.{2})E8(.{8})90"
Global $iPatternTeamProjectEnablerBR [ 5 ] = [ "E8" , "FEC074" , "488D4C24" , "E8" , "90" ]

Global $iPatternTeamProjectEnablerCS = "488BC4574883EC7048C740A8FEFFFFFF4889580848897010E8(.{8})84C00F84"
Global $iPatternTeamProjectEnablerCR [ 2 ] = [ "488BC4574883EC7048C740A8FEFFFFFF4889580848897010E8" , "FEC00F84" ]

Global $iPatternAcrobatAS = "EB(.{2})33C066A3(.{8})881D(.{8})8AC35BC3"
Global $iPatternAcrobatAR [ 4 ] = [ "EB" , "B00166A3" , "881D" , "8AC35BC3" ]

Global $iPatternAcrodistAS = "5332DBE8(.{8})84C075(.{2})E8(.{8})84C074(.{2})32C05BC3"
Global $iPatternAcrodistAR [ 5 ] = [ "5332DBE8" , "30C075" , "E8" , "FEC074" , "32C05BC3" ]

Global $iPatternAcroTrayAS = "5332DBE8(.{8})84C075(.{2})E8(.{8})84C074(.{2})32C05BC3"
Global $iPatternAcroTrayAR [ 5 ] = [ "5332DBE8" , "30C075" , "E8" , "FEC074" , "32C05BC3" ]

Global $iPatternAmtlib1S = "B801000000EB(.{2})B803000000EB(.{2})B802000000EB(.{2})33C0"
Global $iPatternAmtlib1R [ 4 ] = [ "B801000000EB" , "B803000000EB" , "B802000000EB" , "EBF0" ]

Global $iPatternAmtlib2S = "83E80074(.{2})83E80174(.{2})33C0B90A000000"
Global $iPatternAmtlib2R [ 3 ] = [ "83C00174" , "83E80174" , "33C0B90A000000" ]

Global $iPatternAmtlib3S = "83F8037F(.{2})74(.{2})83E80174(.{2})83E801"
Global $iPatternAmtlib3R [ 4 ] = [ "83F803EB" , "74" , "83E80174" , "83E801" ]

Global $iPatternAmtlib4S = "3D0101000074(.{2})33C9"
Global $iPatternAmtlib4R [ 2 ] = [ "3D01010000EB" , "33C9" ]

Global $iPatternAmtlib5S = "83C4048B86(.{8})391874"
Global $iPatternAmtlib5R [ 2 ] = [ "83C4048B86" , "3918EB" ]

Global $iPatternACCAS = "83B9AC00000000741583B9C400000000740C83B9DC000000007403B001C332C0C3"
Global $iPatternACCAR [ 1 ] = [ "C681AC000000017400C681C4000000017400C681DC000000017400B001C332C0C3" ]

Global $iPatternACCBS = "8BCEE8(.{4})FFFF85C00F85(.{4})000083EC18"
Global $iPatternACCBR [ 3 ] = [ "8BCEE8" , "FFFFB0010F85" , "000083EC18" ]

Global $iPatternACCCS = "8BB5F8FEFFFF0F84A50000006A00"
Global $iPatternACCCR [ 1 ] = [ "8BB5F8FEFFFF0F85A50000006A00" ]

Global $iPatternACCDS = "75118D4DD832DB"
Global $iPatternACCDR [ 1 ] = [ "74118D4DD832DB" ]

#include <File.au3>
#include <Misc.au3>

#include <GuiEdit.au3>
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>

; NOTE: Non standard header
; https://www.autoitscript.com/forum/topic/109096-extended-message-box-new-version-19-nov-21/
#include "include/ExtMsgBox.au3"

Opt ( "TrayAutoPause" , 0 )
Opt ( "TrayIconHide" , 1 )
If _SINGLETON ( "GenPPP-2.7.exe" , 1 ) = 0 Then
	Exit
EndIf

; Handle to parts of Adobe-GenP-2.7, NOT this GUI
Global $hWndParentWindow ; Handle to Adobe-GenP-2.7
Global $hWnd_progress ; Progress bar

; Calculating progress when creating the regex replacements
Global $myRegexPGlobalPatternSearchCount = 0 ; Number of regex replacements created
Global $count = 0 ; Number of regex replacements which must be created

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

; These controls are used to send arguments from Adobe-GenP-2.7 to this application
; $myFileToParse           : Path to exe
; $myFileToParseSweetPea    : Path to SweetPeaSupport.dll
; $myFileToParseEAClient   : Path to EAClient.dll
; $myFileToParseFrontend   : Path to amtlib.dll
; $myIButtonClicked        : Index of the Adobe icon button, see indices to Adobe product
; $g_idMemoPPSwitchData    : Always 1 when passed in as argument
Global $g_idMemo0 ; Edit1 is its name (Referred to in Adobe-GenP-2.7)
Global $g_idMemo1 ; Edit2
Global $g_idMemo2 ; Edit3
Global $g_idMemo3 ; Edit4
Global $g_idMemo4 ; Edit5
Global $g_idMemoPPSwitch ; Edit6
; Used as local variables to hold the value of the above controls
Global $myFileToParse = "" ; Holds value stored in control $G_IDMEM00
Global $myFileToParseSweetPea = "" ; Holds value stored in control $G_IDMEM01
Global $myFileToParseEAClient = "" ; Holds value stored in control $G_IDMEM02
Global $myFileToParseFrontend = "" ; Holds value stored in control $G_IDMEM03
Global $myIButtonClicked = 0 ; Holds value stored in control $G_IDMEM04
Global $g_idMemoPPSwitchData ; Holds value stored in control $g_idMemoPPSwitch

; These arrays hold regex patterns from the MyRegexPGlobalPatternSearch family of functions
Global $aOutHexGlobalArray [ 0 ]
Global $aOutHexGlobalArrayAcroDist [ 0 ]
Global $aOutHexGlobalArrayAcroTray [ 0 ]
Global $aOutHexGlobalArraySweetPea [ 0 ]
Global $aOutHexGlobalArrayEAClient [ 0 ]
Global $aOutHexGlobalArrayPremiereHSR [ 0 ]
Global $aNullArray [ 0 ] ; Used to clear arrays



WinWait ( "Adobe-GenP-2.7" , "" , 5 )
$hWndParentWindow = WinGetHandle ( "Adobe-GenP-2.7" )
If @error Then
	Exit
Else
	WinActivate ( $hWndParentWindow )
	$hWnd_progress = ControlGetHandle ( $hWndParentWindow , "" , "msctls_progress321" )
	$hWnd_edit = ControlGetHandle ( $hWndParentWindow , "" , "Edit1" )
EndIf
MyOwnGui ( )

; Loop to process GUI messages
; Perform patch upon receiving message
While 1
	$myOwnIMsg = GUIGetMsg ( )
	$g_idMemoPPSwitchData = GUICtrlRead ( $g_idMemoPPSwitch )

	; Load the appropriate patches into $aOutHexGlobalArray family of variables

	; These 2 below do not get patched as no patches get loaded
	; Flash Builder
	If GUICtrlRead ( $g_idMemo4 , 4 ) = 21 Then
		$myFileToParse = GUICtrlRead ( $g_idMemo0 , 0 )
		$myFileToParseSweetPea = GUICtrlRead ( $g_idMemo1 , 1 )
		$myFileToParseEAClient = GUICtrlRead ( $g_idMemo2 , 2 )
		$myFileToParseFrontend = GUICtrlRead ( $g_idMemo3 , 3 )
		$myIButtonClicked = GUICtrlRead ( $g_idMemo4 , 4 )

		GUICtrlSetData ( $g_idMemoPPSwitch , "2" )
	EndIf
	; Speed Grade
	If GUICtrlRead ( $g_idMemo4 , 4 ) = 22 Then
		$myFileToParse = GUICtrlRead ( $g_idMemo0 , 0 )
		$myFileToParseSweetPea = GUICtrlRead ( $g_idMemo1 , 1 )
		$myFileToParseEAClient = GUICtrlRead ( $g_idMemo2 , 2 )
		$myFileToParseFrontend = GUICtrlRead ( $g_idMemo3 , 3 )
		$myIButtonClicked = GUICtrlRead ( $g_idMemo4 , 4 )

		GUICtrlSetData ( $g_idMemoPPSwitch , "2" )
	EndIf

	If $g_idMemoPPSwitchData = 1 Then
		$myFileToParse = GUICtrlRead ( $g_idMemo0 , 0 )
		$myFileToParseSweetPea = GUICtrlRead ( $g_idMemo1 , 1 )
		$myFileToParseEAClient = GUICtrlRead ( $g_idMemo2 , 2 )
		$myFileToParseFrontend = GUICtrlRead ( $g_idMemo3 , 3 )
		$myIButtonClicked = GUICtrlRead ( $g_idMemo4 , 4 )

		MyGlobalPatternSearch ( $myFileToParse , $myFileToParseSweetPea , $myFileToParseEAClient , $myFileToParseFrontend )
		GUICtrlSetData ( $g_idMemoPPSwitch , "2" )
	EndIf

	; Patch the file
	If $g_idMemoPPSwitchData = 2 Then
		$myInPath = $myFileToParse
		$aPathSplitPea = $myFileToParseSweetPea
		$aPathSplitEAC = $myFileToParseEAClient
		$aPathSplitFrontend = $myFileToParseFrontend
		$myIButtonClicked = GUICtrlRead ( $g_idMemo4 , 4 )
		Select
		Case $myIButtonClicked = 1
			MemoWrite1 ( $myIButtonClicked & @CRLF & "---" & @CRLF & "Adobe After Effects" & @CRLF & "---" & @CRLF & "medication :)" )
			MyGlobalPatternPatch ( $myInPath , $aOutHexGlobalArray )
			MemoWrite1 ( $myIButtonClicked & @CRLF & "---" & @CRLF & "HEVC & MPEG" & @CRLF & "---" & @CRLF & "medication :)" )
			MyGlobalPatternPatch ( $aPathSplitPea , $aOutHexGlobalArraySweetPea )
			MemoWrite1 ( $myIButtonClicked & @CRLF & "---" & @CRLF & "Team Project" & @CRLF & "---" & @CRLF & "medication :)" )
			MyGlobalPatternPatch ( $aPathSplitEAC , $aOutHexGlobalArrayEAClient )
		Case $myIButtonClicked = 2
			MemoWrite1 ( $myIButtonClicked & @CRLF & "---" & @CRLF & "Adobe Animate" & @CRLF & "---" & @CRLF & "medication :)" )
			MyGlobalPatternPatch ( $myInPath , $aOutHexGlobalArray )
		Case $myIButtonClicked = 3
			MemoWrite1 ( $myIButtonClicked & @CRLF & "---" & @CRLF & "Adobe Audition" & @CRLF & "---" & @CRLF & "medication :)" )
			MyGlobalPatternPatch ( $myInPath , $aOutHexGlobalArray )
		Case $myIButtonClicked = 4
			MemoWrite1 ( $myIButtonClicked & @CRLF & "---" & @CRLF & "Adobe Bridge" & @CRLF & "---" & @CRLF & "medication :)" )
			MyGlobalPatternPatch ( $myInPath , $aOutHexGlobalArray )
		Case $myIButtonClicked = 5
			MemoWrite1 ( $myIButtonClicked & @CRLF & "---" & @CRLF & "Adobe Character Animator" & @CRLF & "---" & @CRLF & "medication :)" )
			MyGlobalPatternPatch ( $myInPath , $aOutHexGlobalArray )
		Case $myIButtonClicked = 6
			MemoWrite1 ( $myIButtonClicked & @CRLF & "---" & @CRLF & "Adobe Dreamweaver" & @CRLF & "---" & @CRLF & "medication :)" )
			MyGlobalPatternPatch ( $myInPath , $aOutHexGlobalArray )
		Case $myIButtonClicked = 7
			MemoWrite1 ( $myIButtonClicked & @CRLF & "---" & @CRLF & "Adobe Illustrator" & @CRLF & "---" & @CRLF & "medication :)" )
			MyGlobalPatternPatch ( $myInPath , $aOutHexGlobalArray )
		Case $myIButtonClicked = 8
			MemoWrite1 ( $myIButtonClicked & @CRLF & "---" & @CRLF & "Adobe InCopy" & @CRLF & "---" & @CRLF & "medication :)" )
			MyGlobalPatternPatch ( $myInPath , $aOutHexGlobalArray )
		Case $myIButtonClicked = 9
			MemoWrite1 ( $myIButtonClicked & @CRLF & "---" & @CRLF & "Adobe InDesign" & @CRLF & "---" & @CRLF & "medication :)" )
			MyGlobalPatternPatch ( $myInPath , $aOutHexGlobalArray )
		Case $myIButtonClicked = 10
			MemoWrite1 ( $myIButtonClicked & @CRLF & "---" & @CRLF & "Adobe Lightroom CC" & @CRLF & "---" & @CRLF & "medication :)" )
			MyGlobalPatternPatch ( $myInPath , $aOutHexGlobalArray )
		Case $myIButtonClicked = 11
			MemoWrite1 ( $myIButtonClicked & @CRLF & "---" & @CRLF & "Adobe Lightroom Classic CC" & @CRLF & "---" & @CRLF & "medication :)" )
			MyGlobalPatternPatch ( $myInPath , $aOutHexGlobalArray )
		Case $myIButtonClicked = 12
			MemoWrite1 ( $myIButtonClicked & @CRLF & "---" & @CRLF & "Adobe Media Encoder" & @CRLF & "---" & @CRLF & "medication :)" )
			MyGlobalPatternPatch ( $myInPath , $aOutHexGlobalArray )
			MemoWrite1 ( $myIButtonClicked & @CRLF & "---" & @CRLF & "HEVC & MPEG" & @CRLF & "---" & @CRLF & "medication :)" )
			MyGlobalPatternPatch ( $aPathSplitPea , $aOutHexGlobalArraySweetPea )
			MemoWrite1 ( $myIButtonClicked & @CRLF & "---" & @CRLF & "Team Project" & @CRLF & "---" & @CRLF & "medication :)" )
			MyGlobalPatternPatch ( $aPathSplitEAC , $aOutHexGlobalArrayEAClient )
		Case $myIButtonClicked = 13
			MemoWrite1 ( $myIButtonClicked & @CRLF & "---" & @CRLF & "Adobe Photoshop" & @CRLF & "---" & @CRLF & "medication :)" )
			MyGlobalPatternPatch ( $myInPath , $aOutHexGlobalArray )
		Case $myIButtonClicked = 14
			MemoWrite1 ( $myIButtonClicked & @CRLF & "---" & @CRLF & "Adobe Prelude" & @CRLF & "---" & @CRLF & "medication :)" )
			MyGlobalPatternPatch ( $myInPath , $aOutHexGlobalArray )
			MemoWrite1 ( $myIButtonClicked & @CRLF & "---" & @CRLF & "HEVC & MPEG" & @CRLF & "---" & @CRLF & "medication :)" )
			MyGlobalPatternPatch ( $aPathSplitPea , $aOutHexGlobalArraySweetPea )
			MemoWrite1 ( $myIButtonClicked & @CRLF & "---" & @CRLF & "Team Project" & @CRLF & "---" & @CRLF & "medication :)" )
			MyGlobalPatternPatch ( $aPathSplitEAC , $aOutHexGlobalArrayEAClient )
		Case $myIButtonClicked = 15
			MemoWrite1 ( $myIButtonClicked & @CRLF & "---" & @CRLF & "Adobe Premiere" & @CRLF & "---" & @CRLF & "medication :)" )
			MyGlobalPatternPatch ( $myInPath , $aOutHexGlobalArray )
			MemoWrite1 ( $myIButtonClicked & @CRLF & "---" & @CRLF & "HEVC & MPEG" & @CRLF & "---" & @CRLF & "medication :)" )
			MyGlobalPatternPatch ( $aPathSplitPea , $aOutHexGlobalArraySweetPea )
			MemoWrite1 ( $myIButtonClicked & @CRLF & "---" & @CRLF & "Team Project" & @CRLF & "---" & @CRLF & "medication :)" )
			MyGlobalPatternPatch ( $aPathSplitEAC , $aOutHexGlobalArrayEAClient )
		Case $myIButtonClicked = 16
			MemoWrite1 ( $myIButtonClicked & @CRLF & "---" & @CRLF & "Adobe Premiere Rush CC" & @CRLF & "---" & @CRLF & "medication :)" )
			MyGlobalPatternPatch ( $myInPath , $aOutHexGlobalArray )
			MemoWrite1 ( $myIButtonClicked & @CRLF & "---" & @CRLF & "HEVC & MPEG" & @CRLF & "---" & @CRLF & "medication :)" )
			MyGlobalPatternPatch ( $aPathSplitPea , $aOutHexGlobalArraySweetPea )
			MemoWrite1 ( $myIButtonClicked & @CRLF & "---" & @CRLF & "Team Project" & @CRLF & "---" & @CRLF & "medication :)" )
			MyGlobalPatternPatch ( $aPathSplitEAC , $aOutHexGlobalArrayEAClient )
		Case $myIButtonClicked = 17
			MemoWrite1 ( $myIButtonClicked & @CRLF & "---" & @CRLF & "Adobe Acrobat DC" & @CRLF & "---" & @CRLF & "medication :)" )
			MyGlobalPatternPatch ( $myInPath , $aOutHexGlobalArray )
			MemoWrite1 ( $myIButtonClicked & @CRLF & "---" & @CRLF & "Amtlib" & @CRLF & "---" & @CRLF & "medication :)" )
			MyGlobalPatternPatch ( $aPathSplitFrontend , $aOutHexGlobalArrayPremiereHSR )
			MemoWrite1 ( $myIButtonClicked & @CRLF & "---" & @CRLF & "Acrodist" & @CRLF & "---" & @CRLF & "medication :)" )
			MyGlobalPatternPatch ( $aPathSplitPea , $aOutHexGlobalArrayAcroDist )
			MemoWrite1 ( $myIButtonClicked & @CRLF & "---" & @CRLF & "AcroTray" & @CRLF & "---" & @CRLF & "medication :)" )
			MyGlobalPatternPatch ( $aPathSplitEAC , $aOutHexGlobalArrayAcroTray )
		Case $myIButtonClicked = 18
			MemoWrite1 ( $myIButtonClicked & @CRLF & "---" & @CRLF & "Adobe Dimension CC" & @CRLF & "---" & @CRLF & "medication :)" )
			MyGlobalPatternPatch ( $myInPath , $aOutHexGlobalArray )
		Case $myIButtonClicked = 19
			MemoWrite1 ( $myIButtonClicked & @CRLF & "---" & @CRLF & "Adobe XD CC" & @CRLF & "---" & @CRLF & "medication :)" )
			MyGlobalPatternPatch ( $myInPath , $aOutHexGlobalArray )
		Case $myIButtonClicked = 20
			MemoWrite1 ( $myIButtonClicked & @CRLF & "---" & @CRLF & "Adobe Fresco" & @CRLF & "---" & @CRLF & "medication :)" )
			MyGlobalPatternPatch ( $myInPath , $aOutHexGlobalArray )
		Case $myIButtonClicked = 21
			MemoWrite1 ( $myIButtonClicked & @CRLF & "---" & @CRLF & "Adobe Flash Builder 4.7 (64 Bit)" & @CRLF & "---" & @CRLF & "medication :)" )
		Case $myIButtonClicked = 22
			MemoWrite1 ( $myIButtonClicked & @CRLF & "---" & @CRLF & "Adobe SpeedGrade CC 2015" & @CRLF & "---" & @CRLF & "medication :)" )
		Case $myIButtonClicked = 23
		Case $myIButtonClicked = 24
			MemoWrite1 ( $myIButtonClicked & @CRLF & "---" & @CRLF & "Adobe Creative Cloud Fix" & @CRLF & "---" & @CRLF & "medication :)" )
			MyGlobalPatternPatch ( $myInPath , $aOutHexGlobalArray )
			WinSetOnTop ( $hWndParentWindow , "Adobe-GenP-2.7" , $WINDOWS_NOONTOP )
			_ExtMsgBox ( 64 , "Ok" , "Info" , "Restart your ACC app manually." & @CRLF & "If it fails or you have problems with 'Sign In'," & @CRLF & "reboot your computer and ACC will start properly." , 0 , $hWndParentWindow , 0 , False )
			WinSetOnTop ( $hWndParentWindow , "Adobe-GenP-2.7" , $WINDOWS_ONTOP )
		EndSelect
		MemoWrite1 ( @CRLF & "---" & @CRLF & "Waitng for your command :)" & @CRLF & "---" )

		; Reset arguments
		$myFileToParse = ""
		$myFileToParseSweetPea = ""
		$myFileToParseEAClient = ""
		$myFileToParseFrontend = ""
		$myIButtonClicked = 0
		GUICtrlSetData ( $g_idMemo0 , "0" )
		GUICtrlSetData ( $g_idMemo1 , "0" )
		GUICtrlSetData ( $g_idMemo2 , "0" )
		GUICtrlSetData ( $g_idMemo3 , "0" )
		GUICtrlSetData ( $g_idMemo4 , "0" )
		GUICtrlSetData ( $g_idMemoPPSwitch , "0" )

		WinSetOnTop ( $hWndParentWindow , "Adobe-GenP-2.7" , $WINDOWS_NOONTOP )
		Sleep ( 100 )
		Exit
	EndIf
WEnd

; Initializes the GUI elements to receive arguments from Adobe-GenP-2.7
Func MyOwnGui ( )
	$myHGui = GUICreate ( "GenPPP-2.7" , 260 , 80 , - 1 , - 1 , $WS_CAPTION )
	; Creates the Edit controls for sending arguments between Adobe-GenP-2.7,
	$g_idMemo0 = GUICtrlCreateEdit ( "" , 10 , 10 , 40 , 20 , BitOR ( $ES_READONLY , $ES_CENTER , $WS_DISABLED ) )
	GUICtrlSetFont ( $g_idMemo0 , 9 , 400 , 0 , "Comic Sans Ms" )
	GUICtrlSetData ( $g_idMemo0 , "0" )

	$g_idMemo1 = GUICtrlCreateEdit ( "" , 60 , 10 , 40 , 20 , BitOR ( $ES_READONLY , $ES_CENTER , $WS_DISABLED ) )
	GUICtrlSetFont ( $g_idMemo1 , 9 , 400 , 0 , "Comic Sans Ms" )
	GUICtrlSetData ( $g_idMemo1 , "0" )

	$g_idMemo2 = GUICtrlCreateEdit ( "" , 110 , 10 , 40 , 20 , BitOR ( $ES_READONLY , $ES_CENTER , $WS_DISABLED ) )
	GUICtrlSetFont ( $g_idMemo2 , 9 , 400 , 0 , "Comic Sans Ms" )
	GUICtrlSetData ( $g_idMemo2 , "0" )

	$g_idMemo3 = GUICtrlCreateEdit ( "" , 160 , 10 , 40 , 20 , BitOR ( $ES_READONLY , $ES_CENTER , $WS_DISABLED ) )
	GUICtrlSetFont ( $g_idMemo3 , 9 , 400 , 0 , "Comic Sans Ms" )
	GUICtrlSetData ( $g_idMemo3 , "0" )

	$g_idMemo4 = GUICtrlCreateEdit ( "" , 210 , 10 , 40 , 20 , BitOR ( $ES_READONLY , $ES_CENTER , $WS_DISABLED ) )
	GUICtrlSetFont ( $g_idMemo4 , 9 , 400 , 0 , "Comic Sans Ms" )
	GUICtrlSetData ( $g_idMemo4 , "0" )

	$g_idMemoPPSwitch = GUICtrlCreateEdit ( "" , 110 , 40 , 40 , 20 , BitOR ( $ES_READONLY , $ES_CENTER , $WS_DISABLED ) )
	GUICtrlSetFont ( $g_idMemoPPSwitch , 9 , 400 , 0 , "Comic Sans Ms" )
	GUICtrlSetData ( $g_idMemoPPSwitch , "0" )
	GUISetState ( @SW_DISABLE , $myHGui )
EndFunc

; Writes messages onto Adobe-GenP-2.7
Func MemoWrite1 ( $sMessage )
	ControlSetText ( $hWndParentWindow , "" , "Edit1" , $sMessage )
EndFunc
; Sets progress bar on Adobe-GenP-2.7
Func ProgressWrite ( $msg_progress )
	_SendMessage ( $hWnd_progress , $PBM_SETPOS , $msg_progress )
EndFunc

; Load the appropriate patches into $aOutHexGlobalArray... family of variables
Func MyGlobalPatternSearch ( $myFileToParse , $myFileToParseSweetPea , $myFileToParseEAClient , $myFileToParseFrontend )
	MemoWrite1 ( $myIButtonClicked & @CRLF & "---" & @CRLF & "Preparing to Analyze" & @CRLF & "---" & @CRLF & "*****" )
	$aInHexArray = $aNullArray
	$aOutHexGlobalArray = $aNullArray
	$aOutHexGlobalArraySweetPea = $aNullArray
	$aOutHexGlobalArrayEAClient = $aNullArray
	$aOutHexGlobalArrayPremiereHSR = $aNullArray
	ProgressWrite ( 0 )
	$myRegexPGlobalPatternSearchCount = 0
	Select
	Case $myIButtonClicked = 1
		$count = 26
		MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternPROFILE_EXPIREDS , $iPatternPROFILE_EXPIREDR , "$iPatternPROFILE_EXPIREDS" )
		If UBound ( $aOutHexGlobalArray ) > 0 Then
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternValidateLicenseS , $iPatternValidateLicenseR , "$iPatternValidateLicenseS" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternValidateLicense1S , $iPatternValidateLicense1R , "$iPatternValidateLicense1S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternValidateLicense2S , $iPatternValidateLicense2R , "$iPatternValidateLicense2S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternCmpEax6S , $iPatternCmpEax6R , "$iPatternCmpEax6S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternProcessV2Profile1aS , $iPatternProcessV2Profile1aR , "$iPatternProcessV2Profile1aS" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternProcessV2Profile1a1S , $iPatternProcessV2Profile1a1R , "$iPatternProcessV2Profile1a1S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternValidateLicense3S , $iPatternValidateLicense3R , "$iPatternValidateLicense3S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternProcessV2Profile1b1S , $iPatternProcessV2Profile1b1R , "$iPatternProcessV2Profile1b1S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternProcessV2Profile1b2S , $iPatternProcessV2Profile1b2R , "$iPatternProcessV2Profile1b2S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternProcessV2Profile1b3S , $iPatternProcessV2Profile1b3R , "$iPatternProcessV2Profile1b3S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternProcessV2Profile1b4S , $iPatternProcessV2Profile1b4R , "$iPatternProcessV2Profile1b4S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternProcessV2Profile1CnV1S , $iPatternProcessV2Profile1CnV1R , "$iPatternProcessV2Profile1CnV1S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternProcessV2Profile1CnV2S , $iPatternProcessV2Profile1CnV2R , "$iPatternProcessV2Profile1CnV2S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternProcessV2Profile1d1S , $iPatternProcessV2Profile1d1R , "$iPatternProcessV2Profile1d1S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternProcessV2Profile1d2S , $iPatternProcessV2Profile1d2R , "$iPatternProcessV2Profile1d2S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternAEPrruplTryoutS , $iPatternAEPrruplTryoutR , "$iPatternAEPrruplTryoutS" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternIsLicCompS , $iPatternIsLicCompR , "$iPatternIsLicCompS" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternPreventInstantShutdownS , $iPatternPreventInstantShutdownR , "$iPatternPreventInstantShutdownS" )
			MyRegexPGlobalPatternSearchSweetPea ( $myFileToParseSweetPea , $iPatternHevcMpegEnabler1S , $iPatternHevcMpegEnabler1R , "$iPatternHevcMpegEnabler1S" )
			MyRegexPGlobalPatternSearchSweetPea ( $myFileToParseSweetPea , $iPatternHevcMpegEnabler2S , $iPatternHevcMpegEnabler2R , "$iPatternHevcMpegEnabler2S" )
			MyRegexPGlobalPatternSearchSweetPea ( $myFileToParseSweetPea , $iPatternHevcMpegEnabler3S , $iPatternHevcMpegEnabler3R , "$iPatternHevcMpegEnabler3S" )
			MyRegexPGlobalPatternSearchSweetPea ( $myFileToParseSweetPea , $iPatternHevcMpegEnabler4S , $iPatternHevcMpegEnabler4R , "$iPatternHevcMpegEnabler4S" )
			MyRegexPGlobalPatternSearchEAClient ( $myFileToParseEAClient , $iPatternTeamProjectEnablerAS , $iPatternTeamProjectEnablerAR , "$iPatternTeamProjectEnablerAS" )
			MyRegexPGlobalPatternSearchEAClient ( $myFileToParseEAClient , $iPatternTeamProjectEnablerBS , $iPatternTeamProjectEnablerBR , "$iPatternTeamProjectEnablerBS" )
			MyRegexPGlobalPatternSearchEAClient ( $myFileToParseEAClient , $iPatternTeamProjectEnablerCS , $iPatternTeamProjectEnablerCR , "$iPatternTeamProjectEnablerCS" )
			$myRegexPGlobalPatternSearchCount = 0
			ProgressWrite ( 0 )
			GUICtrlSetData ( $g_idMemoPPSwitch , "0" )
		Else
			MemoWrite1 ( $myIButtonClicked & @CRLF & "---" & @CRLF & "File is not 'vanilla'. Aborting..." & @CRLF & "---" )
			$myRegexPGlobalPatternSearchCount = 0
			ProgressWrite ( 0 )
			GUICtrlSetData ( $g_idMemoPPSwitch , "0" )
			Sleep ( 2000 )
		EndIf
	Case $myIButtonClicked = 2
		$count = 16
		MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternPROFILE_EXPIREDS , $iPatternPROFILE_EXPIREDR , "$iPatternPROFILE_EXPIREDS" )
		If UBound ( $aOutHexGlobalArray ) > 0 Then
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternValidateLicenseS , $iPatternValidateLicenseR , "$iPatternValidateLicenseS" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternValidateLicense1S , $iPatternValidateLicense1R , "$iPatternValidateLicense1S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternValidateLicense2S , $iPatternValidateLicense2R , "$iPatternValidateLicense2S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternCmpEax6S , $iPatternCmpEax6R , "$iPatternCmpEax6S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternProcessV2Profile1aS , $iPatternProcessV2Profile1aR , "$iPatternProcessV2Profile1aS" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternProcessV2Profile1a1S , $iPatternProcessV2Profile1a1R , "$iPatternProcessV2Profile1a1S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternValidateLicense3S , $iPatternValidateLicense3R , "$iPatternValidateLicense3S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternProcessV2Profile1b1S , $iPatternProcessV2Profile1b1R , "$iPatternProcessV2Profile1b1S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternProcessV2Profile1b2S , $iPatternProcessV2Profile1b2R , "$iPatternProcessV2Profile1b2S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternProcessV2Profile1b3S , $iPatternProcessV2Profile1b3R , "$iPatternProcessV2Profile1b3S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternProcessV2Profile1b4S , $iPatternProcessV2Profile1b4R , "$iPatternProcessV2Profile1b4S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternProcessV2Profile1CnV1S , $iPatternProcessV2Profile1CnV1R , "$iPatternProcessV2Profile1CnV1S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternProcessV2Profile1CnV2S , $iPatternProcessV2Profile1CnV2R , "$iPatternProcessV2Profile1CnV2S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternProcessV2Profile1d1S , $iPatternProcessV2Profile1d1R , "$iPatternProcessV2Profile1d1S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternProcessV2Profile1d2S , $iPatternProcessV2Profile1d2R , "$iPatternProcessV2Profile1d2S" )
			$myRegexPGlobalPatternSearchCount = 0
			ProgressWrite ( 0 )
			GUICtrlSetData ( $g_idMemoPPSwitch , "0" )
		Else
			MemoWrite1 ( $myIButtonClicked & @CRLF & "---" & @CRLF & "File is not 'vanilla'. Aborting..." & @CRLF & "---" )
			$myRegexPGlobalPatternSearchCount = 0
			ProgressWrite ( 0 )
			GUICtrlSetData ( $g_idMemoPPSwitch , "0" )
			Sleep ( 2000 )
		EndIf
	Case $myIButtonClicked = 3
		$count = 26
		MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternPROFILE_EXPIREDS , $iPatternPROFILE_EXPIREDR , "$iPatternPROFILE_EXPIREDS" )
		If UBound ( $aOutHexGlobalArray ) > 0 Then
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternValidateLicenseS , $iPatternValidateLicenseR , "$iPatternValidateLicenseS" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternValidateLicense1S , $iPatternValidateLicense1R , "$iPatternValidateLicense1S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternValidateLicense2S , $iPatternValidateLicense2R , "$iPatternValidateLicense2S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternCmpEax6S , $iPatternCmpEax6R , "$iPatternCmpEax6S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternProcessV2Profile1aS , $iPatternProcessV2Profile1aR , "$iPatternProcessV2Profile1aS" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternProcessV2Profile1a1S , $iPatternProcessV2Profile1a1R , "$iPatternProcessV2Profile1a1S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternValidateLicense3S , $iPatternValidateLicense3R , "$iPatternValidateLicense3S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternProcessV2Profile1b1S , $iPatternProcessV2Profile1b1R , "$iPatternProcessV2Profile1b1S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternProcessV2Profile1b2S , $iPatternProcessV2Profile1b2R , "$iPatternProcessV2Profile1b2S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternProcessV2Profile1b3S , $iPatternProcessV2Profile1b3R , "$iPatternProcessV2Profile1b3S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternProcessV2Profile1b4S , $iPatternProcessV2Profile1b4R , "$iPatternProcessV2Profile1b4S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternProcessV2Profile1CnV1S , $iPatternProcessV2Profile1CnV1R , "$iPatternProcessV2Profile1CnV1S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternProcessV2Profile1CnV2S , $iPatternProcessV2Profile1CnV2R , "$iPatternProcessV2Profile1CnV2S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternProcessV2Profile1d1S , $iPatternProcessV2Profile1d1R , "$iPatternProcessV2Profile1d1S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternProcessV2Profile1d2S , $iPatternProcessV2Profile1d2R , "$iPatternProcessV2Profile1d2S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternAEPrruplTryoutS , $iPatternAEPrruplTryoutR , "$iPatternAEPrruplTryoutS" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternIsLicCompS , $iPatternIsLicCompR , "$iPatternIsLicCompS" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternPreventInstantShutdownS , $iPatternPreventInstantShutdownR , "$iPatternPreventInstantShutdownS" )
			MyRegexPGlobalPatternSearchSweetPea ( $myFileToParseSweetPea , $iPatternHevcMpegEnabler1S , $iPatternHevcMpegEnabler1R , "$iPatternHevcMpegEnabler1S" )
			MyRegexPGlobalPatternSearchSweetPea ( $myFileToParseSweetPea , $iPatternHevcMpegEnabler2S , $iPatternHevcMpegEnabler2R , "$iPatternHevcMpegEnabler2S" )
			MyRegexPGlobalPatternSearchSweetPea ( $myFileToParseSweetPea , $iPatternHevcMpegEnabler3S , $iPatternHevcMpegEnabler3R , "$iPatternHevcMpegEnabler3S" )
			MyRegexPGlobalPatternSearchSweetPea ( $myFileToParseSweetPea , $iPatternHevcMpegEnabler4S , $iPatternHevcMpegEnabler4R , "$iPatternHevcMpegEnabler4S" )
			MyRegexPGlobalPatternSearchEAClient ( $myFileToParseEAClient , $iPatternTeamProjectEnablerAS , $iPatternTeamProjectEnablerAR , "$iPatternTeamProjectEnablerAS" )
			MyRegexPGlobalPatternSearchEAClient ( $myFileToParseEAClient , $iPatternTeamProjectEnablerBS , $iPatternTeamProjectEnablerBR , "$iPatternTeamProjectEnablerBS" )
			MyRegexPGlobalPatternSearchEAClient ( $myFileToParseEAClient , $iPatternTeamProjectEnablerCS , $iPatternTeamProjectEnablerCR , "$iPatternTeamProjectEnablerCS" )
			$myRegexPGlobalPatternSearchCount = 0
			ProgressWrite ( 0 )
			GUICtrlSetData ( $g_idMemoPPSwitch , "0" )
		Else
			MemoWrite1 ( $myIButtonClicked & @CRLF & "---" & @CRLF & "File is not 'vanilla'. Aborting..." & @CRLF & "---" )
			$myRegexPGlobalPatternSearchCount = 0
			ProgressWrite ( 0 )
			GUICtrlSetData ( $g_idMemoPPSwitch , "0" )
			Sleep ( 2000 )
		EndIf
	Case $myIButtonClicked = 4
		$count = 17
		MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternPROFILE_EXPIREDS , $iPatternPROFILE_EXPIREDR , "$iPatternPROFILE_EXPIREDS" )
		If UBound ( $aOutHexGlobalArray ) > 0 Then
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternValidateLicenseS , $iPatternValidateLicenseR , "$iPatternValidateLicenseS" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternValidateLicense1S , $iPatternValidateLicense1R , "$iPatternValidateLicense1S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternValidateLicense2S , $iPatternValidateLicense2R , "$iPatternValidateLicense2S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternCmpEax6S , $iPatternCmpEax6R , "$iPatternCmpEax6S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternProcessV2Profile1aS , $iPatternProcessV2Profile1aR , "$iPatternProcessV2Profile1aS" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternProcessV2Profile1a1S , $iPatternProcessV2Profile1a1R , "$iPatternProcessV2Profile1a1S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternValidateLicense3S , $iPatternValidateLicense3R , "$iPatternValidateLicense3S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternProcessV2Profile1b1S , $iPatternProcessV2Profile1b1R , "$iPatternProcessV2Profile1b1S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternProcessV2Profile1b2S , $iPatternProcessV2Profile1b2R , "$iPatternProcessV2Profile1b2S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternProcessV2Profile1b3S , $iPatternProcessV2Profile1b3R , "$iPatternProcessV2Profile1b3S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternProcessV2Profile1b4S , $iPatternProcessV2Profile1b4R , "$iPatternProcessV2Profile1b4S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternProcessV2Profile1CnV1S , $iPatternProcessV2Profile1CnV1R , "$iPatternProcessV2Profile1CnV1S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternProcessV2Profile1CnV2S , $iPatternProcessV2Profile1CnV2R , "$iPatternProcessV2Profile1CnV2S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternProcessV2Profile1d1S , $iPatternProcessV2Profile1d1R , "$iPatternProcessV2Profile1d1S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternProcessV2Profile1d2S , $iPatternProcessV2Profile1d2R , "$iPatternProcessV2Profile1d2S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternBridgeCamRawS , $iPatternBridgeCamRawR , "$iPatternBridgeCamRawS" )
			$myRegexPGlobalPatternSearchCount = 0
			ProgressWrite ( 0 )
			GUICtrlSetData ( $g_idMemoPPSwitch , "0" )
		Else
			MemoWrite1 ( $myIButtonClicked & @CRLF & "---" & @CRLF & "File is not 'vanilla'. Aborting..." & @CRLF & "---" )
			$myRegexPGlobalPatternSearchCount = 0
			ProgressWrite ( 0 )
			GUICtrlSetData ( $g_idMemoPPSwitch , "0" )
			Sleep ( 2000 )
		EndIf
	Case $myIButtonClicked = 5
		$count = 26
		MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternPROFILE_EXPIREDS , $iPatternPROFILE_EXPIREDR , "$iPatternPROFILE_EXPIREDS" )
		If UBound ( $aOutHexGlobalArray ) > 0 Then
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternValidateLicenseS , $iPatternValidateLicenseR , "$iPatternValidateLicenseS" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternValidateLicense1S , $iPatternValidateLicense1R , "$iPatternValidateLicense1S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternValidateLicense2S , $iPatternValidateLicense2R , "$iPatternValidateLicense2S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternCmpEax6S , $iPatternCmpEax6R , "$iPatternCmpEax6S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternProcessV2Profile1aS , $iPatternProcessV2Profile1aR , "$iPatternProcessV2Profile1aS" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternProcessV2Profile1a1S , $iPatternProcessV2Profile1a1R , "$iPatternProcessV2Profile1a1S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternValidateLicense3S , $iPatternValidateLicense3R , "$iPatternValidateLicense3S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternProcessV2Profile1b1S , $iPatternProcessV2Profile1b1R , "$iPatternProcessV2Profile1b1S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternProcessV2Profile1b2S , $iPatternProcessV2Profile1b2R , "$iPatternProcessV2Profile1b2S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternProcessV2Profile1b3S , $iPatternProcessV2Profile1b3R , "$iPatternProcessV2Profile1b3S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternProcessV2Profile1b4S , $iPatternProcessV2Profile1b4R , "$iPatternProcessV2Profile1b4S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternProcessV2Profile1CnV1S , $iPatternProcessV2Profile1CnV1R , "$iPatternProcessV2Profile1CnV1S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternProcessV2Profile1CnV2S , $iPatternProcessV2Profile1CnV2R , "$iPatternProcessV2Profile1CnV2S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternProcessV2Profile1d1S , $iPatternProcessV2Profile1d1R , "$iPatternProcessV2Profile1d1S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternProcessV2Profile1d2S , $iPatternProcessV2Profile1d2R , "$iPatternProcessV2Profile1d2S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternAEPrruplTryoutS , $iPatternAEPrruplTryoutR , "$iPatternAEPrruplTryoutS" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternIsLicCompS , $iPatternIsLicCompR , "$iPatternIsLicCompS" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternPreventInstantShutdownS , $iPatternPreventInstantShutdownR , "$iPatternPreventInstantShutdownS" )
			MyRegexPGlobalPatternSearchSweetPea ( $myFileToParseSweetPea , $iPatternHevcMpegEnabler1S , $iPatternHevcMpegEnabler1R , "$iPatternHevcMpegEnabler1S" )
			MyRegexPGlobalPatternSearchSweetPea ( $myFileToParseSweetPea , $iPatternHevcMpegEnabler2S , $iPatternHevcMpegEnabler2R , "$iPatternHevcMpegEnabler2S" )
			MyRegexPGlobalPatternSearchSweetPea ( $myFileToParseSweetPea , $iPatternHevcMpegEnabler3S , $iPatternHevcMpegEnabler3R , "$iPatternHevcMpegEnabler3S" )
			MyRegexPGlobalPatternSearchSweetPea ( $myFileToParseSweetPea , $iPatternHevcMpegEnabler4S , $iPatternHevcMpegEnabler4R , "$iPatternHevcMpegEnabler4S" )
			MyRegexPGlobalPatternSearchEAClient ( $myFileToParseEAClient , $iPatternTeamProjectEnablerAS , $iPatternTeamProjectEnablerAR , "$iPatternTeamProjectEnablerAS" )
			MyRegexPGlobalPatternSearchEAClient ( $myFileToParseEAClient , $iPatternTeamProjectEnablerBS , $iPatternTeamProjectEnablerBR , "$iPatternTeamProjectEnablerBS" )
			MyRegexPGlobalPatternSearchEAClient ( $myFileToParseEAClient , $iPatternTeamProjectEnablerCS , $iPatternTeamProjectEnablerCR , "$iPatternTeamProjectEnablerCS" )
			$myRegexPGlobalPatternSearchCount = 0
			ProgressWrite ( 0 )
			GUICtrlSetData ( $g_idMemoPPSwitch , "0" )
		Else
			MemoWrite1 ( $myIButtonClicked & @CRLF & "---" & @CRLF & "File is not 'vanilla'. Aborting..." & @CRLF & "---" )
			$myRegexPGlobalPatternSearchCount = 0
			ProgressWrite ( 0 )
			GUICtrlSetData ( $g_idMemoPPSwitch , "0" )
			Sleep ( 2000 )
		EndIf
	Case $myIButtonClicked = 6
		$count = 16
		MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternPROFILE_EXPIREDS , $iPatternPROFILE_EXPIREDR , "$iPatternPROFILE_EXPIREDS" )
		If UBound ( $aOutHexGlobalArray ) > 0 Then
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternValidateLicenseS , $iPatternValidateLicenseR , "$iPatternValidateLicenseS" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternValidateLicense1S , $iPatternValidateLicense1R , "$iPatternValidateLicense1S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternValidateLicense2S , $iPatternValidateLicense2R , "$iPatternValidateLicense2S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternCmpEax6S , $iPatternCmpEax6R , "$iPatternCmpEax6S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternProcessV2Profile1aS , $iPatternProcessV2Profile1aR , "$iPatternProcessV2Profile1aS" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternProcessV2Profile1a1S , $iPatternProcessV2Profile1a1R , "$iPatternProcessV2Profile1a1S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternValidateLicense3S , $iPatternValidateLicense3R , "$iPatternValidateLicense3S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternProcessV2Profile1b1S , $iPatternProcessV2Profile1b1R , "$iPatternProcessV2Profile1b1S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternProcessV2Profile1b2S , $iPatternProcessV2Profile1b2R , "$iPatternProcessV2Profile1b2S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternProcessV2Profile1b3S , $iPatternProcessV2Profile1b3R , "$iPatternProcessV2Profile1b3S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternProcessV2Profile1b4S , $iPatternProcessV2Profile1b4R , "$iPatternProcessV2Profile1b4S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternProcessV2Profile1CnV1S , $iPatternProcessV2Profile1CnV1R , "$iPatternProcessV2Profile1CnV1S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternProcessV2Profile1CnV2S , $iPatternProcessV2Profile1CnV2R , "$iPatternProcessV2Profile1CnV2S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternProcessV2Profile1d1S , $iPatternProcessV2Profile1d1R , "$iPatternProcessV2Profile1d1S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternProcessV2Profile1d2S , $iPatternProcessV2Profile1d2R , "$iPatternProcessV2Profile1d2S" )
			$myRegexPGlobalPatternSearchCount = 0
			ProgressWrite ( 0 )
			GUICtrlSetData ( $g_idMemoPPSwitch , "0" )
		Else
			MemoWrite1 ( $myIButtonClicked & @CRLF & "---" & @CRLF & "File is not 'vanilla'. Aborting..." & @CRLF & "---" )
			$myRegexPGlobalPatternSearchCount = 0
			ProgressWrite ( 0 )
			GUICtrlSetData ( $g_idMemoPPSwitch , "0" )
			Sleep ( 2000 )
		EndIf
	Case $myIButtonClicked = 7
		$count = 17
		MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternPROFILE_EXPIREDS , $iPatternPROFILE_EXPIREDR , "$iPatternPROFILE_EXPIREDS" )
		If UBound ( $aOutHexGlobalArray ) > 0 Then
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternValidateLicenseS , $iPatternValidateLicenseR , "$iPatternValidateLicenseS" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternValidateLicense1S , $iPatternValidateLicense1R , "$iPatternValidateLicense1S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternValidateLicense2S , $iPatternValidateLicense2R , "$iPatternValidateLicense2S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternCmpEax6S , $iPatternCmpEax6R , "$iPatternCmpEax6S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternProcessV2Profile1aS , $iPatternProcessV2Profile1aR , "$iPatternProcessV2Profile1aS" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternProcessV2Profile1a1S , $iPatternProcessV2Profile1a1R , "$iPatternProcessV2Profile1a1S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternValidateLicense3S , $iPatternValidateLicense3R , "$iPatternValidateLicense3S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternProcessV2Profile1b1S , $iPatternProcessV2Profile1b1R , "$iPatternProcessV2Profile1b1S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternProcessV2Profile1b2S , $iPatternProcessV2Profile1b2R , "$iPatternProcessV2Profile1b2S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternProcessV2Profile1b3S , $iPatternProcessV2Profile1b3R , "$iPatternProcessV2Profile1b3S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternProcessV2Profile1b4S , $iPatternProcessV2Profile1b4R , "$iPatternProcessV2Profile1b4S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternProcessV2Profile1CnV1S , $iPatternProcessV2Profile1CnV1R , "$iPatternProcessV2Profile1CnV1S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternProcessV2Profile1CnV2S , $iPatternProcessV2Profile1CnV2R , "$iPatternProcessV2Profile1CnV2S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternProcessV2Profile1d1S , $iPatternProcessV2Profile1d1R , "$iPatternProcessV2Profile1d1S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternProcessV2Profile1d2S , $iPatternProcessV2Profile1d2R , "$iPatternProcessV2Profile1d2S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternAIEshSS , $iPatternAIEshSR , "$iPatternAIEshSS" )
			$myRegexPGlobalPatternSearchCount = 0
			ProgressWrite ( 0 )
			GUICtrlSetData ( $g_idMemoPPSwitch , "0" )
		Else
			MemoWrite1 ( $myIButtonClicked & @CRLF & "---" & @CRLF & "File is not 'vanilla'. Aborting..." & @CRLF & "---" )
			$myRegexPGlobalPatternSearchCount = 0
			ProgressWrite ( 0 )
			GUICtrlSetData ( $g_idMemoPPSwitch , "0" )
			Sleep ( 2000 )
		EndIf
	Case $myIButtonClicked = 8
		$count = 27
		MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternPROFILE_EXPIREDS , $iPatternPROFILE_EXPIREDR , "$iPatternPROFILE_EXPIREDS" )
		If UBound ( $aOutHexGlobalArray ) > 0 Then
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternValidateLicenseS , $iPatternValidateLicenseR , "$iPatternValidateLicenseS" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternValidateLicense1S , $iPatternValidateLicense1R , "$iPatternValidateLicense1S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternValidateLicense2S , $iPatternValidateLicense2R , "$iPatternValidateLicense2S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternCmpEax6S , $iPatternCmpEax6R , "$iPatternCmpEax6S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternProcessV2Profile1aS , $iPatternProcessV2Profile1aR , "$iPatternProcessV2Profile1aS" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternProcessV2Profile1a1S , $iPatternProcessV2Profile1a1R , "$iPatternProcessV2Profile1a1S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternValidateLicense3S , $iPatternValidateLicense3R , "$iPatternValidateLicense3S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternProcessV2Profile1b1S , $iPatternProcessV2Profile1b1R , "$iPatternProcessV2Profile1b1S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternProcessV2Profile1b2S , $iPatternProcessV2Profile1b2R , "$iPatternProcessV2Profile1b2S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternProcessV2Profile1b3S , $iPatternProcessV2Profile1b3R , "$iPatternProcessV2Profile1b3S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternProcessV2Profile1b4S , $iPatternProcessV2Profile1b4R , "$iPatternProcessV2Profile1b4S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternProcessV2Profile1CnV1S , $iPatternProcessV2Profile1CnV1R , "$iPatternProcessV2Profile1CnV1S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternProcessV2Profile1CnV2S , $iPatternProcessV2Profile1CnV2R , "$iPatternProcessV2Profile1CnV2S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternProcessV2Profile1d1S , $iPatternProcessV2Profile1d1R , "$iPatternProcessV2Profile1d1S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternProcessV2Profile1d2S , $iPatternProcessV2Profile1d2R , "$iPatternProcessV2Profile1d2S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternInCopySSWS , $iPatternInCopySSWR , "$iPatternInCopySSWS" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternAEPrruplTryoutS , $iPatternAEPrruplTryoutR , "$iPatternAEPrruplTryoutS" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternIsLicCompS , $iPatternIsLicCompR , "$iPatternIsLicCompS" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternPreventInstantShutdownS , $iPatternPreventInstantShutdownR , "$iPatternPreventInstantShutdownS" )
			MyRegexPGlobalPatternSearchSweetPea ( $myFileToParseSweetPea , $iPatternHevcMpegEnabler1S , $iPatternHevcMpegEnabler1R , "$iPatternHevcMpegEnabler1S" )
			MyRegexPGlobalPatternSearchSweetPea ( $myFileToParseSweetPea , $iPatternHevcMpegEnabler2S , $iPatternHevcMpegEnabler2R , "$iPatternHevcMpegEnabler2S" )
			MyRegexPGlobalPatternSearchSweetPea ( $myFileToParseSweetPea , $iPatternHevcMpegEnabler3S , $iPatternHevcMpegEnabler3R , "$iPatternHevcMpegEnabler3S" )
			MyRegexPGlobalPatternSearchSweetPea ( $myFileToParseSweetPea , $iPatternHevcMpegEnabler4S , $iPatternHevcMpegEnabler4R , "$iPatternHevcMpegEnabler4S" )
			MyRegexPGlobalPatternSearchEAClient ( $myFileToParseEAClient , $iPatternTeamProjectEnablerAS , $iPatternTeamProjectEnablerAR , "$iPatternTeamProjectEnablerAS" )
			MyRegexPGlobalPatternSearchEAClient ( $myFileToParseEAClient , $iPatternTeamProjectEnablerBS , $iPatternTeamProjectEnablerBR , "$iPatternTeamProjectEnablerBS" )
			MyRegexPGlobalPatternSearchEAClient ( $myFileToParseEAClient , $iPatternTeamProjectEnablerCS , $iPatternTeamProjectEnablerCR , "$iPatternTeamProjectEnablerCS" )
			$myRegexPGlobalPatternSearchCount = 0
			ProgressWrite ( 0 )
			GUICtrlSetData ( $g_idMemoPPSwitch , "0" )
		Else
			MemoWrite1 ( $myIButtonClicked & @CRLF & "---" & @CRLF & "File is not 'vanilla'. Aborting..." & @CRLF & "---" )
			$myRegexPGlobalPatternSearchCount = 0
			ProgressWrite ( 0 )
			GUICtrlSetData ( $g_idMemoPPSwitch , "0" )
			Sleep ( 2000 )
		EndIf
	Case $myIButtonClicked = 9
		$count = 17
		MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternPROFILE_EXPIREDS , $iPatternPROFILE_EXPIREDR , "$iPatternPROFILE_EXPIREDS" )
		If UBound ( $aOutHexGlobalArray ) > 0 Then
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternValidateLicenseS , $iPatternValidateLicenseR , "$iPatternValidateLicenseS" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternValidateLicense1S , $iPatternValidateLicense1R , "$iPatternValidateLicense1S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternValidateLicense2S , $iPatternValidateLicense2R , "$iPatternValidateLicense2S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternCmpEax6S , $iPatternCmpEax6R , "$iPatternCmpEax6S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternProcessV2Profile1aS , $iPatternProcessV2Profile1aR , "$iPatternProcessV2Profile1aS" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternProcessV2Profile1a1S , $iPatternProcessV2Profile1a1R , "$iPatternProcessV2Profile1a1S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternValidateLicense3S , $iPatternValidateLicense3R , "$iPatternValidateLicense3S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternProcessV2Profile1b1S , $iPatternProcessV2Profile1b1R , "$iPatternProcessV2Profile1b1S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternProcessV2Profile1b2S , $iPatternProcessV2Profile1b2R , "$iPatternProcessV2Profile1b2S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternProcessV2Profile1b3S , $iPatternProcessV2Profile1b3R , "$iPatternProcessV2Profile1b3S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternProcessV2Profile1b4S , $iPatternProcessV2Profile1b4R , "$iPatternProcessV2Profile1b4S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternProcessV2Profile1CnV1S , $iPatternProcessV2Profile1CnV1R , "$iPatternProcessV2Profile1CnV1S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternProcessV2Profile1CnV2S , $iPatternProcessV2Profile1CnV2R , "$iPatternProcessV2Profile1CnV2S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternProcessV2Profile1d1S , $iPatternProcessV2Profile1d1R , "$iPatternProcessV2Profile1d1S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternProcessV2Profile1d2S , $iPatternProcessV2Profile1d2R , "$iPatternProcessV2Profile1d2S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternInDesignSSWS , $iPatternInDesignSSWR , "$iPatternInDesignSSWS" )
			$myRegexPGlobalPatternSearchCount = 0
			ProgressWrite ( 0 )
			GUICtrlSetData ( $g_idMemoPPSwitch , "0" )
		Else
			MemoWrite1 ( $myIButtonClicked & @CRLF & "---" & @CRLF & "File is not 'vanilla'. Aborting..." & @CRLF & "---" )
			$myRegexPGlobalPatternSearchCount = 0
			ProgressWrite ( 0 )
			GUICtrlSetData ( $g_idMemoPPSwitch , "0" )
			Sleep ( 2000 )
		EndIf
	Case $myIButtonClicked = 10
		$count = 18
		MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternPROFILE_EXPIREDS , $iPatternPROFILE_EXPIREDR , "$iPatternPROFILE_EXPIREDS" )
		If UBound ( $aOutHexGlobalArray ) > 0 Then
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternValidateLicenseS , $iPatternValidateLicenseR , "$iPatternValidateLicenseS" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternValidateLicense1S , $iPatternValidateLicense1R , "$iPatternValidateLicense1S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternValidateLicense2S , $iPatternValidateLicense2R , "$iPatternValidateLicense2S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternCmpEax6S , $iPatternCmpEax6R , "$iPatternCmpEax6S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternProcessV2Profile1aS , $iPatternProcessV2Profile1aR , "$iPatternProcessV2Profile1aS" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternProcessV2Profile1a1S , $iPatternProcessV2Profile1a1R , "$iPatternProcessV2Profile1a1S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternValidateLicense3S , $iPatternValidateLicense3R , "$iPatternValidateLicense3S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternProcessV2Profile1b1S , $iPatternProcessV2Profile1b1R , "$iPatternProcessV2Profile1b1S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternProcessV2Profile1b2S , $iPatternProcessV2Profile1b2R , "$iPatternProcessV2Profile1b2S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternProcessV2Profile1b3S , $iPatternProcessV2Profile1b3R , "$iPatternProcessV2Profile1b3S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternProcessV2Profile1b4S , $iPatternProcessV2Profile1b4R , "$iPatternProcessV2Profile1b4S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternProcessV2Profile1CnV1S , $iPatternProcessV2Profile1CnV1R , "$iPatternProcessV2Profile1CnV1S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternProcessV2Profile1CnV2S , $iPatternProcessV2Profile1CnV2R , "$iPatternProcessV2Profile1CnV2S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternProcessV2Profile1d1S , $iPatternProcessV2Profile1d1R , "$iPatternProcessV2Profile1d1S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternProcessV2Profile1d2S , $iPatternProcessV2Profile1d2R , "$iPatternProcessV2Profile1d2S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternLightSubStatus1S , $iPatternLightSubStatus1R , "$iPatternLightSubStatus1S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternLightSubStatus2S , $iPatternLightSubStatus2R , "$iPatternLightSubStatus2S" )
			$myRegexPGlobalPatternSearchCount = 0
			ProgressWrite ( 0 )
			GUICtrlSetData ( $g_idMemoPPSwitch , "0" )
		Else
			MemoWrite1 ( $myIButtonClicked & @CRLF & "---" & @CRLF & "File is not 'vanilla'. Aborting..." & @CRLF & "---" )
			$myRegexPGlobalPatternSearchCount = 0
			ProgressWrite ( 0 )
			GUICtrlSetData ( $g_idMemoPPSwitch , "0" )
			Sleep ( 2000 )
		EndIf
	Case $myIButtonClicked = 11
		$count = 18
		MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternPROFILE_EXPIREDS , $iPatternPROFILE_EXPIREDR , "$iPatternPROFILE_EXPIREDS" )
		If UBound ( $aOutHexGlobalArray ) > 0 Then
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternValidateLicenseS , $iPatternValidateLicenseR , "$iPatternValidateLicenseS" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternValidateLicense1S , $iPatternValidateLicense1R , "$iPatternValidateLicense1S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternValidateLicense2S , $iPatternValidateLicense2R , "$iPatternValidateLicense2S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternCmpEax6S , $iPatternCmpEax6R , "$iPatternCmpEax6S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternProcessV2Profile1aS , $iPatternProcessV2Profile1aR , "$iPatternProcessV2Profile1aS" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternProcessV2Profile1a1S , $iPatternProcessV2Profile1a1R , "$iPatternProcessV2Profile1a1S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternValidateLicense3S , $iPatternValidateLicense3R , "$iPatternValidateLicense3S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternProcessV2Profile1b1S , $iPatternProcessV2Profile1b1R , "$iPatternProcessV2Profile1b1S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternProcessV2Profile1b2S , $iPatternProcessV2Profile1b2R , "$iPatternProcessV2Profile1b2S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternProcessV2Profile1b3S , $iPatternProcessV2Profile1b3R , "$iPatternProcessV2Profile1b3S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternProcessV2Profile1b4S , $iPatternProcessV2Profile1b4R , "$iPatternProcessV2Profile1b4S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternProcessV2Profile1CnV1S , $iPatternProcessV2Profile1CnV1R , "$iPatternProcessV2Profile1CnV1S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternProcessV2Profile1CnV2S , $iPatternProcessV2Profile1CnV2R , "$iPatternProcessV2Profile1CnV2S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternProcessV2Profile1d1S , $iPatternProcessV2Profile1d1R , "$iPatternProcessV2Profile1d1S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternProcessV2Profile1d2S , $iPatternProcessV2Profile1d2R , "$iPatternProcessV2Profile1d2S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternLightSubStatus1S , $iPatternLightSubStatus1R , "$iPatternLightSubStatus1S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternLightSubStatus2S , $iPatternLightSubStatus2R , "$iPatternLightSubStatus2S" )
			$myRegexPGlobalPatternSearchCount = 0
			ProgressWrite ( 0 )
			GUICtrlSetData ( $g_idMemoPPSwitch , "0" )
		Else
			MemoWrite1 ( $myIButtonClicked & @CRLF & "---" & @CRLF & "File is not 'vanilla'. Aborting..." & @CRLF & "---" )
			$myRegexPGlobalPatternSearchCount = 0
			ProgressWrite ( 0 )
			GUICtrlSetData ( $g_idMemoPPSwitch , "0" )
			Sleep ( 2000 )
		EndIf
	Case $myIButtonClicked = 12
		$count = 26
		MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternPROFILE_EXPIREDS , $iPatternPROFILE_EXPIREDR , "$iPatternPROFILE_EXPIREDS" )
		If UBound ( $aOutHexGlobalArray ) > 0 Then
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternValidateLicenseS , $iPatternValidateLicenseR , "$iPatternValidateLicenseS" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternValidateLicense1S , $iPatternValidateLicense1R , "$iPatternValidateLicense1S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternValidateLicense2S , $iPatternValidateLicense2R , "$iPatternValidateLicense2S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternCmpEax6S , $iPatternCmpEax6R , "$iPatternCmpEax6S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternProcessV2Profile1aS , $iPatternProcessV2Profile1aR , "$iPatternProcessV2Profile1aS" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternProcessV2Profile1a1S , $iPatternProcessV2Profile1a1R , "$iPatternProcessV2Profile1a1S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternValidateLicense3S , $iPatternValidateLicense3R , "$iPatternValidateLicense3S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternProcessV2Profile1b1S , $iPatternProcessV2Profile1b1R , "$iPatternProcessV2Profile1b1S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternProcessV2Profile1b2S , $iPatternProcessV2Profile1b2R , "$iPatternProcessV2Profile1b2S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternProcessV2Profile1b3S , $iPatternProcessV2Profile1b3R , "$iPatternProcessV2Profile1b3S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternProcessV2Profile1b4S , $iPatternProcessV2Profile1b4R , "$iPatternProcessV2Profile1b4S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternProcessV2Profile1CnV1S , $iPatternProcessV2Profile1CnV1R , "$iPatternProcessV2Profile1CnV1S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternProcessV2Profile1CnV2S , $iPatternProcessV2Profile1CnV2R , "$iPatternProcessV2Profile1CnV2S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternProcessV2Profile1d1S , $iPatternProcessV2Profile1d1R , "$iPatternProcessV2Profile1d1S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternProcessV2Profile1d2S , $iPatternProcessV2Profile1d2R , "$iPatternProcessV2Profile1d2S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternAEPrruplTryoutS , $iPatternAEPrruplTryoutR , "$iPatternAEPrruplTryoutS" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternIsLicCompS , $iPatternIsLicCompR , "$iPatternIsLicCompS" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternPreventInstantShutdownS , $iPatternPreventInstantShutdownR , "$iPatternPreventInstantShutdownS" )
			MyRegexPGlobalPatternSearchSweetPea ( $myFileToParseSweetPea , $iPatternHevcMpegEnabler1S , $iPatternHevcMpegEnabler1R , "$iPatternHevcMpegEnabler1S" )
			MyRegexPGlobalPatternSearchSweetPea ( $myFileToParseSweetPea , $iPatternHevcMpegEnabler2S , $iPatternHevcMpegEnabler2R , "$iPatternHevcMpegEnabler2S" )
			MyRegexPGlobalPatternSearchSweetPea ( $myFileToParseSweetPea , $iPatternHevcMpegEnabler3S , $iPatternHevcMpegEnabler3R , "$iPatternHevcMpegEnabler3S" )
			MyRegexPGlobalPatternSearchSweetPea ( $myFileToParseSweetPea , $iPatternHevcMpegEnabler4S , $iPatternHevcMpegEnabler4R , "$iPatternHevcMpegEnabler4S" )
			MyRegexPGlobalPatternSearchEAClient ( $myFileToParseEAClient , $iPatternTeamProjectEnablerAS , $iPatternTeamProjectEnablerAR , "$iPatternTeamProjectEnablerAS" )
			MyRegexPGlobalPatternSearchEAClient ( $myFileToParseEAClient , $iPatternTeamProjectEnablerBS , $iPatternTeamProjectEnablerBR , "$iPatternTeamProjectEnablerBS" )
			MyRegexPGlobalPatternSearchEAClient ( $myFileToParseEAClient , $iPatternTeamProjectEnablerCS , $iPatternTeamProjectEnablerCR , "$iPatternTeamProjectEnablerCS" )
			$myRegexPGlobalPatternSearchCount = 0
			ProgressWrite ( 0 )
			GUICtrlSetData ( $g_idMemoPPSwitch , "0" )
		Else
			MemoWrite1 ( $myIButtonClicked & @CRLF & "---" & @CRLF & "File is not 'vanilla'. Aborting..." & @CRLF & "---" )
			$myRegexPGlobalPatternSearchCount = 0
			ProgressWrite ( 0 )
			GUICtrlSetData ( $g_idMemoPPSwitch , "0" )
			Sleep ( 2000 )
		EndIf
	Case $myIButtonClicked = 13
		$count = 20
		MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternPROFILE_EXPIREDS , $iPatternPROFILE_EXPIREDR , "$iPatternPROFILE_EXPIREDS" )
		If UBound ( $aOutHexGlobalArray ) > 0 Then
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternValidateLicenseS , $iPatternValidateLicenseR , "$iPatternValidateLicenseS" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternValidateLicense1S , $iPatternValidateLicense1R , "$iPatternValidateLicense1S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternValidateLicense2S , $iPatternValidateLicense2R , "$iPatternValidateLicense2S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternCmpEax6S , $iPatternCmpEax6R , "$iPatternCmpEax6S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternProcessV2Profile1aS , $iPatternProcessV2Profile1aR , "$iPatternProcessV2Profile1aS" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternProcessV2Profile1a1S , $iPatternProcessV2Profile1a1R , "$iPatternProcessV2Profile1a1S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternValidateLicense3S , $iPatternValidateLicense3R , "$iPatternValidateLicense3S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternProcessV2Profile1b1S , $iPatternProcessV2Profile1b1R , "$iPatternProcessV2Profile1b1S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternProcessV2Profile1b2S , $iPatternProcessV2Profile1b2R , "$iPatternProcessV2Profile1b2S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternProcessV2Profile1b3S , $iPatternProcessV2Profile1b3R , "$iPatternProcessV2Profile1b3S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternProcessV2Profile1b4S , $iPatternProcessV2Profile1b4R , "$iPatternProcessV2Profile1b4S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternProcessV2Profile1CnV1S , $iPatternProcessV2Profile1CnV1R , "$iPatternProcessV2Profile1CnV1S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternProcessV2Profile1CnV2S , $iPatternProcessV2Profile1CnV2R , "$iPatternProcessV2Profile1CnV2S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternProcessV2Profile1d1S , $iPatternProcessV2Profile1d1R , "$iPatternProcessV2Profile1d1S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternProcessV2Profile1d2S , $iPatternProcessV2Profile1d2R , "$iPatternProcessV2Profile1d2S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternPSEshSS1 , $iPatternPSEshSR1 , "$iPatternPSEshSS1" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternPSEshSS2 , $iPatternPSEshSR2 , "$iPatternPSEshSS2" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternPSAIEshSS3 , $iPatternPSAIEshSR3 , "$iPatternPSAIEshSS3" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternPSvideoExportS , $iPatternPSvideoExportR , "$iPatternPSvideoExportS" )
			$myRegexPGlobalPatternSearchCount = 0
			$count = 0
			ProgressWrite ( 0 )
			GUICtrlSetData ( $g_idMemoPPSwitch , "0" )
		Else
			MemoWrite1 ( $myIButtonClicked & @CRLF & "---" & @CRLF & "File is not 'vanilla'. Aborting..." & @CRLF & "---" )
			$myRegexPGlobalPatternSearchCount = 0
			ProgressWrite ( 0 )
			GUICtrlSetData ( $g_idMemoPPSwitch , "0" )
			Sleep ( 2000 )
		EndIf
	Case $myIButtonClicked = 14
		$count = 26
		MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternPROFILE_EXPIREDS , $iPatternPROFILE_EXPIREDR , "$iPatternPROFILE_EXPIREDS" )
		If UBound ( $aOutHexGlobalArray ) > 0 Then
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternValidateLicenseS , $iPatternValidateLicenseR , "$iPatternValidateLicenseS" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternValidateLicense1S , $iPatternValidateLicense1R , "$iPatternValidateLicense1S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternValidateLicense2S , $iPatternValidateLicense2R , "$iPatternValidateLicense2S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternCmpEax6S , $iPatternCmpEax6R , "$iPatternCmpEax6S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternProcessV2Profile1aS , $iPatternProcessV2Profile1aR , "$iPatternProcessV2Profile1aS" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternProcessV2Profile1a1S , $iPatternProcessV2Profile1a1R , "$iPatternProcessV2Profile1a1S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternValidateLicense3S , $iPatternValidateLicense3R , "$iPatternValidateLicense3S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternProcessV2Profile1b1S , $iPatternProcessV2Profile1b1R , "$iPatternProcessV2Profile1b1S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternProcessV2Profile1b2S , $iPatternProcessV2Profile1b2R , "$iPatternProcessV2Profile1b2S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternProcessV2Profile1b3S , $iPatternProcessV2Profile1b3R , "$iPatternProcessV2Profile1b3S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternProcessV2Profile1b4S , $iPatternProcessV2Profile1b4R , "$iPatternProcessV2Profile1b4S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternProcessV2Profile1CnV1S , $iPatternProcessV2Profile1CnV1R , "$iPatternProcessV2Profile1CnV1S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternProcessV2Profile1CnV2S , $iPatternProcessV2Profile1CnV2R , "$iPatternProcessV2Profile1CnV2S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternProcessV2Profile1d1S , $iPatternProcessV2Profile1d1R , "$iPatternProcessV2Profile1d1S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternProcessV2Profile1d2S , $iPatternProcessV2Profile1d2R , "$iPatternProcessV2Profile1d2S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternAEPrruplTryoutS , $iPatternAEPrruplTryoutR , "$iPatternAEPrruplTryoutS" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternIsLicCompS , $iPatternIsLicCompR , "$iPatternIsLicCompS" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternPreventInstantShutdownS , $iPatternPreventInstantShutdownR , "$iPatternPreventInstantShutdownS" )
			MyRegexPGlobalPatternSearchSweetPea ( $myFileToParseSweetPea , $iPatternHevcMpegEnabler1S , $iPatternHevcMpegEnabler1R , "$iPatternHevcMpegEnabler1S" )
			MyRegexPGlobalPatternSearchSweetPea ( $myFileToParseSweetPea , $iPatternHevcMpegEnabler2S , $iPatternHevcMpegEnabler2R , "$iPatternHevcMpegEnabler2S" )
			MyRegexPGlobalPatternSearchSweetPea ( $myFileToParseSweetPea , $iPatternHevcMpegEnabler3S , $iPatternHevcMpegEnabler3R , "$iPatternHevcMpegEnabler3S" )
			MyRegexPGlobalPatternSearchSweetPea ( $myFileToParseSweetPea , $iPatternHevcMpegEnabler4S , $iPatternHevcMpegEnabler4R , "$iPatternHevcMpegEnabler4S" )
			MyRegexPGlobalPatternSearchEAClient ( $myFileToParseEAClient , $iPatternTeamProjectEnablerAS , $iPatternTeamProjectEnablerAR , "$iPatternTeamProjectEnablerAS" )
			MyRegexPGlobalPatternSearchEAClient ( $myFileToParseEAClient , $iPatternTeamProjectEnablerBS , $iPatternTeamProjectEnablerBR , "$iPatternTeamProjectEnablerBS" )
			MyRegexPGlobalPatternSearchEAClient ( $myFileToParseEAClient , $iPatternTeamProjectEnablerCS , $iPatternTeamProjectEnablerCR , "$iPatternTeamProjectEnablerCS" )
			$myRegexPGlobalPatternSearchCount = 0
			ProgressWrite ( 0 )
			GUICtrlSetData ( $g_idMemoPPSwitch , "0" )
		Else
			MemoWrite1 ( $myIButtonClicked & @CRLF & "---" & @CRLF & "File is not 'vanilla'. Aborting..." & @CRLF & "---" )
			$myRegexPGlobalPatternSearchCount = 0
			ProgressWrite ( 0 )
			GUICtrlSetData ( $g_idMemoPPSwitch , "0" )
			Sleep ( 2000 )
		EndIf
	Case $myIButtonClicked = 15
		$count = 26
		MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternPROFILE_EXPIREDS , $iPatternPROFILE_EXPIREDR , "$iPatternPROFILE_EXPIREDS" )
		If UBound ( $aOutHexGlobalArray ) > 0 Then
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternValidateLicenseS , $iPatternValidateLicenseR , "$iPatternValidateLicenseS" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternValidateLicense1S , $iPatternValidateLicense1R , "$iPatternValidateLicense1S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternValidateLicense2S , $iPatternValidateLicense2R , "$iPatternValidateLicense2S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternCmpEax6S , $iPatternCmpEax6R , "$iPatternCmpEax6S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternProcessV2Profile1aS , $iPatternProcessV2Profile1aR , "$iPatternProcessV2Profile1aS" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternProcessV2Profile1a1S , $iPatternProcessV2Profile1a1R , "$iPatternProcessV2Profile1a1S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternValidateLicense3S , $iPatternValidateLicense3R , "$iPatternValidateLicense3S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternProcessV2Profile1b1S , $iPatternProcessV2Profile1b1R , "$iPatternProcessV2Profile1b1S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternProcessV2Profile1b2S , $iPatternProcessV2Profile1b2R , "$iPatternProcessV2Profile1b2S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternProcessV2Profile1b3S , $iPatternProcessV2Profile1b3R , "$iPatternProcessV2Profile1b3S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternProcessV2Profile1b4S , $iPatternProcessV2Profile1b4R , "$iPatternProcessV2Profile1b4S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternProcessV2Profile1CnV1S , $iPatternProcessV2Profile1CnV1R , "$iPatternProcessV2Profile1CnV1S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternProcessV2Profile1CnV2S , $iPatternProcessV2Profile1CnV2R , "$iPatternProcessV2Profile1CnV2S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternProcessV2Profile1d1S , $iPatternProcessV2Profile1d1R , "$iPatternProcessV2Profile1d1S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternProcessV2Profile1d2S , $iPatternProcessV2Profile1d2R , "$iPatternProcessV2Profile1d2S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternAEPrruplTryoutS , $iPatternAEPrruplTryoutR , "$iPatternAEPrruplTryoutS" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternIsLicCompS , $iPatternIsLicCompR , "$iPatternIsLicCompS" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternPreventInstantShutdownS , $iPatternPreventInstantShutdownR , "$iPatternPreventInstantShutdownS" )
			MyRegexPGlobalPatternSearchSweetPea ( $myFileToParseSweetPea , $iPatternHevcMpegEnabler1S , $iPatternHevcMpegEnabler1R , "$iPatternHevcMpegEnabler1S" )
			MyRegexPGlobalPatternSearchSweetPea ( $myFileToParseSweetPea , $iPatternHevcMpegEnabler2S , $iPatternHevcMpegEnabler2R , "$iPatternHevcMpegEnabler2S" )
			MyRegexPGlobalPatternSearchSweetPea ( $myFileToParseSweetPea , $iPatternHevcMpegEnabler3S , $iPatternHevcMpegEnabler3R , "$iPatternHevcMpegEnabler3S" )
			MyRegexPGlobalPatternSearchSweetPea ( $myFileToParseSweetPea , $iPatternHevcMpegEnabler4S , $iPatternHevcMpegEnabler4R , "$iPatternHevcMpegEnabler4S" )
			MyRegexPGlobalPatternSearchEAClient ( $myFileToParseEAClient , $iPatternTeamProjectEnablerAS , $iPatternTeamProjectEnablerAR , "$iPatternTeamProjectEnablerAS" )
			MyRegexPGlobalPatternSearchEAClient ( $myFileToParseEAClient , $iPatternTeamProjectEnablerBS , $iPatternTeamProjectEnablerBR , "$iPatternTeamProjectEnablerBS" )
			MyRegexPGlobalPatternSearchEAClient ( $myFileToParseEAClient , $iPatternTeamProjectEnablerCS , $iPatternTeamProjectEnablerCR , "$iPatternTeamProjectEnablerCS" )
			$myRegexPGlobalPatternSearchCount = 0
			ProgressWrite ( 0 )
			GUICtrlSetData ( $g_idMemoPPSwitch , "0" )
		Else
			MemoWrite1 ( $myIButtonClicked & @CRLF & "---" & @CRLF & "File is not 'vanilla'. Aborting..." & @CRLF & "---" )
			$myRegexPGlobalPatternSearchCount = 0
			ProgressWrite ( 0 )
			GUICtrlSetData ( $g_idMemoPPSwitch , "0" )
			Sleep ( 2000 )
		EndIf
	Case $myIButtonClicked = 16
		$count = 26
		MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternPROFILE_EXPIREDS , $iPatternPROFILE_EXPIREDR , "$iPatternPROFILE_EXPIREDS" )
		If UBound ( $aOutHexGlobalArray ) > 0 Then
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternValidateLicenseS , $iPatternValidateLicenseR , "$iPatternValidateLicenseS" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternValidateLicense1S , $iPatternValidateLicense1R , "$iPatternValidateLicense1S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternValidateLicense2S , $iPatternValidateLicense2R , "$iPatternValidateLicense2S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternCmpEax6S , $iPatternCmpEax6R , "$iPatternCmpEax6S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternProcessV2Profile1aS , $iPatternProcessV2Profile1aR , "$iPatternProcessV2Profile1aS" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternProcessV2Profile1a1S , $iPatternProcessV2Profile1a1R , "$iPatternProcessV2Profile1a1S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternValidateLicense3S , $iPatternValidateLicense3R , "$iPatternValidateLicense3S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternProcessV2Profile1b1S , $iPatternProcessV2Profile1b1R , "$iPatternProcessV2Profile1b1S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternProcessV2Profile1b2S , $iPatternProcessV2Profile1b2R , "$iPatternProcessV2Profile1b2S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternProcessV2Profile1b3S , $iPatternProcessV2Profile1b3R , "$iPatternProcessV2Profile1b3S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternProcessV2Profile1b4S , $iPatternProcessV2Profile1b4R , "$iPatternProcessV2Profile1b4S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternProcessV2Profile1CnV1S , $iPatternProcessV2Profile1CnV1R , "$iPatternProcessV2Profile1CnV1S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternProcessV2Profile1CnV2S , $iPatternProcessV2Profile1CnV2R , "$iPatternProcessV2Profile1CnV2S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternProcessV2Profile1d1S , $iPatternProcessV2Profile1d1R , "$iPatternProcessV2Profile1d1S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternProcessV2Profile1d2S , $iPatternProcessV2Profile1d2R , "$iPatternProcessV2Profile1d2S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternAEPrruplTryoutS , $iPatternAEPrruplTryoutR , "$iPatternAEPrruplTryoutS" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternIsLicCompS , $iPatternIsLicCompR , "$iPatternIsLicCompS" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternPreventInstantShutdownS , $iPatternPreventInstantShutdownR , "$iPatternPreventInstantShutdownS" )
			MyRegexPGlobalPatternSearchSweetPea ( $myFileToParseSweetPea , $iPatternHevcMpegEnabler1S , $iPatternHevcMpegEnabler1R , "$iPatternHevcMpegEnabler1S" )
			MyRegexPGlobalPatternSearchSweetPea ( $myFileToParseSweetPea , $iPatternHevcMpegEnabler2S , $iPatternHevcMpegEnabler2R , "$iPatternHevcMpegEnabler2S" )
			MyRegexPGlobalPatternSearchSweetPea ( $myFileToParseSweetPea , $iPatternHevcMpegEnabler3S , $iPatternHevcMpegEnabler3R , "$iPatternHevcMpegEnabler3S" )
			MyRegexPGlobalPatternSearchSweetPea ( $myFileToParseSweetPea , $iPatternHevcMpegEnabler4S , $iPatternHevcMpegEnabler4R , "$iPatternHevcMpegEnabler4S" )
			MyRegexPGlobalPatternSearchEAClient ( $myFileToParseEAClient , $iPatternTeamProjectEnablerAS , $iPatternTeamProjectEnablerAR , "$iPatternTeamProjectEnablerAS" )
			MyRegexPGlobalPatternSearchEAClient ( $myFileToParseEAClient , $iPatternTeamProjectEnablerBS , $iPatternTeamProjectEnablerBR , "$iPatternTeamProjectEnablerBS" )
			MyRegexPGlobalPatternSearchEAClient ( $myFileToParseEAClient , $iPatternTeamProjectEnablerCS , $iPatternTeamProjectEnablerCR , "$iPatternTeamProjectEnablerCS" )
			$myRegexPGlobalPatternSearchCount = 0
			ProgressWrite ( 0 )
			GUICtrlSetData ( $g_idMemoPPSwitch , "0" )
		Else
			MemoWrite1 ( $myIButtonClicked & @CRLF & "---" & @CRLF & "File is not 'vanilla'. Aborting..." & @CRLF & "---" )
			$myRegexPGlobalPatternSearchCount = 0
			ProgressWrite ( 0 )
			GUICtrlSetData ( $g_idMemoPPSwitch , "0" )
			Sleep ( 2000 )
		EndIf
	Case $myIButtonClicked = 17
		$count = 10
		MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternAcrobatAS , $iPatternAcrobatAR , "$iPatternAcrobatAS" )
		MyRegexPGlobalPatternSearchPremiereHSR ( $myFileToParseFrontend , $iPatternAmtlib1S , $iPatternAmtlib1R , "$iPatternAmtlib1S" )
		MyRegexPGlobalPatternSearchPremiereHSR ( $myFileToParseFrontend , $iPatternAmtlib2S , $iPatternAmtlib2R , "$iPatternAmtlib2S" )
		MyRegexPGlobalPatternSearchPremiereHSR ( $myFileToParseFrontend , $iPatternAmtlib3S , $iPatternAmtlib3R , "$iPatternAmtlib3S" )
		MyRegexPGlobalPatternSearchPremiereHSR ( $myFileToParseFrontend , $iPatternAmtlib4S , $iPatternAmtlib4R , "$iPatternAmtlib4S" )
		MyRegexPGlobalPatternSearchPremiereHSR ( $myFileToParseFrontend , $iPatternAmtlib5S , $iPatternAmtlib5R , "$iPatternAmtlib5S" )
		MyRegexPGlobalPatternSearchAcroDist ( $myFileToParseSweetPea , $iPatternAcrodistAS , $iPatternAcrodistAR , "$iPatternAcrodistAS" )
		MyRegexPGlobalPatternSearchAcroTray ( $myFileToParseEAClient , $iPatternAcroTrayAS , $iPatternAcroTrayAR , "$iPatternAcroTrayAS" )
		$myRegexPGlobalPatternSearchCount = 0
		ProgressWrite ( 0 )
		GUICtrlSetData ( $g_idMemoPPSwitch , "0" )
	Case $myIButtonClicked = 18
		$count = 16
		MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternPROFILE_EXPIREDS , $iPatternPROFILE_EXPIREDR , "$iPatternPROFILE_EXPIREDS" )
		If UBound ( $aOutHexGlobalArray ) > 0 Then
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternValidateLicenseS , $iPatternValidateLicenseR , "$iPatternValidateLicenseS" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternValidateLicense1S , $iPatternValidateLicense1R , "$iPatternValidateLicense1S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternValidateLicense2S , $iPatternValidateLicense2R , "$iPatternValidateLicense2S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternCmpEax6S , $iPatternCmpEax6R , "$iPatternCmpEax6S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternProcessV2Profile1aS , $iPatternProcessV2Profile1aR , "$iPatternProcessV2Profile1aS" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternProcessV2Profile1a1S , $iPatternProcessV2Profile1a1R , "$iPatternProcessV2Profile1a1S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternValidateLicense3S , $iPatternValidateLicense3R , "$iPatternValidateLicense3S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternProcessV2Profile1b1S , $iPatternProcessV2Profile1b1R , "$iPatternProcessV2Profile1b1S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternProcessV2Profile1b2S , $iPatternProcessV2Profile1b2R , "$iPatternProcessV2Profile1b2S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternProcessV2Profile1b3S , $iPatternProcessV2Profile1b3R , "$iPatternProcessV2Profile1b3S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternProcessV2Profile1b4S , $iPatternProcessV2Profile1b4R , "$iPatternProcessV2Profile1b4S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternProcessV2Profile1CnV1S , $iPatternProcessV2Profile1CnV1R , "$iPatternProcessV2Profile1CnV1S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternProcessV2Profile1CnV2S , $iPatternProcessV2Profile1CnV2R , "$iPatternProcessV2Profile1CnV2S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternProcessV2Profile1d1S , $iPatternProcessV2Profile1d1R , "$iPatternProcessV2Profile1d1S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternProcessV2Profile1d2S , $iPatternProcessV2Profile1d2R , "$iPatternProcessV2Profile1d2S" )
			$myRegexPGlobalPatternSearchCount = 0
			ProgressWrite ( 0 )
			GUICtrlSetData ( $g_idMemoPPSwitch , "0" )
		Else
			MemoWrite1 ( $myIButtonClicked & @CRLF & "---" & @CRLF & "File is not 'vanilla'. Aborting..." & @CRLF & "---" )
			$myRegexPGlobalPatternSearchCount = 0
			ProgressWrite ( 0 )
			GUICtrlSetData ( $g_idMemoPPSwitch , "0" )
			Sleep ( 2000 )
		EndIf
	Case $myIButtonClicked = 19
		$count = 17
		MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternPROFILE_EXPIREDS , $iPatternPROFILE_EXPIREDR , "$iPatternPROFILE_EXPIREDS" )
		If UBound ( $aOutHexGlobalArray ) > 0 Then
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternValidateLicenseS , $iPatternValidateLicenseR , "$iPatternValidateLicenseS" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternValidateLicense1S , $iPatternValidateLicense1R , "$iPatternValidateLicense1S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternValidateLicense2S , $iPatternValidateLicense2R , "$iPatternValidateLicense2S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternCmpEax6S , $iPatternCmpEax6R , "$iPatternCmpEax6S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternProcessV2Profile1aS , $iPatternProcessV2Profile1aR , "$iPatternProcessV2Profile1aS" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternProcessV2Profile1a1S , $iPatternProcessV2Profile1a1R , "$iPatternProcessV2Profile1a1S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternValidateLicense3S , $iPatternValidateLicense3R , "$iPatternValidateLicense3S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternProcessV2Profile1b1S , $iPatternProcessV2Profile1b1R , "$iPatternProcessV2Profile1b1S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternProcessV2Profile1b2S , $iPatternProcessV2Profile1b2R , "$iPatternProcessV2Profile1b2S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternProcessV2Profile1b3S , $iPatternProcessV2Profile1b3R , "$iPatternProcessV2Profile1b3S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternProcessV2Profile1b4S , $iPatternProcessV2Profile1b4R , "$iPatternProcessV2Profile1b4S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternProcessV2Profile1CnV1S , $iPatternProcessV2Profile1CnV1R , "$iPatternProcessV2Profile1CnV1S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternProcessV2Profile1CnV2S , $iPatternProcessV2Profile1CnV2R , "$iPatternProcessV2Profile1CnV2S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternProcessV2Profile1d1S , $iPatternProcessV2Profile1d1R , "$iPatternProcessV2Profile1d1S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternProcessV2Profile1d2S , $iPatternProcessV2Profile1d2R , "$iPatternProcessV2Profile1d2S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternXDCompleteS , $iPatternXDCompleteR , "$iPatternXDCompleteS" )
			$myRegexPGlobalPatternSearchCount = 0
			ProgressWrite ( 0 )
			GUICtrlSetData ( $g_idMemoPPSwitch , "0" )
		Else
			MemoWrite1 ( $myIButtonClicked & @CRLF & "---" & @CRLF & "File is not 'vanilla'. Aborting..." & @CRLF & "---" )
			$myRegexPGlobalPatternSearchCount = 0
			ProgressWrite ( 0 )
			GUICtrlSetData ( $g_idMemoPPSwitch , "0" )
			Sleep ( 2000 )
		EndIf
	Case $myIButtonClicked = 20
		$count = 16
		MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternPROFILE_EXPIREDS , $iPatternPROFILE_EXPIREDR , "$iPatternPROFILE_EXPIREDS" )
		If UBound ( $aOutHexGlobalArray ) > 0 Then
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternValidateLicenseS , $iPatternValidateLicenseR , "$iPatternValidateLicenseS" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternValidateLicense1S , $iPatternValidateLicense1R , "$iPatternValidateLicense1S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternValidateLicense2S , $iPatternValidateLicense2R , "$iPatternValidateLicense2S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternCmpEax6S , $iPatternCmpEax6R , "$iPatternCmpEax6S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternProcessV2Profile1aS , $iPatternProcessV2Profile1aR , "$iPatternProcessV2Profile1aS" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternProcessV2Profile1a1S , $iPatternProcessV2Profile1a1R , "$iPatternProcessV2Profile1a1S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternValidateLicense3S , $iPatternValidateLicense3R , "$iPatternValidateLicense3S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternProcessV2Profile1b1S , $iPatternProcessV2Profile1b1R , "$iPatternProcessV2Profile1b1S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternProcessV2Profile1b2S , $iPatternProcessV2Profile1b2R , "$iPatternProcessV2Profile1b2S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternProcessV2Profile1b3S , $iPatternProcessV2Profile1b3R , "$iPatternProcessV2Profile1b3S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternProcessV2Profile1b4S , $iPatternProcessV2Profile1b4R , "$iPatternProcessV2Profile1b4S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternProcessV2Profile1CnV1S , $iPatternProcessV2Profile1CnV1R , "$iPatternProcessV2Profile1CnV1S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternProcessV2Profile1CnV2S , $iPatternProcessV2Profile1CnV2R , "$iPatternProcessV2Profile1CnV2S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternProcessV2Profile1d1S , $iPatternProcessV2Profile1d1R , "$iPatternProcessV2Profile1d1S" )
			MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternProcessV2Profile1d2S , $iPatternProcessV2Profile1d2R , "$iPatternProcessV2Profile1d2S" )
			$myRegexPGlobalPatternSearchCount = 0
			ProgressWrite ( 0 )
			GUICtrlSetData ( $g_idMemoPPSwitch , "0" )
		Else
			MemoWrite1 ( $myIButtonClicked & @CRLF & "---" & @CRLF & "File is not 'vanilla'. Aborting..." & @CRLF & "---" )
			$myRegexPGlobalPatternSearchCount = 0
			ProgressWrite ( 0 )
			GUICtrlSetData ( $g_idMemoPPSwitch , "0" )
			Sleep ( 2000 )
		EndIf
	Case $myIButtonClicked = 24
		MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternACCAS , $iPatternACCAR , "$iPatternACCAS" )
		MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternACCBS , $iPatternACCBR , "$iPatternACCBS" )
		MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternACCCS , $iPatternACCCR , "$iPatternACCCS" )
		MyRegexPGlobalPatternSearch ( $myFileToParse , $iPatternACCDS , $iPatternACCDR , "$iPatternACCDS" )
		$myRegexPGlobalPatternSearchCount = 0
		ProgressWrite ( 0 )
		GUICtrlSetData ( $g_idMemoPPSwitch , "0" )
Case Else
		MemoWrite1 ( $myIButtonClicked & @CRLF & "---" & @CRLF & "---Not Implemented---" & @CRLF & "---" & @CRLF & "---Not Implemented---" )
		$myRegexPGlobalPatternSearchCount = 0
		ProgressWrite ( 0 )
		GUICtrlSetData ( $g_idMemoPPSwitch , "0" )
	EndSelect
EndFunc

; These functions are duplicates, except the global variable where the output is stored is different
; See the documentation at the top of where the patterns are stored for how the replacement works

; Matches search pattern in files, generates regex with replacement pattern stored in $aOutHexGlobalArray
Func MyRegexPGlobalPatternSearch ( $fileToParse , $patternToSearch , $patternToReplace , $patternName )
	; Find matches of $patternToSearch in $fileToParse, stored in $aInHexArray
	Local $hFileOpen = FileOpen ( $fileToParse , $FO_READ + $FO_BINARY )
	Local $sFileRead = FileRead ( $hFileOpen )
	Local $iSearchPattern = $patternToSearch
	Local $iReplacePattern = $patternToReplace
	Local $iNewReplaceConstruct = ""
	Local $aInHexArray = StringRegExp ( $sFileRead , $iSearchPattern , $STR_REGEXPARRAYFULLMATCH , 1 )

	If @error = 0 Then
		If UBound ( $aInHexArray ) > 1 Then
			; Has capturing groups in regex replacement

			; Join the replacement and the capturing groups together, where n in number of elements in replacement pattern
			; ReplacePattern[0] CapturingGroup[0] ReplacePattern[1] CapturingGroup[1] ... ReplacePattern[n-2] CapturingGroup[n-2]
			For $I = 1 To UBound ( $aInHexArray ) - 1
				$iNewReplaceConstruct &= $iReplacePattern [ $I - 1 ] & $aInHexArray [ $I ]
			Next
			; ReplacePattern[0] CapturingGroup[0] ReplacePattern[1] CapturingGroup[1] ... ReplacePattern[n-2] CapturingGroup[n-2] ReplacePattern[n-1]
			$iNewReplaceConstruct &= $iReplacePattern [ UBound ( $iReplacePattern ) - 1 ]

			_ArrayAdd ( $aOutHexGlobalArray , $aInHexArray [ 0 ] ) ; Index 0 is full matching text
			_ArrayAdd ( $aOutHexGlobalArray , $iNewReplaceConstruct )

			ConsoleWrite ( $patternName & "---" & @TAB & $aInHexArray [ 0 ] & "	" & @CRLF )
			ConsoleWrite ( $patternName & "R" & "--" & @TAB & $iNewReplaceConstruct & "	" & @CRLF )
			MemoWrite1 ( $fileToParse & @CRLF & "---" & @CRLF & $patternName & "---" & "Ok" )
		Else
			; Regex replacement does not use capturing groups
			; ReplacePattern[0] ReplacePattern[1] ... ReplacePattern[n-1]
			$iNewReplaceConstruct = _ArrayToString ( $patternToReplace , -1 , 0 , 0 , 0 , 0 )
			_ArrayAdd ( $aOutHexGlobalArray , $aInHexArray [ 0 ] ) ; Index 0 is full matching text
			_ArrayAdd ( $aOutHexGlobalArray , $iNewReplaceConstruct )

			ConsoleWrite ( $patternName & "---" & @TAB & $aInHexArray [ 0 ] & "	" & @CRLF )
			ConsoleWrite ( $patternName & "R" & "--" & @TAB & $iNewReplaceConstruct & "	" & @CRLF )
			MemoWrite1 ( $fileToParse & @CRLF & "---" & @CRLF & $patternName & "---" & "Ok" )
		EndIf
	Else
		; Failed to match
		ConsoleWrite ( $patternName & "---" & @TAB & "No" & "	" & @CRLF )
		MemoWrite1 ( $fileToParse & @CRLF & "---" & @CRLF & $patternName & "---" & "No" )
	EndIf

	$myRegexPGlobalPatternSearchCount += 1
	FileClose ( $hFileOpen )
	$sFileRead = ""

	ProgressWrite ( Round ( $myRegexPGlobalPatternSearchCount / $count * 100 ) )
	Sleep ( 100 )
EndFunc
; Matches search pattern in files, generates regex with replacement pattern stored in $aOutHexGlobalArrayAcroDist
Func MyRegexPGlobalPatternSearchAcroDist ( $fileToParse , $patternToSearch , $patternToReplace , $patternName )
	Local $hFileOpen = FileOpen ( $fileToParse , $FO_READ + $FO_BINARY )
	Local $sFileRead = FileRead ( $hFileOpen )
	Local $iSearchPattern = $patternToSearch
	Local $iReplacePattern = $patternToReplace
	Local $iNewReplaceConstruct = ""
	Local $aInHexArray = StringRegExp ( $sFileRead , $iSearchPattern , $STR_REGEXPARRAYFULLMATCH , 1 )

	If @error = 0 Then
		If UBound ( $aInHexArray ) > 1 Then
			For $I = 1 To UBound ( $aInHexArray ) - 1
				$iNewReplaceConstruct &= $iReplacePattern [ $I - 1 ] & $aInHexArray [ $I ]
			Next
			$iNewReplaceConstruct &= $iReplacePattern [ UBound ( $iReplacePattern ) - 1 ]
			_ArrayAdd ( $aOutHexGlobalArrayAcroDist , $aInHexArray [ 0 ] )
			_ArrayAdd ( $aOutHexGlobalArrayAcroDist , $iNewReplaceConstruct )

			ConsoleWrite ( $patternName & "---" & @TAB & $aInHexArray [ 0 ] & "	" & @CRLF )
			ConsoleWrite ( $patternName & "R" & "--" & @TAB & $iNewReplaceConstruct & "	" & @CRLF )
			MemoWrite1 ( $fileToParse & @CRLF & "---" & @CRLF & $patternName & "---" & "Ok" )
		Else
			$iNewReplaceConstruct = _ArrayToString ( $patternToReplace , - 1 , 0 , 0 , 0 , 0 )
			_ArrayAdd ( $aOutHexGlobalArrayAcroDist , $aInHexArray [ 0 ] )
			_ArrayAdd ( $aOutHexGlobalArrayAcroDist , $iNewReplaceConstruct )

			ConsoleWrite ( $patternName & "---" & @TAB & $aInHexArray [ 0 ] & "	" & @CRLF )
			ConsoleWrite ( $patternName & "R" & "--" & @TAB & $iNewReplaceConstruct & "	" & @CRLF )
			MemoWrite1 ( $fileToParse & @CRLF & "---" & @CRLF & $patternName & "---" & "Ok" )
			$myRegexPGlobalPatternSearchCount += 1
		EndIf
	Else
		ConsoleWrite ( $patternName & "---" & @TAB & "No" & "	" & @CRLF )
		MemoWrite1 ( $fileToParse & @CRLF & "---" & @CRLF & $patternName & "---" & "No" )
		$myRegexPGlobalPatternSearchCount += 1
	EndIf
	ProgressWrite ( Round ( $myRegexPGlobalPatternSearchCount / 1 * 100 ) )
	Sleep ( 100 )
	FileClose ( $hFileOpen )
	$sFileRead = ""
EndFunc
; Matches search pattern in files, generates regex with replacement pattern stored in $aOutHexGlobalArrayAcroTray
Func MyRegexPGlobalPatternSearchAcroTray ( $fileToParse , $patternToSearch , $patternToReplace , $patternName )
	Local $hFileOpen = FileOpen ( $fileToParse , $FO_READ + $FO_BINARY )
	Local $sFileRead = FileRead ( $hFileOpen )
	Local $iSearchPattern = $patternToSearch
	Local $iReplacePattern = $patternToReplace
	Local $iNewReplaceConstruct = ""
	Local $aInHexArray = StringRegExp ( $sFileRead , $iSearchPattern , $STR_REGEXPARRAYFULLMATCH , 1 )
	If @error = 0 Then
		If UBound ( $aInHexArray ) > 1 Then
			For $I = 1 To UBound ( $aInHexArray ) - 1
				$iNewReplaceConstruct &= $iReplacePattern [ $I - 1 ] & $aInHexArray [ $I ]
			Next
			$iNewReplaceConstruct &= $iReplacePattern [ UBound ( $iReplacePattern ) - 1 ]
			_ArrayAdd ( $aOutHexGlobalArrayAcroTray , $aInHexArray [ 0 ] )
			_ArrayAdd ( $aOutHexGlobalArrayAcroTray , $iNewReplaceConstruct )

			ConsoleWrite ( $patternName & "---" & @TAB & $aInHexArray [ 0 ] & "	" & @CRLF )
			ConsoleWrite ( $patternName & "R" & "--" & @TAB & $iNewReplaceConstruct & "	" & @CRLF )
			MemoWrite1 ( $fileToParse & @CRLF & "---" & @CRLF & $patternName & "---" & "Ok" )
		Else
			$iNewReplaceConstruct = _ArrayToString ( $patternToReplace , - 1 , 0 , 0 , 0 , 0 )
			_ArrayAdd ( $aOutHexGlobalArrayAcroTray , $aInHexArray [ 0 ] )
			_ArrayAdd ( $aOutHexGlobalArrayAcroTray , $iNewReplaceConstruct )

			ConsoleWrite ( $patternName & "---" & @TAB & $aInHexArray [ 0 ] & "	" & @CRLF )
			ConsoleWrite ( $patternName & "R" & "--" & @TAB & $iNewReplaceConstruct & "	" & @CRLF )
			MemoWrite1 ( $fileToParse & @CRLF & "---" & @CRLF & $patternName & "---" & "Ok" )
			$myRegexPGlobalPatternSearchCount += 1
		EndIf
	Else
		ConsoleWrite ( $patternName & "---" & @TAB & "No" & "	" & @CRLF )
		MemoWrite1 ( $fileToParse & @CRLF & "---" & @CRLF & $patternName & "---" & "No" )
		$myRegexPGlobalPatternSearchCount += 1 ; Is this a mistake from copy and paste coding?
	EndIf
	ProgressWrite ( Round ( $myRegexPGlobalPatternSearchCount / 1 * 100 ) )
	Sleep ( 100 )
	FileClose ( $hFileOpen )
	$sFileRead = ""
EndFunc
; Matches search pattern in files, generates regex with replacement pattern stored in $aOutHexGlobalArraySweetPea
Func MyRegexPGlobalPatternSearchSweetPea ( $fileToParse , $patternToSearch , $patternToReplace , $patternName )
	Local $hFileOpen = FileOpen ( $fileToParse , $FO_READ + $FO_BINARY )
	Local $sFileRead = FileRead ( $hFileOpen )
	Local $iSearchPattern = $patternToSearch
	Local $iReplacePattern = $patternToReplace
	Local $iNewReplaceConstruct = ""
	Local $aInHexArray = StringRegExp ( $sFileRead , $iSearchPattern , $STR_REGEXPARRAYFULLMATCH , 1 )
	If @error = 0 Then
		If UBound ( $aInHexArray ) > 1 Then
			For $I = 1 To UBound ( $aInHexArray ) - 1
				$iNewReplaceConstruct &= $iReplacePattern [ $I - 1 ] & $aInHexArray [ $I ]
			Next
			$iNewReplaceConstruct &= $iReplacePattern [ UBound ( $iReplacePattern ) - 1 ]
			_ArrayAdd ( $aOutHexGlobalArraySweetPea , $aInHexArray [ 0 ] )
			_ArrayAdd ( $aOutHexGlobalArraySweetPea , $iNewReplaceConstruct )

			ConsoleWrite ( $patternName & "---" & @TAB & $aInHexArray [ 0 ] & "	" & @CRLF )
			ConsoleWrite ( $patternName & "R" & "--" & @TAB & $iNewReplaceConstruct & "	" & @CRLF )
			MemoWrite1 ( $fileToParse & @CRLF & "---" & @CRLF & $patternName & "---" & "Ok" )
		Else
			$iNewReplaceConstruct = _ArrayToString ( $patternToReplace , - 1 , 0 , 0 , 0 , 0 )
			_ArrayAdd ( $aOutHexGlobalArraySweetPea , $aInHexArray [ 0 ] )
			_ArrayAdd ( $aOutHexGlobalArraySweetPea , $iNewReplaceConstruct )

			ConsoleWrite ( $patternName & "---" & @TAB & $aInHexArray [ 0 ] & "	" & @CRLF )
			ConsoleWrite ( $patternName & "R" & "--" & @TAB & $iNewReplaceConstruct & "	" & @CRLF )
			MemoWrite1 ( $fileToParse & @CRLF & "---" & @CRLF & $patternName & "---" & "Ok" )
			$myRegexPGlobalPatternSearchCount += 1
		EndIf
	Else
		ConsoleWrite ( $patternName & "---" & @TAB & "No" & "	" & @CRLF )
		MemoWrite1 ( $fileToParse & @CRLF & "---" & @CRLF & $patternName & "---" & "No" )
		$myRegexPGlobalPatternSearchCount += 1
	EndIf
	ProgressWrite ( Round ( $myRegexPGlobalPatternSearchCount / 1 * 100 ) )
	Sleep ( 100 )
	FileClose ( $hFileOpen )
	$sFileRead = ""
EndFunc
; Matches search pattern in files, generates regex with replacement pattern stored in $aOutHexGlobalArrayEAClient
Func MyRegexPGlobalPatternSearchEAClient ( $fileToParse , $patternToSearch , $patternToReplace , $patternName )
	Local $hFileOpen = FileOpen ( $fileToParse , $FO_READ + $FO_BINARY )
	Local $sFileRead = FileRead ( $hFileOpen )
	Local $iSearchPattern = $patternToSearch
	Local $iReplacePattern = $patternToReplace
	Local $iNewReplaceConstruct = ""
	Local $aInHexArray = StringRegExp ( $sFileRead , $iSearchPattern , $STR_REGEXPARRAYFULLMATCH , 1 )
	If @error = 0 Then
		If UBound ( $aInHexArray ) > 1 Then
			For $I = 1 To UBound ( $aInHexArray ) - 1
				$iNewReplaceConstruct &= $iReplacePattern [ $I - 1 ] & $aInHexArray [ $I ]
			Next
			$iNewReplaceConstruct &= $iReplacePattern [ UBound ( $iReplacePattern ) - 1 ]
			_ArrayAdd ( $aOutHexGlobalArrayEAClient , $aInHexArray [ 0 ] )
			_ArrayAdd ( $aOutHexGlobalArrayEAClient , $iNewReplaceConstruct )

			ConsoleWrite ( $patternName & "---" & @TAB & $aInHexArray [ 0 ] & "	" & @CRLF )
			ConsoleWrite ( $patternName & "R" & "--" & @TAB & $iNewReplaceConstruct & "	" & @CRLF )
			MemoWrite1 ( $fileToParse & @CRLF & "---" & @CRLF & $patternName & "---" & "Ok" )
		Else
			$iNewReplaceConstruct = _ArrayToString ( $patternToReplace , - 1 , 0 , 0 , 0 , 0 )
			_ArrayAdd ( $aOutHexGlobalArrayEAClient , $aInHexArray [ 0 ] )
			_ArrayAdd ( $aOutHexGlobalArrayEAClient , $iNewReplaceConstruct )

			ConsoleWrite ( $patternName & "---" & @TAB & $aInHexArray [ 0 ] & "	" & @CRLF )
			ConsoleWrite ( $patternName & "R" & "--" & @TAB & $iNewReplaceConstruct & "	" & @CRLF )
			MemoWrite1 ( $fileToParse & @CRLF & "---" & @CRLF & $patternName & "---" & "Ok" )
			$myRegexPGlobalPatternSearchCount += 1
		EndIf
	Else
		ConsoleWrite ( $patternName & "---" & @TAB & "No" & "	" & @CRLF )
		MemoWrite1 ( $fileToParse & @CRLF & "---" & @CRLF & $patternName & "---" & "No" )
		$myRegexPGlobalPatternSearchCount += 1
	EndIf
	ProgressWrite ( Round ( $myRegexPGlobalPatternSearchCount / 1 * 100 ) )
	Sleep ( 100 )
	FileClose ( $hFileOpen )
	$sFileRead = ""
EndFunc
; Matches search pattern in files, generates regex with replacement pattern stored in $aOutHexGlobalArrayPremiereHSR
Func MyRegexPGlobalPatternSearchPremiereHSR ( $fileToParse , $patternToSearch , $patternToReplace , $patternName )
	Local $hFileOpen = FileOpen ( $fileToParse , $FO_READ + $FO_BINARY )
	Local $sFileRead = FileRead ( $hFileOpen )
	Local $iSearchPattern = $patternToSearch
	Local $iReplacePattern = $patternToReplace
	Local $iNewReplaceConstruct = ""
	Local $aInHexArray = StringRegExp ( $sFileRead , $iSearchPattern , $STR_REGEXPARRAYFULLMATCH , 1 )
	If @error = 0 Then
		If UBound ( $aInHexArray ) > 1 Then
			For $I = 1 To UBound ( $aInHexArray ) - 1
				$iNewReplaceConstruct &= $iReplacePattern [ $I - 1 ] & $aInHexArray [ $I ]
			Next
			$iNewReplaceConstruct &= $iReplacePattern [ UBound ( $iReplacePattern ) - 1 ]
			_ArrayAdd ( $aOutHexGlobalArrayPremiereHSR , $aInHexArray [ 0 ] )
			_ArrayAdd ( $aOutHexGlobalArrayPremiereHSR , $iNewReplaceConstruct )

			ConsoleWrite ( $patternName & "---" & @TAB & $aInHexArray [ 0 ] & "	" & @CRLF )
			ConsoleWrite ( $patternName & "R" & "--" & @TAB & $iNewReplaceConstruct & "	" & @CRLF )
			MemoWrite1 ( $fileToParse & @CRLF & "---" & @CRLF & $patternName & "---" & "Ok" )
		Else
			$iNewReplaceConstruct = _ArrayToString ( $patternToReplace , - 1 , 0 , 0 , 0 , 0 )
			_ArrayAdd ( $aOutHexGlobalArrayPremiereHSR , $aInHexArray [ 0 ] )
			_ArrayAdd ( $aOutHexGlobalArrayPremiereHSR , $iNewReplaceConstruct )

			ConsoleWrite ( $patternName & "---" & @TAB & $aInHexArray [ 0 ] & "	" & @CRLF )
			ConsoleWrite ( $patternName & "R" & "--" & @TAB & $iNewReplaceConstruct & "	" & @CRLF )
			MemoWrite1 ( $fileToParse & @CRLF & "---" & @CRLF & $patternName & "---" & "Ok" )
			$myRegexPGlobalPatternSearchCount += 1
		EndIf
	Else
		ConsoleWrite ( $patternName & "---" & @TAB & "No" & "	" & @CRLF )
		MemoWrite1 ( $fileToParse & @CRLF & "---" & @CRLF & $patternName & "---" & "No" )
		$myRegexPGlobalPatternSearchCount += 1
	EndIf
	ProgressWrite ( Round ( $myRegexPGlobalPatternSearchCount / 25 * 100 ) )
	Sleep ( 100 )
	FileClose ( $hFileOpen )
	$sFileRead = ""
EndFunc

; Patches file by replacing substring at even indices i with the value at i + 1
; Old file stored in file.bak
; $myFileToPatch : One of :
;     $myFileToParse
;     $myFileToParseSweetPea
;     $myFileToParseEAClient
;     $myFileToParseFrontend
; $myArrayToPatch : One of :
;     $aOutHexGlobalArray
;     $aOutHexGlobalArrayAcroDist
;     $aOutHexGlobalArrayAcroTray
;     $aOutHexGlobalArraySweetPea
;     $aOutHexGlobalArrayEAClient
;     $aOutHexGlobalArrayPremiereHSR
Func MyGlobalPatternPatch ( $myFileToPatch , $myArrayToPatch )
	ProgressWrite ( 0 )
	Local $iPath = $myFileToPatch
	Local $sDrive = "" , $sDir = "" , $sFilename = "" , $sExtension = ""
	Local $aPathSplit = _PathSplit ( $iPath , $sDrive , $sDir , $sFilename , $sExtension )

	Local $iRows1 = 0
	$iRows1 = UBound ( $myArrayToPatch )
	If $iRows1 > 0 Then
		Local $hFileOpen = FileOpen ( $iPath , $FO_READ + $FO_BINARY )
		Local $sFileRead = FileRead ( $hFileOpen )

		; Array is of the format
		;     0 : Full matching text 1
		;     1 : Replacement 1
		;     2 : Full matching text 2
		;     3 : Replacement 2
		;     ...
		; Replaces pattern in file (at even indices) with replacement (at odd indices)
		For $I = 0 To $iRows1 - 1 Step 2
			Local $sStringOut = StringReplace ( $sFileRead , $myArrayToPatch [ $I ] , $myArrayToPatch [ $I + 1 ] , 0 , 1 )
			$sFileRead = $sStringOut
			$sStringOut = $sFileRead
			ProgressWrite ( Round ( $I / $iRows1 * 100 ) )
		Next
		FileClose ( $hFileOpen )

		; Move the original file to <name>.bak
		FileMove ( $iPath , $iPath & ".bak" , 1 )

		; Write the new patched file
		Local $hFileOpen1 = FileOpen ( $iPath , $FO_OVERWRITE + $FO_BINARY )
		FileWrite ( $hFileOpen1 , Binary ( $sStringOut ) )
		FileClose ( $hFileOpen1 )

		ProgressWrite ( 0 )
		Sleep ( 100 )
	Else
	EndIf
EndFunc
