@echo off
:: if you're not on windows, just pull these two lines off. The file is in .gitignore so it won't update.

:: allow the set command to work...
SETLOCAL ENABLEDELAYEDEXPANSION

:: grab current known upstream commit (to be used for diffing at end)
FOR /F %%i IN ('git rev-parse upstream/main') DO SET oldupstream=%%i

:: fetch upstream, switch to it, and check status
git fetch upstream
git branch -u upstream/main -q
git status
git branch -u origin/main -q

echo.
echo.

:: a chance to hit ctrl+c
echo Press ctrl+c to not see names of changed files
pause

echo.
echo.
echo.
echo.

:: now show the changes
git diff-tree -r %oldupstream%..upstream/main --pretty=format: --name-only

echo.
echo.

:: a chance to hit ctrl+c
echo Press ctrl+c to not see diff
pause

echo.
echo.
echo.
echo.

::now show a diff
git diff %oldupstream%...upstream/main