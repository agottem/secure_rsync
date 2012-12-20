# Copyright 2012 Andrew Gottemoller.
#
# This software is a copyrighted work licensed under the terms of the
# Secure Rsync license.  Please consult the file "SR_LICENSE" for
# details.

include utils.mk
include defaults.mk


include conf.mk


repository_file_backup_targets      := $(addsuffix .$(repository_file_extension),$(addprefix $(repository_path)/,$(data_files)))
repository_directory_create_targets := $(filter-out $(wildcard $(addprefix $(repository_path)/,$(data_directories))),$(addprefix $(repository_path)/,$(data_directories)))

repository_file_delete_targets      := $(addsuffix .$(repository_file_extension),$(addprefix $(repository_path)/,$(deleted_data_files)))
repository_directory_delete_targets := $(addprefix $(repository_path)/,$(deleted_data_directories))


.NOTPARALLEL :


.PHONY: backup
backup : sync_data_to_repository
    ifeq ($(summary_only),)
	    @$(call print,Sync repository to server...)
	    @rsync $(rsync_flags) -e "ssh -o UserKnownHostsFile=$(ssh_known_hosts_file) -i $(ssh_key_file)" $(repository_path)/ $(server_name):$(remote_repository_path)/
    endif

.PHONY: sync_data_to_repository
sync_data_to_repository : delete_removed_data_from_repository copy_data_to_repository

.PHONY: delete_removed_data_from_repository
delete_removed_data_from_repository : $(repository_file_delete_targets)
delete_removed_data_from_repository : $(call reverse_list,$(repository_directory_delete_targets))

.PHONY: copy_data_to_repository
copy_data_to_repository : delete_removed_data_from_repository
copy_data_to_repository : $(repository_directory_create_targets)
copy_data_to_repository : $(repository_file_backup_targets)


.PHONY: $(repository_file_delete_targets)
$(repository_file_delete_targets) :
	@$(call print,Deleting repository file: $@)
	@$(call delete_file,$@)

.PHONY: $(repository_directory_delete_targets)
$(repository_directory_delete_targets) :
	@$(call print,Deleting repository directory: $@)
	@$(call delete_directory,$@)

$(repository_directory_create_targets) :
	@$(call print,Creating repository directory: $@)
	@$(call create_directory,$@)

$(repository_path)/%.$(repository_file_extension) : $(data_path)/%
	@$(call print,Backing up file: $<)
	@$(call backup_file,$(encryption_password),$<,$@)
	@$(call verify_repository_file,$(encryption_password),$@)

