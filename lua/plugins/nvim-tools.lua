-- nvim-tools.lua  - Generic tools
-- Last Changed:2025-05-31 09:53:20
return {
  {
    "StonyBoy/nvim-update-time",
    config = function()
      require("nvim-update-time").setup({
        first = 0,
        last = 5,
        pattern = "Last Changed:",
        format = "%Y-%m-%d %H:%M:%S",
      })
    end,
  },
  {
    "mikavilpas/yazi.nvim",
    event = "VeryLazy",
    ---@type YaziConfig
    opts = {
      -- if you want to open yazi instead of netrw, see below for more info
      open_for_directories = false,
      keymaps = {},
    },
  },
  {
    "stevearc/oil.nvim",
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {
      view_options = {
        show_hidden = true,
      },
    },
    -- Optional dependencies
    dependencies = { { "echasnovski/mini.icons", opts = {} } },
    -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
    -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
    lazy = false,
  },
}
