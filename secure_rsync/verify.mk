# Copyright 2012 Andrew Gottemoller.
#
# This software is a copyrighted work licensed under the terms of the
# Secure Rsync license.  Please consult the file "SR_LICENSE" for
# details.

include utils.mk
include defaults.mk


include conf.mk


override summary_only :=

verify_file_targets                  := $(addsuffix .$(repository_file_extension),$(addprefix $(repository_path)/,$(data_files)))
missing_repository_directory_targets := $(filter-out $(wildcard $(addprefix $(repository_path)/,$(data_directories))),$(addprefix $(repository_path)/,$(data_directories)))

extra_repository_file_targets      := $(addsuffix .$(repository_file_extension),$(addprefix $(repository_path)/,$(deleted_data_files)))
extra_repository_directory_targets := $(addprefix $(repository_path)/,$(deleted_data_directories))


.NOTPARALLEL :


.PHONY: verify
verify : print_mismatched_items verify_files

.PHONY: print_mismatched_items
print_mismatched_items : $(missing_repository_file_targets)
print_mismatched_items : $(missing_repository_directory_targets)
print_mismatched_items : $(extra_repository_file_targets)
print_mismatched_items : $(extra_repository_directory_targets)

.PHONY: verify_files
verify_files : $(temp_file_path) $(verify_file_targets)


.PHONY: $(missing_repository_file_targets)
$(missing_repository_file_targets) :
	@$(call print,Repository is missing file: $@)

.PHONY: $(missing_repository_directory_targets)
$(missing_repository_directory_targets) :
	@$(call print,Repository is missing directory: $@)

.PHONY: $(extra_repository_file_targets)
$(extra_repository_file_targets) :
	@$(call print,Repository contains file not in data: $@)

.PHONY: $(extra_repository_directory_targets)
$(extra_repository_directory_targets) :
	@$(call print,Repository contains directory not in data: $@)

$(verify_file_targets) : force_make

$(repository_path)/%.$(repository_file_extension) : $(data_path)/%
	@-$(call verify_repository_file,$(encryption_password),$@)
	@-$(call restore_file,$(encryption_password),$@,$(temp_file_path)/$(notdir $*))
	@-$(call diff_local_files,$(data_path)/$*,$(temp_file_path)/$(notdir $*))
	@-$(call delete_file,$(temp_file_path)/$(notdir $*))
	@-$(call diff_remote_files,$@,$(remote_repository_path)/$*.$(repository_file_extension),$(ssh_key_file),$(ssh_known_hosts_file),$(server_name),$(temp_file_path))

$(temp_file_path) :
	$(call create_directory,$@)


.PHONY: force_make
force_make : ;

