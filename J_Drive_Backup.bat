REM #Formate of RoboCopy - robocopy "sourceDirectory" "destinationDirectory" /E

REM "PhD Project - Coping ALL new directories & files to the Maped Drive."
REM "PhD Project - Overwriting ALL existing Maped Drive files whom's source timestamps have advanced."

REM "NOTE: Open Or Locked files will NOT copy!!!"



REM "J:\ Drive Backup"
Robocopy.exe "C:\Users\Scott\Documents\PhD Project" "infpwfs405.ad.unsw.edu\MATS\POSTGRADS\Scott Gleason\Master PhD Backup" /E ^
/XD "C:\Users\Scott\Documents\PhD Project\University of Queensland"

REM "Backup to J:\ Drive complete"

timeout 300