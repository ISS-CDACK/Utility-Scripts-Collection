@echo off

:: Enable ANSI colors (works on modern Windows systems)
:: Note: For older versions, colors may not work as intended.
echo.

:: Define colors
set "color_success=0A"  :: Green text
set "color_warning=0E"  :: Yellow text
set "color_error=0C"    :: Red text

:: Check for administrative privileges
net session >nul 2>&1
if %errorlevel% neq 0 (
    color %color_error%
    echo ===========================================================
    echo [ERROR] This script requires administrative privileges.
    echo        Please right-click and select "Run as administrator."
    echo ===========================================================
    pause
    exit /b
)

:: Change to success color
color %color_success%
echo ===========================================================
echo [INFO] Admin privileges verified. Proceeding with renaming...
echo ===========================================================

:: Rename the Administrator account
wmic useraccount where Name="Administrator" rename "DisabledAccount1" >nul 2>&1
if %errorlevel% equ 0 (
    echo [SUCCESS] Administrator account renamed to "DisabledAccount1".
) else (
    color %color_error%
    echo [ERROR] Failed to rename Administrator account.
)

:: Rename the Guest account
wmic useraccount where Name="Guest" rename "DisabledAccount2" >nul 2>&1
if %errorlevel% equ 0 (
    color %color_success%
    echo [SUCCESS] Guest account renamed to "DisabledAccount2".
) else (
    color %color_error%
    echo [ERROR] Failed to rename Guest account.
)

:: Final message
color %color_success%
echo ===========================================================
echo [INFO] Operation completed. Press Enter to close the command prompt.
echo ===========================================================
pause >nul
