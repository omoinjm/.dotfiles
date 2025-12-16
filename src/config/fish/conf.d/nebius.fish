set -gx PATH $PATH "$HOME/.nebius/bin"

if status --is-interactive
    if test -f ~/.nebius/nebius.fish
        source ~/.nebius/nebius.fish
    end
end
