REM #Formate of RoboCopy - robocopy "sourceDirectory" "destinationDirectory" /E

REM "Documents - Coping ALL new directories & files to DropBox."
REM "Documents - Overwriting ALL existing DropBox files whom's source timestamps have advanced."

REM "NOTE: Open Or Locked files will NOT copy!!!"



REM "DropBox Backup"
Robocopy.exe "C:\Users\z3492622\Documents\PhD Project" "C:\Users\z3492622\Dropbox\PhD Project" /E 

REM "Backup to DropBox complete"

timeout 300