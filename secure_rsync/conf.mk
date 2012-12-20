# Copyright 2012 Andrew Gottemoller.
#
# This software is a copyrighted work licensed under the terms of the
# Secure Rsync license.  Please consult the file "SR_LICENSE" for
# details.

ifeq ($(wildcard $(ssh_key_file)),)
    $(error SSH key files have not been setup)
endif

ifeq ($(wildcard $(pw_test_file)),)
    $(error Encryption password has not been setup)
endif

ifeq ($(encryption_password),)
    $(info Enter encryption password: )
    encryption_password := $(call input_password,$(pw_test_file))
    ifeq ($(encryption_password),)
        $(error Invalid password entered)
    endif
endif

export encryption_password

