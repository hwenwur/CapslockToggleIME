@echo off
echo Setting "English Switch Key" to 6 (disable Shift key switching)...

reg add "HKCU\SOFTWARE\Microsoft\InputMethod\Settings\CHS" /v "English Switch Key" /t REG_DWORD /d 6 /f

if errorlevel 1 (
    echo [ERROR] Failed to set registry value.
    pause
    exit /b 1
)

echo [OK] Done. Shift key will no longer toggle IME input mode.
pause
