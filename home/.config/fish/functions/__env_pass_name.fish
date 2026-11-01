function __env_pass_name --description "Map a .env filename to a pass entry name (.env.local -> env.local)"
    string replace -r '^\.' '' -- (basename $argv[1])
end
