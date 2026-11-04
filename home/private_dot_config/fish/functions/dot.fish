function dot --wraps chezmoi --description 'chezmoi for the dotfiles repo (plain `chezmoi` is machine-snapshot)'
    chezmoi --config ~/.config/chezmoi-dotfiles/chezmoi.toml $argv
end
