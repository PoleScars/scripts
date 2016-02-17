REM #Formate of RoboCopy - robocopy "sourceDirectory" "destinationDirectory" /E

REM "EMU - Coping ALL new directories & files from EMU Public Drive to USB Drive."
REM "EMU - Overwriting ALL existing USB files whom's source timestamps have advanced."

REM "NOTE: Open Or Locked files will NOT copy!!!"



REM "EMU s3400-I to EMU Public Drive Transfer"
Robocopy.exe "M:\emuimages\s3400-I\z3492622" "M:\emupublic\z3492622-SG" /E
REM "EMU s3400-I to EMU Public Drive Transfer complete"


REM "EMU Public Drive to USB Transfer"
Robocopy.exe "M:\emupublic\z3492622-SG" "F:\SEM" /E ^
/XD "M:\emupublic\z3492622-SG\Old Data"

REM "EMU Public Drive to USB Transfer complete"

timeout 300