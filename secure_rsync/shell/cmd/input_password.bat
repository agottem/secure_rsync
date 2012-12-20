@REM Copyright 2012 Andrew Gottemoller.
@REM
@REM This software is a copyrighted work licensed under the terms of the
@REM Secure Rsync license.  Please consult the file "SR_LICENSE" for
@REM details.

@echo off
setlocal enabledelayedexpansion

set /P input_password=

7z t -y -p%input_password% %1 >NUL

if errorlevel 1 (
    echo.
) else (
    echo %input_password%
)

exit /B 0

