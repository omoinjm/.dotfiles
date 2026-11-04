function cpwd --description 'Copy the current directory to the clipboard, with $HOME as ~'
    string replace -r "^$HOME" '~' -- $PWD | fish_clipboard_copy
end
