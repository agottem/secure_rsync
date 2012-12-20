# Copyright 2012 Andrew Gottemoller.
#
# This software is a copyrighted work licensed under the terms of the
# Secure Rsync license.  Please consult the file "SR_LICENSE" for
# details.

print = echo $(1)

convert_to_native_path = $(subst /,\,$(1))

input_password   = $(shell $(call convert_to_native_path,shell/cmd/input_password.bat $(1)))
set_new_password = $(call convert_to_native_path,shell/cmd/set_password.bat $(1) $(2))

delete_file            = $(if $(summary_only),,if exist $(call convert_to_native_path,$(1)) del /F /Q $(call convert_to_native_path,$(1)))
delete_directory       = $(if $(summary_only),,if exist $(call convert_to_native_path,$(1)) rmdir /Q $(call convert_to_native_path,$(1)))
create_directory       = $(if $(summary_only),,mkdir $(call convert_to_native_path,$(1)))
backup_file            = $(if $(summary_only),,(if exist $(call convert_to_native_path,$(3)) (del /F /Q $(call convert_to_native_path,$(3)))) & 7z a -y -p$(1) $(call convert_to_native_path,$(3) $(2)) 1>NUL)
restore_file           = $(if $(summary_only),,7z e -y -p$(1) $(call convert_to_native_path,$(2)) -o$(call convert_to_native_path,$(dir $(3)) $(notdir $(3))) 1>NUL)
verify_repository_file = $(if $(summary_only),,7z t -y -p$(1) $(call convert_to_native_path,$(2)) 1>NUL)
diff_local_files       = $(call convert_to_native_path,shell/cmd/diff_local.bat) $(call convert_to_native_path,$(1)) $(call convert_to_native_path,$(2))
diff_remote_files      = $(call convert_to_native_path,shell/cmd/diff_remote.bat) $(1) $(2) $(3) $(4) $(5) $(call convert_to_native_path,$(6))

gather_files       = $(sort $(shell $(call convert_to_native_path,shell/cmd/build_file_list.bat $(1) $(2))))
gather_directories = $(sort $(shell $(call convert_to_native_path,shell/cmd/build_directory_list.bat $(1) $(2))))

