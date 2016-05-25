REM #Formate of RoboCopy - robocopy "sourceDirectory" "destinationDirectory" /E

REM "USB - Coping ALL new directories & files from USB Drive."
REM "USB - Overwriting ALL existing files whom's source timestamps have advanced."

REM "NOTE: Open Or Locked files will NOT copy!!!"



REM "USB SEM, FIB, AFM, & XRD to PhD Project Transfer"
Robocopy.exe "G:\SEM" "D:\Scott\Documents\PhD Project\Results\SEM" /E
Robocopy.exe "G:\AFM" "D:\Scott\Documents\PhD Project\Results\AFM" /E
Robocopy.exe "G:\FIB" "D:\Scott\Documents\PhD Project\Results\FIB" /E
Robocopy.exe "G:\XRD" "D:\Scott\Documents\PhD Project\Results\XRD" /E
Robocopy.exe "G:\Stylus Profiler" "D:\Scott\Documents\PhD Project\Results\Stylus Profiler" /E
Robocopy.exe "G:\DSC" "D:\Scott\Documents\PhD Project\Results\DSC" /E
REM "USB SEM, FIB, AFM, DSC, & XRD to PhD Project Transfer complete"

timeout 300