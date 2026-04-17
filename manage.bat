@echo off
setlocal EnableDelayedExpansion

set "SCRIPT_DIR=%~dp0"
set "AHK_FILE=%SCRIPT_DIR%CapslockToggleIME.ahk"
set "REG_KEY=HKCU\Software\Microsoft\Windows\CurrentVersion\Run"
set "REG_NAME=CapslockToggleIME"

:: Locate AutoHotkey v2 executable
set "AHK_EXE="
if exist "%ProgramFiles%\AutoHotkey\v2\AutoHotkey64.exe"    set "AHK_EXE=%ProgramFiles%\AutoHotkey\v2\AutoHotkey64.exe"
if exist "%ProgramFiles%\AutoHotkey\v2\AutoHotkey32.exe"    if not defined AHK_EXE set "AHK_EXE=%ProgramFiles%\AutoHotkey\v2\AutoHotkey32.exe"
if exist "%ProgramFiles%\AutoHotkey\AutoHotkey.exe"         if not defined AHK_EXE set "AHK_EXE=%ProgramFiles%\AutoHotkey\AutoHotkey.exe"
if exist "%ProgramFiles(x86)%\AutoHotkey\v2\AutoHotkey64.exe" if not defined AHK_EXE set "AHK_EXE=%ProgramFiles(x86)%\AutoHotkey\v2\AutoHotkey64.exe"
if exist "%ProgramFiles(x86)%\AutoHotkey\AutoHotkey.exe"    if not defined AHK_EXE set "AHK_EXE=%ProgramFiles(x86)%\AutoHotkey\AutoHotkey.exe"

if not defined AHK_EXE (
    for /f "delims=" %%F in ('where AutoHotkey.exe 2^>nul') do if not defined AHK_EXE set "AHK_EXE=%%F"
)

if not defined AHK_EXE (
    echo [ERROR] AutoHotkey v2 not found. Please install from https://www.autohotkey.com/
    pause
    exit /b 1
)

if not exist "%AHK_FILE%" (
    echo [ERROR] Script not found: %AHK_FILE%
    pause
    exit /b 1
)

:MENU
cls
echo ============================================
echo   CapsLock Toggle IME - Manager
echo ============================================
echo.

set "STATUS=Disabled"
for /f "tokens=*" %%V in ('reg query "%REG_KEY%" /v "%REG_NAME%" 2^>nul') do set "STATUS=Enabled"
echo   Boot startup: [!STATUS!]
echo.
echo   1. Start now
echo   2. Start now + Enable at boot
echo   3. Enable at boot
echo   4. Disable at boot
echo   0. Exit
echo.
set /p "CHOICE=  Choose [0-4]: "

if "!CHOICE!"=="1" goto DO_START
if "!CHOICE!"=="2" goto DO_START_AND_ENABLE
if "!CHOICE!"=="3" goto DO_ENABLE
if "!CHOICE!"=="4" goto DO_DISABLE
if "!CHOICE!"=="0" exit /b 0

echo   [!] Invalid choice.
timeout /t 1 >nul
goto MENU

:DO_START
call :START_AHK
goto END

:DO_START_AND_ENABLE
call :START_AHK
call :ENABLE_BOOT
goto END

:DO_ENABLE
call :ENABLE_BOOT
goto END

:DO_DISABLE
call :DISABLE_BOOT
goto END

:START_AHK
    taskkill /f /im AutoHotkey*.exe >nul 2>&1
    timeout /t 1 >nul
    start "" "%AHK_EXE%" "%AHK_FILE%"
    echo   [OK] Started: CapslockToggleIME.ahk
    exit /b 0

:ENABLE_BOOT
    reg add "%REG_KEY%" /v "%REG_NAME%" /t REG_SZ /d "\"%AHK_EXE%\" \"%AHK_FILE%\"" /f >nul
    echo   [OK] Enabled: will start automatically at boot.
    exit /b 0

:DISABLE_BOOT
    reg query "%REG_KEY%" /v "%REG_NAME%" >nul 2>&1
    if errorlevel 1 (
        echo   [--] Was not enabled, nothing to do.
    ) else (
        reg delete "%REG_KEY%" /v "%REG_NAME%" /f >nul
        echo   [OK] Disabled: will no longer start at boot.
    )
    exit /b 0

:END
echo.
pause
goto MENU
