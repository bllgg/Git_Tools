@echo off
:: Define the remote repository (default to 'origin' if not specified)
set "remote=origin"

:: Check if a remote is passed as a parameter (optional)
if "%~1" neq "" (
    set "remote=%~1"
)

echo Pushing all local branches to remote: %remote%

:: Get a list of all local branches
for /f "tokens=*" %%i in ('git branch --format="%%(refname:short)"') do (
    setlocal enabledelayedexpansion
    set "branch=%%i"
    
    :: Push the branch to the remote repository
    echo Pushing branch: !branch!
    git push %remote% !branch!
    endlocal
)

echo Done pushing all branches.
pause
