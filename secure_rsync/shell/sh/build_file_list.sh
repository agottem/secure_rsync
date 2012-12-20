#! /bin/sh
#
# Copyright 2012 Andrew Gottemoller.
#
# This software is a copyrighted work licensed under the terms of the
# Secure Rsync license.  Please consult the file "SR_LICENSE" for
# details.

if [ ! -d "$1" ]; then
	exit
fi

cd $1

find . -type f 2>/dev/null | sed 's/ /?/g'

