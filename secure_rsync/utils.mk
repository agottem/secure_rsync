# Copyright 2012 Andrew Gottemoller.
#
# This software is a copyrighted work licensed under the terms of the
# Secure Rsync license.  Please consult the file "SR_LICENSE" for
# details.

reverse_list = $(if $(1),$(call reverse_list,$(wordlist 2,$(words $(1)),$(1)))) $(firstword $(1))


ifeq ($(SHELL), cmd.exe)
    include shell/cmd/shell.mk
else ifeq ($(SHELL), /bin/sh)
    include shell/sh/shell.mk
else
    $(error Unrecognized shell '$(SHELL)', aborting)
endif

