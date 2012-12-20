# Copyright 2012 Andrew Gottemoller.
#
# This software is a copyrighted work licensed under the terms of the
# Secure Rsync license.  Please consult the file "SR_LICENSE" for
# details.

print = echo $(1)

convert_to_native_path = $(1)

input_password   = $(shell $(call convert_to_native_path,shell/sh/input_password.sh $(1)))
set_new_password = $(call convert_to_native_path,shell/sh/set_password.sh $(1) $(2))

delete_file            = $(if $(summary_only),,if [ -e $(call convert_to_native_path,$(1)) ]; then rm -f $(call convert_to_native_path,$(1));fi)
delete_directory       = $(if $(summary_only),,if [ -e $(call convert_to_native_path,$(1)) ]; then rmdir $(call convert_to_native_path,$(1));fi)
create_directory       = $(if $(summary_only),,mkdir -p $(call convert_to_native_path,$(1)))
backup_file            = $(if $(summary_only),,if [ -e $(call convert_to_native_path,$(3)) ]; then rm -f $(call convert_to_native_path,$(3)); fi; 7z a -y -p$(1) $(call convert_to_native_path,$(3) $(2)) 1>/dev/null)
restore_file           = $(if $(summary_only),,7z e -y -p$(1) $(call convert_to_native_path,$(2)) -o$(call convert_to_native_path,$(dir $(3)) $(notdir $(3))) 1>/dev/null)
verify_repository_file = $(if $(summary_only),,7z t -y -p$(1) $(call convert_to_native_path,$(2)) 1>/dev/null)
diff_local_files       = $(call convert_to_native_path,shell/sh/diff_local.sh $(1) $(2))
diff_remote_files      = $(call convert_to_native_path,shell/sh/diff_remote.sh) $(1) $(2) $(3) $(4) $(5)

gather_files       = $(sort $(shell $(call convert_to_native_path,shell/sh/build_file_list.sh $(1))))
gather_directories = $(sort $(shell $(call convert_to_native_path,shell/sh/build_directory_list.sh $(1))))

