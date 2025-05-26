-- nvim-tools.lua  - Generic tools
-- Last Changed:2025-05-26 20:12:13
return {
  "mbbill/undotree",
  keys = {
    {
      "<leader>u",
      "<CMD>UndotreeToggle<CR><C-h>",
      mode = "n",
      desc = "Toggle Undo Tree",
    },
  },
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
}
