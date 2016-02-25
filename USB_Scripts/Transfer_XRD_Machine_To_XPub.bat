REM #Formate of RoboCopy - robocopy "sourceDirectory" "destinationDirectory" /E

REM "XRD- Coping ALL new directories & files from XRD Public Drive to XRD Data Drive."
REM "XRD - Overwriting ALL existing XRD Data Drive files whom's source timestamps have advanced."

REM "NOTE: Open Or Locked files will NOT copy!!!"



REM "XRD Public Drive TO Data Drive Transfer"
Robocopy.exe "D:\MPD-Users\Scott Gleason" "X:\data\xrddata\xrddata\Scott Gleason" /E
Robocopy.exe "D:\MRD-Users\Scott Gleason" "X:\data\xrddata\xrddata\Scott Gleason" /E
Robocopy.exe "D:\Empyrean-Users\Scott Gleason" "X:\data\xrddata\xrddata\Scott Gleason" /E
REM "XRD Public Drive TO Data Drive Transfer complete"


timeout 300