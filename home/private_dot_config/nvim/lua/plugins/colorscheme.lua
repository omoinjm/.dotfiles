return {
  {
    "craftzdog/solarized-osaka.nvim",
    lazy = true,
    priority = 1000,
    opts = function()
      return {
        transparent = true,
        styles = {
          sidebars = "transparent", -- file explorer, help, quickfix, etc.
          floats = "transparent", -- popups, pickers, hover docs
        },
      }
    end,
  },
}

