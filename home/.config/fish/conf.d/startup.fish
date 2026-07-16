function sys_cleanup --description 'Clean package managers and app caches'
    set -l cleanup_state (dirname (status --current-filename))/../.last_cleanup_date

    echo "🧹 Starting system cleanup..."

    # Clear npm cache
    if type -q npm
        echo "-> Clearing npm cache..."
        npm cache clean --force
    end

    # Clear NuGet cache
    if type -q dotnet
        echo "-> Clearing NuGet cache..."
        dotnet nuget locals all --clear
    end

    # Clear Yarn cache
    if type -q yarn
        echo "-> Clearing Yarn cache..."
        yarn cache clean
    end

    # Prune pnpm global store
    if type -q pnpm
        echo "-> Pruning pnpm store..."
        pnpm store prune
    end

    # Delete VS Code VSIX cache safely
    # if test -d ~/.vscode-server/data/CachedExtensionVSIXs/
    #     echo "-> Removing VS Code VSIX cache..."
    #     rm -rf ~/.vscode-server/data/CachedExtensionVSIXs/*
    # end

    # Delete old Claude desktop app versions, keeping the newest
    if test -d ~/.local/share/claude/versions/
        set -l versions (ls -t ~/.local/share/claude/versions/)
        if test (count $versions) -gt 1
            echo "-> Removing old Claude versions..."
            for v in $versions[2..-1]
                rm -rf ~/.local/share/claude/versions/$v
            end
        end
    end

    # Delete old agy CLI binary backups
    set -l removed_agy false
    for f in ~/.local/bin/agy.*.old
        if test -f $f
            if test $removed_agy = false
                echo "-> Removing old agy CLI backup..."
                set removed_agy true
            end
            rm -f $f
        end
    end

    mkdir -p (dirname $cleanup_state)
    date +%Y-%m-%d >$cleanup_state
    echo "✨ All done!"
end

function sys_cleanup_due --description 'Run sys_cleanup if it has not run today'
    set -l cleanup_state (dirname (status --current-filename))/../.last_cleanup_date
    set -l today (date +%Y-%m-%d)

    if test -f $cleanup_state; and test (cat $cleanup_state) = $today
        return 1
    end

    nvm use 24
    sys_cleanup
end
