# Rust toolchain in XDG data dirs instead of ~/.cargo and ~/.rustup.
# (rustup's generated env.fish hardcodes ~/.cargo/bin, so PATH is set here.)
set -gx CARGO_HOME "$HOME/.local/share/cargo"
set -gx RUSTUP_HOME "$HOME/.local/share/rustup"
fish_add_path --path --move "$CARGO_HOME/bin"
