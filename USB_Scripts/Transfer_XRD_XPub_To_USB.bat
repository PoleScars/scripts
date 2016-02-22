REM #Formate of RoboCopy - robocopy "sourceDirectory" "destinationDirectory" /E

REM "EMU - Coping ALL new directories & files from EMU Public Drive to USB Drive."
REM "EMU - Overwriting ALL existing USB files whom's source timestamps have advanced."

REM "NOTE: Open Or Locked files will NOT copy!!!"



REM "XRD Public Drive TO USB Transfer"
Robocopy.exe "X:\data\xrddata\xrddata\Scott Gleason" "F:\XRD" /E
REM "XRD Public Drive TO USB Transfer complete"


timeout 300