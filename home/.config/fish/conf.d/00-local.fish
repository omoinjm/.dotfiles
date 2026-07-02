# Source machine-local conf.d snippets (secrets, SSH agent overrides, etc.)
set -l _local_conf_dir (dirname (status --current-filename))
for _local_file in secrets ssh
    set -l _local_path $_local_conf_dir/$_local_file.fish
    if test -f $_local_path
        source $_local_path
    end
end
