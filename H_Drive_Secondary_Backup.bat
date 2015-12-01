REM #Formate of RoboCopy - robocopy "sourceDirectory" "destinationDirectory" /E

REM "Documents - Coping ALL new directories & files to the Maped Drive."
REM "Documents - Overwriting ALL existing Maped Drive files whom's source timestamps have advanced."

REM "NOTE: Open Or Locked files will NOT copy!!!"



REM "H:\ Drive Backup"
Robocopy.exe "C:\Users\Scott\Documents" "H:\Secondary Documents Backup" /E ^
/XD "C:\Users\Scott\Documents\PhD Project" "C:\Users\Scott\Documents\My Music" ^
"C:\Users\Scott\Documents\My Pictures" "C:\Users\Scott\Documents\My Videos"

REM "Secondary Backup to H:\ Drive complete"

timeout 300