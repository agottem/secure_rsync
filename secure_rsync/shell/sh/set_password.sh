#! /bin/sh
#
# Copyright 2012 Andrew Gottemoller.
#
# This software is a copyrighted work licensed under the terms of the
# Secure Rsync license.  Please consult the file "SR_LICENSE" for
# details.

echo Enter encryption password:
read input_password1

echo Verify encryption password:
read input_password2

if [ "$input_password1" != "$input_password2" ]; then
	echo Passwords do not match 1>&2
	exit 1
fi

if [ "$input_password1" == "" ]; then
	echo Passwords cannot be blank 1>&2
	exit 1
fi

if [ ! -e $2 ]; then
	mkdir -p $2
fi

echo verify_password_string > $2/pw_test_file.txt

7z a -y -p$input_password1 $1 $2/pw_test_file.txt 1>/dev/null

if [ $? -ne 0 ]; then
	echo Could not create password test file: $1 1>&2
	rm $2/pw_test_file.txt

	exit 1
fi

rm $2/pw_test_file.txt

echo Password set

exit 0

