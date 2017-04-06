REM #Formate of RoboCopy - robocopy "sourceDirectory" "destinationDirectory" /E

REM "DSC - Coping ALL new directories & files from DSC Drive to USB Drive."
REM "DSC - Overwriting ALL existing USB files whom's source timestamps have advanced."

REM "NOTE: Open Or Locked files will NOT copy!!!"



REM "DSC Drive TO USB Transfer"
Robocopy.exe "C:\Users\dsc\Desktop\Scott" "G:\DSC" /E
REM "DSC Drive TO USB Transfer complete"


timeout 300