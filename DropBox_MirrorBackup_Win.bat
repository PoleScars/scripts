REM #Formate of RoboCopy - robocopy "sourceDirectory" "destinationDirectory" /E

REM "Documents - Coping ALL new directories & files to DropBox."
REM "Documents - Overwriting ALL existing DropBox files whom's source timestamps have advanced."

REM "NOTE: Open Or Locked files will NOT copy!!!"



REM "DropBox Mirror Backup - Mirrors Windows machine into Dropbox"
Robocopy.exe "D:\Scott\Documents\PhD Project" "D:\Scott\Dropbox\PhD Project" /MIR 

REM "Mirror Backup to DropBox complete"

timeout 300