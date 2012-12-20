# Copyright 2012 Andrew Gottemoller.
#
# This software is a copyrighted work licensed under the terms of the
# Secure Rsync license.  Please consult the file "SR_LICENSE" for
# details.

include utils.mk
include defaults.mk


setup_directories := $(sort $(dir $(pw_test_file)) $(dir $(ssh_key_file)) $(dir $(ssh_known_hosts_file)) $(repository_path) $(data_path))


.NOTPARALLEL :


.PHONY: setup
setup : set_password set_ssh_key


.PHONY: set_ssh_key
set_ssh_key : $(setup_directories)
	@$(call print,Setting up SSH key: $(ssh_key_file)...)
	@ssh-keygen -f $(ssh_key_file) -t rsa -N ''
	@rsync -av -e "ssh -o UserKnownHostsFile=$(ssh_known_hosts_file)" $(ssh_key_file).pub $(server_name):.ssh/authorized_keys

.PHONY: set_password
set_password : $(setup_directories)
	@$(call print,Setting new encryption password...)
	@$(call set_new_password,$(pw_test_file),$(temp_file_path))


$(setup_directories) :
	@$(call create_directory,$@)


