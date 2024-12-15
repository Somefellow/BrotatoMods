@echo off
:: List of directories to process
set directories=Lionheart-CurseEverything Lionheart-PerfectSoldierMovement Lionheart-RemoveEnemyLimit Lionheart-HungryPotato

:: Loop through each directory
for %%D in (%directories%) do (
    echo Processing %%D...

    :: Create the folder structure
    mkdir mods-unpacked\%%D

    :: Copy files to the folder structure
    xcopy "%%D\*" "mods-unpacked\%%D" /E /I

    :: Create the ZIP file
    7z a -tzip %%D.zip mods-unpacked

    :: Remove the temporary folder
    rmdir /S /Q mods-unpacked

    echo Done with %%D!
)
