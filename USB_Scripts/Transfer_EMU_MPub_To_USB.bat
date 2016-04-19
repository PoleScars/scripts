REM #Formate of RoboCopy - robocopy "sourceDirectory" "destinationDirectory" /E

REM "EMU - Coping ALL new directories & files from EMU Public Drive to USB Drive."
REM "EMU - Overwriting ALL existing USB files whom's source timestamps have advanced."

REM "NOTE: Open Or Locked files will NOT copy!!!"



REM "EMU s3400-I & X to EMU Public Drive Transfer"
Robocopy.exe "M:\emuimages\s3400-I\z3492622" "M:\emupublic\z3492622-SG\SEM" /E
Robocopy.exe "M:\emuimages\s3400-X\z3492622_SG" "M:\emupublic\z3492622-SG\SEM" /E
REM "EMU s3400-I & X to EMU Public Drive Transfer complete"

REM "EMU SEM230 to EMU Public Drive Transfer"
Robocopy.exe "M:\emuimages\sem230\Scott Gleason" "M:\emupublic\z3492622-SG\SEM" /E
REM "EMU SEM230 to EMU Public Drive Transfer complete"

REM "EMU SEM450 to EMU Public Drive Transfer"
Robocopy.exe "M:\emuimages\sem450\z3492622" "M:\emupublic\z3492622-SG\SEM" /E
REM "EMU SEM450 to EMU Public Drive Transfer complete"

REM "EMU AFM to EMU Public Drive Transfer"
Robocopy.exe "M:\emuimages\afm\z3492622" "M:\emupublic\z3492622-SG\AFM\archive" /E
REM "EMU AFM to EMU Public Drive Transfer complete"



REM "EMU Public Drive to USB Transfer"
Robocopy.exe "M:\emupublic\z3492622-SG\SEM" "F:\SEM" /E 
Robocopy.exe "M:\emupublic\z3492622-SG\AFM" "F:\AFM" /E
Robocopy.exe "M:\emupublic\z3492622-SG\FIB" "F:\FIB" /E

REM "EMU Public Drive to USB Transfer complete"

timeout 300