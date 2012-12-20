#! /bin/sh
#
# Copyright 2012 Andrew Gottemoller.
#
# This software is a copyrighted work licensed under the terms of the
# Secure Rsync license.  Please consult the file "SR_LICENSE" for
# details.

read input_password

7z t -y -p$input_password $1 1>/dev/null 2>&1

if [ $? -eq 0 ]; then
	echo $input_password
fi

exit 0

