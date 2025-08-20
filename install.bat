@echo off

rem Check for admin rights
net session >nul 2>&1
if errorlevel 1 (
    rem Because Windows is absolutely stupid, we need to get admin rights to create symlinks.
    echo Requesting administrative privileges...
    powershell -Command "Start-Process '%~f0' -Verb RunAs"
    exit
)

echo Deleting old config...
del /s /q "%LOCALAPPDATA%\nvim\init.lua" >nul 2>&1

rem Make sure the directory exists, otherwise mklink will fail
echo Ensuring config directory exists...
if not exist "%LOCALAPPDATA%\nvim" mkdir "%LOCALAPPDATA%\nvim"

echo Installing new config...
mklink "%LOCALAPPDATA%\nvim\init.lua" "%~dp0\init.lua" >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo Failed to create symlink!
) else (
    echo Symlink created successfully.
)
pause

