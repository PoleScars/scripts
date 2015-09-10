REM #Formate of RoboCopy - robocopy "sourceDirectory" "destinationDirectory" /E

REM "USB - Coping ALL new directories & files from to USB Drive."
REM "USB - Overwriting ALL existing files whom's source timestamps have advanced."

REM "NOTE: Open Or Locked files will NOT copy!!!"



REM "USB SEM & XRD to PhD Project Transfer"
Robocopy.exe "E:\SEM" "C:\Users\z3492622\Documents\PhD Project\Results\SEM" /E
Robocopy.exe "E:\XRD" "C:\Users\z3492622\Documents\PhD Project\Results\XRD" /E
REM "USB SEM & XRD to PhD Project Transfer complete"

timeout 300