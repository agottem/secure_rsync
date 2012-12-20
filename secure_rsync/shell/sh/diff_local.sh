#! /bin/sh
#
# Copyright 2012 Andrew Gottemoller.
#
# This software is a copyrighted work licensed under the terms of the
# Secure Rsync license.  Please consult the file "SR_LICENSE" for
# details.

diff -q $1 $2 >/dev/null 2>&1
if [ $? -eq 0 ]; then
	exit 0
fi

echo File $1 is corrupted in the repository 1>&2
exit 1

