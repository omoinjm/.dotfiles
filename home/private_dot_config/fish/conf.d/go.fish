set -gx GOPATH "$HOME/.local/share/go"
set -gx PATH $GOPATH/bin $PATH

# Go toolchain from the official tarball (/usr/local/go)
test -d /usr/local/go/bin; and fish_add_path --path /usr/local/go/bin
