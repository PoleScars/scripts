REM #Formate of RoboCopy - robocopy "sourceDirectory" "destinationDirectory" /E

REM "EMU - Coping Documents to EMU Public Drive."
REM "EMU - Overwriting ALL existing USB files whom's source timestamps have advanced."

REM "NOTE: Open Or Locked files will NOT copy!!!"



REM "EMU Documents to EMU Public Drive Transfer"
Robocopy.exe "C:\Users\Public\Documents" "M:\emupublic\z3492622-SG" /E ^
/XD ^
"Libraries\Documents\Downloaded Installers" ^ 
"Libraries\Documents\Fax" ^
"Libraries\Documents\Scanned Documents" ^
"C:\Users\public\Documents\My Music" ^
"C:\Users\public\Documents\My Pictures" ^
"C:\Users\public\Documents\My Videos"

REM "EMU Documents to EMU Public Drive Transfer complete"

REM "EMU Documents to EMU Public Drive Transfer complete"

timeout 300