@REM Copyright 2012 Andrew Gottemoller.
@REM
@REM This software is a copyrighted work licensed under the terms of the
@REM Secure Rsync license.  Please consult the file "SR_LICENSE" for
@REM details.

@echo off
setlocal enabledelayedexpansion

echo Enter encryption password:
set /P input_password1=

echo Verify encryption password:
set /P input_password2=


if not "%input_password1%"=="%input_password2%" (
    echo Passwords do not match 1>&2
    exit /B 1
)

if "%input_password1%"=="" (
    echo Password cannot be blank 1>&2
    exit /B 1
)

if not exist %2 mkdir %2

echo verify_password_string > %2\pw_test_file.txt

7z a -y -p%input_password1% %1 %2\pw_test_file.txt 1>NUL

if errorlevel 1 (
    echo Could not create password test file: %1 1>&2
    del %2\pw_test_file.txt 1>NUL
    exit /B 1
)

del %2\pw_test_file.txt 1>NUL

echo Password set

exit /B 0

