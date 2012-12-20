#! /bin/sh
#
# Copyright 2012 Andrew Gottemoller.
#
# This software is a copyrighted work licensed under the terms of the
# Secure Rsync license.  Please consult the file "SR_LICENSE" for
# details.

md5_file1=`ssh -i $3 -o UserKnownHostsFile=$4 $5 md5 -q $2 2>/dev/null`
md5_file2=`md5 -q $1 2>/dev/null`

if [ "$md5_file1" != "$md5_file2" ]; then
	echo File $1 does not match the copy on the server 1>&2
	exit 1
fi

exit 0


