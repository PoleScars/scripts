REM #Formate of RoboCopy - robocopy "sourceDirectory" "destinationDirectory" /E

REM "EMU - Coping ALL new directories & files to Micro Drive to Public Drive."
REM "EMU - Overwriting ALL existing Micro Drive files whom's source timestamps have advanced."

REM "NOTE: Open Or Locked files will NOT copy!!!"



REM "Micro Drive to Public Drive Transfer"
Robocopy.exe "source" "destination" /E

REM "Micro Drive to Public Drive Transfer complete"

timeout 300