@echo off
cls
net session >nul 2>&1
if %errorlevel% neq 0 (

    color 0C
    echo *************************************************************
    echo *                                                           *
    echo *           This program must be run as administrator!      *
    echo *                                                           *
    echo *************************************************************
    echo.
    color 0A
    echo         Press any key to request administrator permissions...
    echo.
    pause >nul

    powershell -Command "Start-Process cmd -ArgumentList '/c \"%~f0\"' -Verb RunAs"
    exit /b
)

color 0B
cls

echo *************************************************************
echo *                                                           *
echo *  This program is running with administrator permissions.  *
echo *                                                           *
echo *************************************************************
echo.

color 0A

sc.exe query licensemanager | find "STATE" | find "STOPPED" >nul
if %errorlevel% == 0 (
    echo.
    echo *************************************************************
    echo *                                                           *
    echo *     The LicenseManager service is already stopped.        *
    echo *         There is no problem to be fixed.                  *
    echo *                                                           *
    echo *************************************************************
    echo.
) else (
    echo Stopping LicenseManager service...
    sc.exe stop licensemanager
    echo.
    echo *************************************************************
    echo *                                                           *
    echo *    The LicenseManager service has been stopped.           *
    echo *   The 0xc0ea0001 error should have been fixed now!        *
    echo *                                                           *
    echo *************************************************************
    echo.
)

echo.
pause
