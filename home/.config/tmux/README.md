# tmux config

This directory holds the tmux config (`tmux.conf` + the `*.conf` files it
sources) and the tpm-managed plugins in `plugins/`.

## tmux basics

tmux is a terminal multiplexer: one terminal window hosts multiple
**sessions**, each session holds multiple **windows** (like tabs), and each
window can be split into multiple **panes**. Everything is driven by a
**prefix** key chord — press the prefix, release it, then press the command
key.

Common vanilla commands (run from a shell, not inside tmux):

| Command                        | Action                              |
| ------------------------------- | ------------------------------------ |
| `tmux new -s <name>`           | start a new named session            |
| `tmux attach -t <name>`        | attach to an existing session        |
| `tmux ls`                      | list sessions                        |
| `tmux kill-session -t <name>`  | kill a session                       |

Inside a session, `prefix` + `d` detaches (leaves it running in the
background) — this config doesn't remap that one.

## Prefix key

**This config remaps the prefix from the tmux default `C-b` to `C-t`**
(`tmux.conf:14`). Every binding below is `C-t` then the key shown.

## Custom key bindings

Set directly in `tmux.conf` / `utility.conf`:

| Key              | Action                                                    |
| ---------------- | ---------------------------------------------------------- |
| `prefix` + `r`   | reload `tmux.conf`                                         |
| `prefix` + `o`   | open the current pane's directory (macOS `open`)           |
| `prefix` + `e`   | kill every pane except the current one                     |
| `prefix` + `g`   | open [lazygit](https://github.com/jesseduffield/lazygit) in a popup, rooted at the current pane's path |
| `C-S-Left`       | swap the current window one to the left, then select it (no prefix) |
| `C-S-Right`      | swap the current window one to the right, then select it (no prefix) |

`mode-keys` is set to `vi`, so copy mode (`prefix` + `[`) uses vi-style
movement and `v`/`y` to select/copy.

### Pane & window bindings (from the `tmux-pain-control` plugin)

| Key                    | Action                                    |
| ------------------------ | ------------------------------------------ |
| `prefix` + `h`/`j`/`k`/`l` (or `C-h`/`C-j`/`C-k`/`C-l`) | move to the pane left/below/above/right |
| `prefix` + `H`/`J`/`K`/`L` | resize the current pane in that direction |
| `prefix` + `\|`         | split horizontally (left/right)           |
| `prefix` + `-`          | split vertically (top/bottom)             |
| `prefix` + `\`          | split horizontally, full window width     |
| `prefix` + `_`          | split vertically, full window height      |
| `prefix` + `c`          | new window, opened in the current pane's path |
| `prefix` + `<` / `>`    | swap the current window with the previous/next one |

## Plugins

Managed by [tpm](https://github.com/tmux-plugins/tpm) — install/update with
`prefix` + `I`, and plugins load automatically on tmux startup
(`tmux.conf:96-99`).

- **[tmux-pain-control](https://github.com/tmux-plugins/tmux-pain-control)**
  — the pane/window bindings above.
- **[tmux-claude-session-manager](https://github.com/craftzdog/tmux-claude-session-manager)**
  by [Takuya Matsuyama (craftzdog)](https://github.com/craftzdog) — lists,
  monitors, and jumps between running Claude Code sessions. See below.

### tmux-claude-session-manager

Run many Claude Code sessions across projects — each in its own tmux
session — then list them, see which are done vs. still working, and jump to
one from a single popup.

| Key            | Action                                                                          |
| -------------- | -------------------------------------------------------------------------------- |
| `prefix` + `y` | launch (or re-attach to) a Claude session for the current directory, in a popup  |
| `prefix` + `u` | open the agent picker                                                            |

Inside the picker (plain fzf — this config doesn't set `@claude_fzf_options`):

| Key                       | Action                                       |
| ------------------------- | --------------------------------------------- |
| `↑` / `↓` (or `ctrl-p`/`ctrl-n`) | move the selection                     |
| type any text             | fuzzy-filter the list                        |
| `enter`                   | jump to the highlighted agent                 |
| `ctrl-x`                  | kill the highlighted agent                    |

On `enter`, a **loose** agent (Claude running in an ordinary pane) gets
focused in place; a **dedicated** one (launched with `prefix` + `y`, living
in its own `claude-*` session) resumes in a popup over the window it was
launched from.

Full docs, including live status (`working`/`waiting`/`idle`), the vim-style
`j`/`k` nav mode via `@claude_fzf_options`, and all `@claude_*` options:
`plugins/tmux-claude-session-manager/README.md`.
