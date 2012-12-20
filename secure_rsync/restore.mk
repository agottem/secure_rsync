# Copyright 2012 Andrew Gottemoller.
#
# This software is a copyrighted work licensed under the terms of the
# Secure Rsync license.  Please consult the file "SR_LICENSE" for
# details.

include utils.mk
include defaults.mk


include conf.mk


data_file_restore_targets     := $(addprefix $(data_path)/,$(base_repository_file_names))
data_directory_create_targets := $(filter-out $(wildcard $(addprefix $(data_path)/,$(repository_directories))),$(addprefix $(data_path)/,$(repository_directories)))

data_file_delete_targets      := $(addprefix $(data_path)/,$(deleted_repository_files))
data_directory_delete_targets := $(addprefix $(data_path)/,$(deleted_repository_directories))


.NOTPARALLEL :


.PHONY: restore
restore :
    ifeq ($(summary_only),)
	    @$(call print,Sync server to repository...)
	    @rsync $(rsync_flags) -e "ssh -o UserKnownHostsFile=$(ssh_known_hosts_file) -i $(ssh_key_file)" $(server_name):$(remote_repository_path)/ $(repository_path)/
    endif
	@$(MAKE) -f $(firstword $(MAKEFILE_LIST)) sync_repository_to_data

.PHONY: sync_repository_to_data
sync_repository_to_data : delete_removed_repository_from_data copy_repository_to_data

.PHONY: delete_removed_repository_from_data
delete_removed_repository_from_data : $(data_file_delete_targets)
delete_removed_repository_from_data : $(call reverse_list,$(data_directory_delete_targets))

.PHONY: copy_repository_to_data
copy_repository_to_data : delete_removed_repository_from_data
copy_repository_to_data : $(data_directory_create_targets)
copy_repository_to_data : $(data_file_restore_targets)


.PHONY: $(data_file_delete_targets)
$(data_file_delete_targets) :
	@$(call print,Deleting data file: $@)
	@$(call delete_file,$@)

.PHONY: $(data_directory_delete_targets)
$(data_directory_delete_targets) :
	@$(call print,Deleting data directory: $@)
	@$(call delete_directory,$@)

$(data_directory_create_targets) :
	@$(call print,Creating data directory: $@)
	@$(call create_directory,$@)

$(data_path)/% : $(repository_path)/%.$(repository_file_extension)
	@$(call print,Restoring file: $@)
	@$(call verify_repository_file,$(encryption_password),$<)
	@$(call restore_file,$(encryption_password),$<,$@)

