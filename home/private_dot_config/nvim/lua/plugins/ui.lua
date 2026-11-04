return {
  -- messages, cmdline and the popupmenu
  {
    "folke/noice.nvim",
    opts = function(_, opts)
      table.insert(opts.routes, {
        filter = {
          event = "notify",
          find = "No information available",
        },
        opts = { skip = true },
      })
      local focused = true
      vim.api.nvim_create_autocmd("FocusGained", {
        callback = function()
          focused = true
        end,
      })
      vim.api.nvim_create_autocmd("FocusLost", {
        callback = function()
          focused = false
        end,
      })
      table.insert(opts.routes, 1, {
        filter = {
          cond = function()
            return not focused
          end,
        },
        view = "notify_send",
        opts = { stop = false },
      })

      opts.commands = {
        all = {
          -- options for the message history that you get with `:Noice`
          view = "split",
          opts = { enter = true, format = "details" },
          filter = {},
        },
      }

      vim.api.nvim_create_autocmd("FileType", {
        pattern = "markdown",
        callback = function(event)
          vim.schedule(function()
            require("noice.text.markdown").keys(event.buf)
          end)
        end,
      })

      opts.presets.lsp_doc_border = true
    end,
  },

  {
    "rcarriga/nvim-notify",
    opts = {
      timeout = 5000,
    },
  },

  {
    "snacks.nvim",
    opts = {
      scroll = { enabled = false },
    },
    keys = {},
  },

  -- buffer line
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",

    keys = {
      { "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", desc = "Toggle Pin" },
      { "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete Non-Pinned Buffers" },
      { "<leader>br", "<Cmd>BufferLineCloseRight<CR>", desc = "Delete Buffers to the Right" },
      { "<leader>bl", "<Cmd>BufferLineCloseLeft<CR>", desc = "Delete Buffers to the Left" },
      { "<S-h>", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev Buffer" },
      { "<S-l>", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
      { "[b", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev Buffer" },
      { "]b", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
      { "[B", "<cmd>BufferLineMovePrev<cr>", desc = "Move buffer prev" },
      { "]B", "<cmd>BufferLineMoveNext<cr>", desc = "Move buffer next" },
    },

    opts = function(_, opts)
      local colors = require("solarized-osaka.colors").setup()
      local bg = colors.bg
      local inactive_bg = colors.base03
      local inactive_fg = colors.cyan300
      local active_bg = colors.yellow300
      local active_fg = colors.base04

      local function on_active(hl)
        return vim.tbl_extend("force", { bg = active_bg, bold = false, italic = false }, hl)
      end

      local function on_inactive(hl)
        return vim.tbl_extend("force", { bg = inactive_bg, bold = false, italic = false }, hl)
      end

      opts.options = vim.tbl_deep_extend("force", opts.options or {}, {
        separator_style = "slant",
        show_buffer_close_icons = false,
        show_close_icon = false,
        indicator = { style = "none" },
      })

      opts.highlights = vim.tbl_deep_extend("force", opts.highlights or {}, {
        fill = { bg = bg, fg = inactive_fg },
        background = on_inactive({ fg = inactive_fg }),
        buffer = on_inactive({ fg = inactive_fg }),
        buffer_visible = on_inactive({ fg = inactive_fg }),
        buffer_selected = on_active({ fg = active_fg }),
        separator = { fg = bg, bg = inactive_bg },
        separator_visible = { fg = bg, bg = inactive_bg },
        separator_selected = { fg = bg, bg = active_bg },
        close_button = on_inactive({ fg = inactive_fg }),
        close_button_visible = on_inactive({ fg = inactive_fg }),
        close_button_selected = on_active({ fg = active_fg }),
        indicator_selected = on_active({ fg = active_fg }),
        numbers_selected = on_active({ fg = active_fg }),
        modified_selected = on_active({ fg = colors.orange700 }),
        diagnostic = on_inactive({ fg = inactive_fg }),
        diagnostic_visible = on_inactive({ fg = inactive_fg }),
        diagnostic_selected = on_active({ fg = active_fg }),
        error = on_inactive({ fg = colors.red500, sp = colors.red500 }),
        error_visible = on_inactive({ fg = colors.red500, sp = colors.red500 }),
        error_selected = on_active({ fg = colors.red700, sp = colors.red700 }),
        error_diagnostic = on_inactive({ fg = colors.red500, sp = colors.red500 }),
        error_diagnostic_visible = on_inactive({ fg = colors.red500, sp = colors.red500 }),
        error_diagnostic_selected = on_active({ fg = colors.red700, sp = colors.red700 }),
        warning = on_inactive({ fg = colors.yellow500, sp = colors.yellow500 }),
        warning_visible = on_inactive({ fg = colors.yellow500, sp = colors.yellow500 }),
        warning_selected = on_active({ fg = active_fg, sp = colors.yellow700 }),
        warning_diagnostic = on_inactive({ fg = colors.yellow500, sp = colors.yellow500 }),
        warning_diagnostic_visible = on_inactive({ fg = colors.yellow500, sp = colors.yellow500 }),
        warning_diagnostic_selected = on_active({ fg = colors.yellow700, sp = colors.yellow700 }),
        hint = on_inactive({ fg = colors.cyan500, sp = colors.cyan500 }),
        hint_visible = on_inactive({ fg = colors.cyan500, sp = colors.cyan500 }),
        hint_selected = on_active({ fg = active_fg, sp = colors.cyan700 }),
        hint_diagnostic = on_inactive({ fg = colors.cyan500, sp = colors.cyan500 }),
        hint_diagnostic_visible = on_inactive({ fg = colors.cyan500, sp = colors.cyan500 }),
        hint_diagnostic_selected = on_active({ fg = colors.cyan700, sp = colors.cyan700 }),
        info = on_inactive({ fg = colors.blue500, sp = colors.blue500 }),
        info_visible = on_inactive({ fg = colors.blue500, sp = colors.blue500 }),
        info_selected = on_active({ fg = active_fg, sp = colors.blue700 }),
        info_diagnostic = on_inactive({ fg = colors.blue500, sp = colors.blue500 }),
        info_diagnostic_visible = on_inactive({ fg = colors.blue500, sp = colors.blue500 }),
        info_diagnostic_selected = on_active({ fg = colors.blue700, sp = colors.blue700 }),
      })

      return opts
    end,
  },

  -- filename
  {
    "b0o/incline.nvim",
    dependencies = { "craftzdog/solarized-osaka.nvim" },
    event = "BufReadPre",
    priority = 1200,
    config = function()
      local colors = require("solarized-osaka.colors").setup()
      require("incline").setup({
        highlight = {
          groups = {
            InclineNormal = { guibg = colors.magenta500, guifg = colors.base04 },
            InclineNormalNC = { guifg = colors.violet500, guibg = colors.base03 },
          },
        },
        window = { margin = { vertical = 0, horizontal = 1 } },
        hide = {
          cursorline = true,
        },
        render = function(props)
          local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
          if vim.bo[props.buf].modified then
            filename = "[+] " .. filename
          end

          local icon, color = require("nvim-web-devicons").get_icon_color(filename)
          return { { icon, guifg = color }, { " " }, { filename } }
        end,
      })
    end,
  },

  -- statusline
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      local LazyVim = require("lazyvim.util")
      opts.sections.lualine_c[4] = {
        LazyVim.lualine.pretty_path({
          length = 0,
          relative = "cwd",
          modified_hl = "MatchParen",
          directory_hl = "",
          filename_hl = "Bold",
          modified_sign = "",
          readonly_icon = " 󰌾 ",
        }),
      }
    end,
  },

  {
    "folke/zen-mode.nvim",
    cmd = "ZenMode",
    opts = {
      plugins = {
        gitsigns = true,
        tmux = true,
        kitty = { enabled = false, font = "+2" },
      },
    },
    keys = { { "<leader>z", "<cmd>ZenMode<cr>", desc = "Zen Mode" } },
  },

  {
    "MeanderingProgrammer/render-markdown.nvim",
    enabled = false,
  },

  {
    "folke/snacks.nvim",
    opts = {
      dashboard = {
        preset = {

          header = [[
         ██████╗ ███╗   ███╗ ██████╗ ██╗███╗   ██╗     ██╗███╗   ███╗
        ██╔═══██╗████╗ ████║██╔═══██╗██║████╗  ██║     ██║████╗ ████║
        ██║   ██║██╔████╔██║██║   ██║██║██╔██╗ ██║     ██║██╔████╔██║
        ██║   ██║██║╚██╔╝██║██║   ██║██║██║╚██╗██║██   ██║██║╚██╔╝██║
        ╚██████╔╝██║ ╚═╝ ██║╚██████╔╝██║██║ ╚████║╚█████╔╝██║ ╚═╝ ██║
         ╚═════╝ ╚═╝     ╚═╝ ╚═════╝ ╚═╝╚═╝  ╚═══╝ ╚════╝ ╚═╝     ╚═╝
      ]],
        },
      },
    },
  },
}
