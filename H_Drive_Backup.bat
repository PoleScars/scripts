REM #Formate of RoboCopy - robocopy "sourceDirectory" "destinationDirectory" /E

REM "PhD Project - Coping ALL new directories & files to the Maped Drive."
REM "PhD Project - Overwriting ALL existing Maped Drive files whom's source timestamps have advanced."

REM "NOTE: Open Or Locked files will NOT copy!!!"



REM "H:\ Drive Backup"
Robocopy.exe "C:\Users\z3492622\Documents\PhD Project" "H:\Master PhD Backup" /E

REM "Backup to H:\ Drive complete"

timeout 300