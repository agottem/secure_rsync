@REM Copyright 2012 Andrew Gottemoller.
@REM
@REM This software is a copyrighted work licensed under the terms of the
@REM Secure Rsync license.  Please consult the file "SR_LICENSE" for
@REM details.

@echo off
setlocal enabledelayedexpansion

if not exist %6 mkdir %6

set md5_file1=%6\_backup_md5_file1.txt
set md5_file2=%6\_backup_md5_file2.txt

ssh -i %3 -o UserKnownHostsFile=%4 %5 md5 -q %2 2>NUL 1>%md5_file1%
md5 -n -l %1 2>NUL 1>%md5_file2%

for /F "delims=" %%r in (%md5_file1%) do (
    for /F "delims=" %%l in (%md5_file2%) do (
        set md5_sums_computed=1
        if "%%r" == "%%l" (
            del /F /Q %md5_file1%
            del /F /Q %md5_file2%
            exit /B 0
        )
    )
)

echo File %1 does not match the copy on the server 1>&2

del /F /Q %md5_file1%
del /F /Q %md5_file2%

exit /B 1


