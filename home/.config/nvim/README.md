# nvim config

Personal Neovim config built on [LazyVim](https://www.lazyvim.org/). This
file documents what's actually customized here — for anything not
mentioned, LazyVim's defaults apply (see the
[LazyVim keymap reference](https://www.lazyvim.org/keymaps)).

## Setup

1. Install Neovim (LazyVim requires a recent build — see the
   [LazyVim installation guide](https://lazyvim.github.io/installation)),
   `git`, a C compiler/`make`, and [`ripgrep`](https://github.com/BurntSushi/ripgrep).
   `make` is needed to build `telescope-fzf-native` and `avante.nvim`;
   `ripgrep` powers Telescope's live grep (`;r`).
2. `fish` must be installed and on `PATH` — `options.lua` sets it as
   Neovim's `shell`.
3. Symlink or clone this directory to `~/.config/nvim`, then launch `nvim`.
   [lazy.nvim](https://github.com/folke/lazy.nvim) bootstraps itself and
   installs every plugin on first run.
4. Mason auto-installs the LSP servers, formatters, linters, and debug
   adapters listed in `lua/plugins/lsp.lua` (stylua, selene, shellcheck,
   tsserver, pyright, gopls, clangd, black, ruff, prettier, `debugpy`, and
   more) — no manual binary installs needed, just an internet connection
   and the relevant language toolchains (node, python, go, etc.) already on
   `PATH`.
5. AI features need credentials, set up separately:
   - **avante.nvim** (`lua/plugins/avante.lua`) is configured for the
     **Gemini** provider (`gemini-1.5-flash`) — needs a Gemini API key
     available the way avante.nvim expects (see its
     [README](https://github.com/yetone/avante.nvim)). Claude/OpenAI configs
     exist in the file, commented out, if you'd rather switch providers.
   - **copilot.lua** (`lua/plugins/coding.lua`) and the `copilot-chat`
     LazyVim extra (`lazyvim.json`) need an authenticated GitHub Copilot
     subscription — run `:Copilot auth` after first launch.

## Structure

- `init.lua` — bootstraps `lazy.nvim`, defines the global `dd()`/`vim.print`
  debug-print helper, then loads `config.lazy`.
- `lua/config/` — `options.lua` (core vim options), `keymaps.lua` (custom
  keymaps), `autocmds.lua` (custom autocommands), `lazy.lua` (lazy.nvim +
  LazyVim bootstrap).
- `lua/omoi/` — personal helper modules:
  - `discipline.lua` — a "stop spamming `hjkl`" guard (10 rapid presses in
    2s triggers a "Hold it Cowboy!" notice instead of moving). Currently
    **disabled** — the call in `keymaps.lua` is commented out.
  - `hsl.lua` — hex ↔ RGB ↔ HSL color conversion, backs `<leader>r`.
  - `lsp.lua` — inlay-hint and format-on-save toggle helpers, shared by
    `lua/plugins/lsp.lua`.
- `lua/plugins/` — one file per plugin group: `avante` (AI assistant),
  `coding` (rename/increment/Copilot/markdown preview), `colorscheme`
  (solarized-osaka), `debugger` (nvim-dap), `editor` (Telescope/git/buffers),
  `lsp` (Mason + lspconfig), `treesitter`, `ui` (bufferline/lualine/noice/
  zen-mode/dashboard). `better_stack.lua` is currently all commented out.
- `lua/util/debug.lua` — pretty-printer backing the global `dd()`.

## Usage

Leader key is `<space>`.

### Editing (`config/keymaps.lua`)

| Key                  | Mode  | Action                                              |
| --------------------- | ----- | ----------------------------------------------------- |
| `x`                  | n     | delete char without yanking it                       |
| `<leader>p` / `P`    | n, v  | paste from register `0` (last yank, not last delete) |
| `<leader>c` / `C`    | n, v  | change into the black-hole register (doesn't clobber yank) |
| `<leader>d` / `D`    | n, v  | delete into the black-hole register                  |
| `dw`                 | n     | delete word backwards                                |
| `+` / `-`            | n     | increment / decrement number under cursor             |
| `<leader>o` / `O`    | n     | new line below/above without continuing the comment leader |
| `<C-m>`              | n     | jump forward in the jumplist                          |
| `<C-j>`              | n     | jump to next diagnostic                                |
| `<leader>r`          | n     | replace hex color under cursor with an `hsl()` string  |
| `<leader>i`          | n     | toggle inlay hints                                     |
| `:ToggleAutoformat`  | cmd   | toggle format-on-save                                  |

`dial.nvim` (`plugins/coding.lua`) also owns `<C-a>`/`<C-x>` for smarter
increment/decrement (dates, booleans, semver, hex).

### Windows, splits & tabs

| Key                        | Action                        |
| ---------------------------- | ------------------------------- |
| `ss` / `sv`                 | horizontal / vertical split    |
| `sh` / `sj` / `sk` / `sl`   | move to the window left/below/above/right |
| `<C-w>` + arrow             | resize the current window       |
| `te`                        | `:tabedit`                      |
| `<tab>` / `<s-tab>`         | next / previous tab             |

### Finding things (Telescope, `plugins/editor.lua`)

| Key         | Action                                     |
| ------------ | -------------------------------------------- |
| `;f`        | find files                                  |
| `;r`        | live grep (needs `ripgrep`)                 |
| `\`         | list open buffers                           |
| `;t`        | help tags                                   |
| `;;`        | resume the last picker                      |
| `;e`        | diagnostics                                 |
| `;s`        | treesitter symbols                          |
| `;c`        | LSP incoming calls                          |
| `sf`        | file browser                                |
| `<leader>fP`| find a file in an installed plugin's source |
| `gd`        | go to LSP definition (via Telescope)        |

### Git (`plugins/editor.lua`)

| Key             | Action                                      |
| ---------------- | --------------------------------------------- |
| `<leader>gb`    | git blame for the current line               |
| `<leader>go`    | open the current file/line in the remote repo (needs a configured git remote) |

### Buffers (`plugins/ui.lua`)

| Key                          | Action                        |
| ------------------------------ | -------------------------------- |
| `<S-h>` / `<S-l>`             | previous / next buffer          |
| `[b]` / `]b`                  | previous / next buffer          |
| `[B]` / `]B`                  | first / last buffer             |
| `<leader>bp` / `bP`           | pin / toggle pin on buffer       |
| `<leader>br`                 | close buffers to the right       |
| `<leader>bl`                 | close buffers to the left        |
| `<leader>th`                 | close hidden buffers             |
| `<leader>tu`                 | close nameless (scratch) buffers |

### Debugging — nvim-dap, Python via `debugpy` (`plugins/debugger.lua`)

| Key              | Action                          |
| ----------------- | ---------------------------------- |
| `<leader>db`      | toggle breakpoint                  |
| `<leader>dB`      | conditional breakpoint (prompts)   |
| `<leader>dc`      | continue                           |
| `<leader>dC`      | run to cursor                      |
| `<leader>da`      | run with args                      |
| `<leader>dl`      | run last                           |
| `<leader>di`      | step into                          |
| `<leader>dO`      | step over                          |
| `<leader>do`      | step out                           |
| `<leader>dj` / `dk` | move down/up the call stack       |
| `<leader>dg`      | go to line, without executing      |
| `<leader>dp`      | pause                              |
| `<leader>dr`      | toggle the REPL                    |
| `<leader>ds`      | show session info                  |
| `<leader>dt`      | terminate                          |
| `<leader>dw`      | hover widgets                      |
| `<leader>du`      | toggle the Dap UI                  |
| `<leader>de`      | evaluate expression (n, v)         |
| `<leader>dPt` / `dPc` | (Python only) debug the method / class under cursor |

### AI assistants

- **avante.nvim** — Cursor-style AI chat/edit, wired to Gemini. Uses its own
  default keymaps (not overridden here) — see `:help avante` or its
  [README](https://github.com/yetone/avante.nvim) for the current ask/edit/
  chat bindings.
- **copilot.lua** — inline completions. `<C-l>` accept suggestion, `<M-l>`
  accept word, `<M-S-l>` accept line, `<M-]>` / `<M-[>` next/previous
  suggestion, `<C-]>` dismiss.
- `lazyvim.plugins.extras.ai.copilot-chat` extra adds Copilot's chat UI on
  top (default LazyVim keymaps).

### Misc UI

| Key           | Action              |
| -------------- | --------------------- |
| `<leader>z`   | zen mode              |

`ui.lua` also configures `bufferline`, `lualine`, `incline` (floating
filename), `noice` (routes noisy/unfocused notifications to the OS notifier
via `notify-send`), and a custom Snacks dashboard header.
`smear-cursor` (from `lazyvim.json` extras) animates cursor movement.
