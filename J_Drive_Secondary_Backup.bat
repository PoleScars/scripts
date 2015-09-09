REM #Formate of RoboCopy - robocopy "sourceDirectory" "destinationDirectory" /E

REM "Documents - Coping ALL new directories & files to the Maped Drive."
REM "Documents - Overwriting ALL existing Maped Drive files whom's source timestamps have advanced."

REM "NOTE: Open Or Locked files will NOT copy!!!"



REM "J:\ Drive Backup"
Robocopy.exe "C:\Users\z3492622\Documents" "J:\POSTGRADS\Scott Gleason\Secondary Documents Backup" /E ^
/XD "C:\Users\z3492622\Documents\PhD Project" "C:\Users\z3492622\Documents\My Music" ^
"C:\Users\z3492622\Documents\My Pictures" "C:\Users\z3492622\Documents\My Videos"

REM "Secondary Backup to J:\ Drive complete"

timeout 300