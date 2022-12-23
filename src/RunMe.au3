#RequireAdmin
#Region
#AutoIt3Wrapper_Icon=Resources\ICONS\Skull.ico
#EndRegion
; Original: $SCMDLINE = @ScriptDir & "\Resources\NSudo.exe -U:T -ShowWindowMode:Hide" & " " & @ScriptDir & "\Resources\Adobe-GenP-2.7"
; Adjusted command line for reversed version of NSudo (no flags)
$SCMDLINE = @ScriptDir & "\Resources\NSudo.exe " & @ScriptDir & "\Resources\Adobe-GenP-2.7"
Run ( $SCMDLINE )

