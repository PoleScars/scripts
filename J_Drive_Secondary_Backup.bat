REM #Formate of RoboCopy - robocopy "sourceDirectory" "destinationDirectory" /E

REM "Documents - Coping ALL new directories & files to the Maped Drive."
REM "Documents - Overwriting ALL existing Maped Drive files whom's source timestamps have advanced."

REM "NOTE: Open Or Locked files will NOT copy!!!"



REM "J:\ Drive Backup"
Robocopy.exe "D:\Scott\Documents" "J:\Scott Gleason\Secondary Documents Backup" /E ^
/XD "D:\Scott\Documents\PhD Project" "D:\Scott\Documents\My Music" ^
"D:\Scott\Documents\My Pictures" "D:\Scott\Documents\My Videos" ^
"D:\Scott\Documents\MEGA"

REM "Secondary Backup to J:\ Drive complete"

timeout 300