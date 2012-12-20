# Copyright 2012 Andrew Gottemoller.
#
# This software is a copyrighted work licensed under the terms of the
# Secure Rsync license.  Please consult the file "SR_LICENSE" for
# details.

# Path containing data to be backed up
data_path := ../data

# Path to store encrypted mirror of the data path
repository_path        := ../repository
remote_repository_path := repository

# Server name to SSH into
server_name := user@srv1.rsync.net

pw_test_file         := conf/pw_test.zip
ssh_key_file         := conf/ssh_rsa.key
ssh_known_hosts_file := conf/known_hosts
temp_file_path       := ../.backup_verify_temp

repository_file_extension := zip

rsync_flags = -vrtW --delete-after --progress
ifneq ($(summary_only),)
    rsync_flags += --dry-run
endif


$(info Collecting file info...)

data_files       := $(call gather_files,$(data_path),$(temp_file_path))
data_directories := $(call gather_directories,$(data_path),$(temp_file_path))

ifneq ($(findstring ?,$(data_files) $(data_directories)),)
    $(error Found path containing spaces, aborting...)
endif


repository_files           := $(call gather_files,$(repository_path),$(temp_file_path))
base_repository_file_names := $(patsubst %.$(repository_file_extension),%,$(repository_files))
repository_directories     := $(call gather_directories,$(repository_path),$(temp_file_path))

deleted_data_files       := $(filter-out $(data_files),$(base_repository_file_names))
deleted_data_directories := $(filter-out $(data_directories),$(repository_directories))

deleted_repository_files       := $(filter-out $(base_repository_file_names),$(data_files))
deleted_repository_directories := $(filter-out $(repository_directories),$(data_directories))

