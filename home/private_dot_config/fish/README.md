# fish config

Personal [fish](https://fishshell.com/) shell config: aliases, PATH/tooling
setup, a themed prompt, and a handful of fzf-driven shortcuts.

## Setup

1. Install fish and set it as your login shell.
2. Apply the dotfiles (`install/link.sh` at the repo root). chezmoi links
   these files into `~/.config/fish/` and then runs `fisher update`, which
   installs [fisher](https://github.com/jorgebucaran/fisher) and the plugins
   listed in `fish_plugins` (plugin files are not tracked in the repo):
   - [`bass`](https://github.com/edc/bass) — run bash scripts/source `.sh`
     files from fish.
   - [`z`](https://github.com/jethrokuan/z) — jump to frecently-used
     directories.
   - [`fzf.fish`](https://github.com/PatrickF1/fzf.fish) — fzf-powered
     history/directory/git search bindings.
3. Install [oh-my-posh](https://ohmyposh.dev/) — `config.fish` initializes it
   with the local `~/.config/oh-my-posh/bubblesextra.omp.json` theme.
4. Optional, auto-detected if present (config degrades gracefully without
   them): `nvim` (aliases `vim`/`vi`), [`eza`](https://github.com/eza-community/eza)
   or [`lsd`](https://github.com/lsd-rs/lsd) or `colorls` (nicer `ls`/`tree`),
   `bat` (fzf file previews, macOS), [`nvm`](https://github.com/nvm-sh/nvm),
   `bun`, `go`, `dotnet`, `pnpm`.

### Machine-local files (gitignored, not in this repo)

These are created per-machine and read if present — see `.gitignore`:

| File                        | Purpose                                    |
| ---------------------------- | ------------------------------------------- |
| `config-local.fish`         | machine-specific overrides, sourced last    |
| `conf.d/secrets.fish`       | secrets exported as env vars                |
| `conf.d/ssh.fish`           | local SSH agent socket/PID                  |
| `fish_variables`            | fish's own persisted universal variables    |

## Structure

- `config.fish` — entry point: greeting off, aliases, `EDITOR`/`PATH`, oh-my-posh
  init, then sources the OS-specific file (`config-osx.fish` /
  `config-linux.fish` / `config-windows.fish`) and, if present,
  `config-local.fish`.
- `conf.d/*.fish` — auto-sourced on every shell start, one concern per file
  (colors, per-tool `PATH`/env setup for `go`/`node`/`dotnet`/`nebius`,
  the daily cleanup hook, tide color vars; fisher adds `z` and fzf setup).
- `functions/*.fish` — autoloaded on first use: the (currently unused — see
  below) custom `fish_prompt`, key bindings, `nvm` wrapper, `cpwd`, `dot`
  (chezmoi for this repo), the `env-*` tools. Plugin functions (fzf.fish,
  `z`, `bass`, `fisher`) are installed by fisher and not tracked.
- `completions/*.fish` — completions for `bun` and `copilot` (plugin
  completions come from fisher).

## Usage

### Aliases

| Alias           | Runs                                                          |
| ---------------- | -------------------------------------------------------------- |
| `ls`             | `eza`/`lsd`/`colorls` if installed (in that fallback order), else plain `ls -p -G` |
| `la`             | `ls -A`                                                        |
| `ll` / `lla`     | long / long+all listing                                        |
| `tree`           | `eza`/`lsd`/`colorls` tree view, if installed                  |
| `g`              | `git`                                                           |
| `cls`            | `clear`                                                         |
| `vim` / `vi`     | `nvim`, if installed                                            |

### Directory jumping (`z` plugin)

| Command      | Action                                    |
| ------------- | ------------------------------------------ |
| `z <query>`  | cd to the best-matching frecent directory  |
| `zo <query>` | same match, opened in the OS file browser  |

### fzf shortcuts

From `fzf.fish` (bound in `conf.d/fzf.fish` via `functions/fzf_configure_bindings.fish`)
plus fzf's own native fish integration (`fzf --fish | source`, in
`functions/fish_user_key_bindings.fish`):

| Key            | Action                          | Source           |
| -------------- | -------------------------------- | ----------------- |
| `ctrl+t`       | fuzzy-find a file, insert its path | fzf native      |
| `ctrl+r`       | fuzzy-search command history      | fzf native / fzf.fish |
| `alt+c`        | fuzzy-find a directory, `cd` into it | fzf native    |
| `alt+ctrl+f`   | fuzzy-search directories          | fzf.fish          |
| `alt+ctrl+l`   | fuzzy-search `git log`            | fzf.fish          |
| `alt+ctrl+s`   | fuzzy-search `git status`         | fzf.fish          |
| `alt+ctrl+p`   | fuzzy-search running processes    | fzf.fish          |
| `ctrl+v`       | fuzzy-search shell variables      | fzf.fish          |

On macOS, `config-osx.fish` sets fzf's preview to render with `bat`.

### Housekeeping

`conf.d/startup.fish` defines `sys_cleanup` (clears npm/NuGet/Yarn caches,
prunes the pnpm store, trims old Claude Desktop versions and `agy` CLI
backups) and `sys_cleanup_due`, which runs it at most once per day —
triggered automatically from `config.fish` on every interactive shell start,
tracked via `.last_cleanup_date`.

### Prompt

The active prompt is **oh-my-posh** (`bubblesextra` theme, initialized in
`config.fish`). `functions/fish_prompt.fish` defines fish's own vcs-aware
prompt, but oh-my-posh's `fish_prompt` function is defined after it loads and
takes over — that file and the `tide_*` color variables in `conf.d/tide.fish`
are currently inert leftovers, kept in case oh-my-posh is ever dropped.
