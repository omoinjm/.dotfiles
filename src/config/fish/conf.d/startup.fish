function sys_cleanup --description 'Clean package managers and app caches'
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
    if test -d ~/.vscode-server/data/CachedExtensionVSIXs/
        echo "-> Removing VS Code VSIX cache..."
        rm -rf ~/.vscode-server/data/CachedExtensionVSIXs/*
    end

    # Delete old Claude desktop app versions dynamically
    if test -d ~/.local/share/claude/versions/
        echo "-> Removing old Claude versions..."
    end

    # Delete old agy CLI binary backup (Fish-safe Wildcard Check)
    set agy_backups ~/.local/bin/agy.*.old
    if count $agy_backups >/dev/null
        echo "-> Removing old agy CLI backup..."
        rm -f $agy_backups
    end

    echo "✨ All done!"
end
