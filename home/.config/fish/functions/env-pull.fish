function env-pull --description "Restore a .env file from pass: env-pull [-f] [project|.] [file=.env]"
    argparse f/force -- $argv; or return 1
    __env_check; or return 1
    set -l project (__env_project $argv[1])
    set -l file .env
    test -n "$argv[2]"; and set file $argv[2]
    set -l entry projects/$project/(__env_pass_name $file)

    pass git pull --rebase --quiet; or echo "env-pull: git pull failed, using local store" >&2

    set -l tmp (mktemp (dirname $file)/.env-pull.XXXXXX); or return 1
    chmod 600 $tmp
    set -l dir $HOME/.password-store
    set -q PASSWORD_STORE_DIR; and set dir $PASSWORD_STORE_DIR
    if not test -f $dir/$entry.gpg
        rm -f $tmp
        echo "env-pull: '$entry' not found (try: env-ls $project)" >&2
        return 1
    end
    if not pass show $entry >$tmp
        rm -f $tmp
        echo "env-pull: could not decrypt '$entry' (passphrase prompt failed? check GPG_TTY / gpg-agent)" >&2
        return 1
    end

    if test -f $file
        if cmp -s $tmp $file
            rm -f $tmp
            echo "$file is already up to date"
            return 0
        end
        if not set -q _flag_force
            diff -u $file $tmp | string replace -r '^([ +-](?:export\s+)?[A-Za-z_][A-Za-z0-9_]*\s*=).*' '$1***'
            read -l -P "Overwrite $file with $entry? [y/N] " answer
            if not string match -qi y -- $answer
                rm -f $tmp
                echo "Aborted"
                return 1
            end
        end
    end
    mv $tmp $file
    chmod 600 $file
    echo "Restored $entry -> $file"
end
