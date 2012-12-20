# Copyright 2012 Andrew Gottemoller.
#
# This software is a copyrighted work licensed under the terms of the
# Secure Rsync license.  Please consult the file "SR_LICENSE" for
# details.

.PHONY: setup
setup:
	@$(MAKE) --no-print-directory -r -R -f setup.mk setup

.PHONY: set_ssh_key
set_ssh_key:
	@$(MAKE) --no-print-directory -r -R -f setup.mk set_ssh_key

.PHONY: set_password
set_password:
	@$(MAKE) --no-print-directory -r -R -f setup.mk set_password

.PHONY: backup
backup:
	@$(MAKE) --no-print-directory -r -R -f backup.mk backup

.PHONY: restore
restore:
	@$(MAKE) --no-print-directory -r -R -f restore.mk restore

.PHONY: sync_d_to_r
sync_d_to_r:
	@$(MAKE) --no-print-directory -r -R -f backup.mk sync_data_to_repository

.PHONY: sync_r_to_d
sync_r_to_d:
	@$(MAKE) --no-print-directory -r -R -f restore.mk sync_r_to_d

.PHONY: verify
verify:
	@$(MAKE) --no-print-directory --silent -r -R -f verify.mk verify

