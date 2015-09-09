REM #Formate of RoboCopy - robocopy "sourceDirectory" "destinationDirectory" /E

REM "Documents - Coping ALL new directories & files to the Maped Drive."
REM "Documents - Overwriting ALL existing Maped Drive files whom's source timestamps have advanced."

REM "NOTE: Open Or Locked files will NOT copy!!!"



REM "H:\ Drive Backup"
Robocopy.exe "C:\Users\z3492622\Documents" "H:\Secondary Documents Backup" /E /XD "C:\Users\z3492622\Documents\PhD Project"

REM "Secondary Backup to H:\ Drive complete"

timeout 300