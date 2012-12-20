@REM Copyright 2012 Andrew Gottemoller.
@REM
@REM This software is a copyrighted work licensed under the terms of the
@REM Secure Rsync license.  Please consult the file "SR_LICENSE" for
@REM details.

@echo off
setlocal enabledelayedexpansion

fc /B %1 %2 1>NUL 2>&1

if errorlevel 1 (
    echo File %1 is corrupted in the repository 1>&2
    exit /B 1
)

exit /B 0

