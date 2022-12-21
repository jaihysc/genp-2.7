#RequireAdmin
#Region
#AutoIt3Wrapper_Icon=Resources\ICONS\Skull.ico
#EndRegion
$SCMDLINE = @ScriptDir & "\Resources\NSudo.exe -U:T -ShowWindowMode:Hide" & " " & @ScriptDir & "\Resources\Adobe-GenP-2.7"
Run ( $SCMDLINE )

