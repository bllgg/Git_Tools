@echo off
:: Fetch all branches from remote
echo Fetching all branches from remote...
git fetch --all

:: List all remote branches and handle them in a loop
echo Listing all remote branches...
for /f "tokens=*" %%i in ('git branch -r') do (
    setlocal enabledelayedexpansion
    set "branch=%%i"
    
    :: Skip symbolic references like 'origin/HEAD -> origin/main'
    echo !branch! | findstr "HEAD" >nul
    if errorlevel 1 (
        :: Remove the 'origin/' prefix from the branch name
        set "localBranch=!branch:origin/=!"

        :: Check if the local branch already exists
        git rev-parse --verify !localBranch! >nul 2>&1
        if errorlevel 1 (
            :: If the branch doesn't exist locally, check it out
            echo Checking out branch: !localBranch!
            git checkout -b !localBranch! origin/!localBranch!
        ) else (
            :: If the branch exists, skip it
            echo Branch !localBranch! already exists locally, skipping...
        )
    )
    endlocal
)

echo Done fetching all branches.
pause
