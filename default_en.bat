@echo off
echo Setting "Default Mode" to 1 (default to English mode)...

reg add "HKCU\Software\Microsoft\InputMethod\Settings\CHS" /v "Default Mode" /t REG_DWORD /d 1 /f

if errorlevel 1 (
    echo [ERROR] Failed to set registry value.
    pause
    exit /b 1
)

echo [OK] Done. IME will default to English input mode.
pause
