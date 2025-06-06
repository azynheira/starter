-- nvim-search.lua Search configuration
-- Last Changed:2025-06-06 22:14:35
return {
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
  },
  -- search and replace plugin
  {
    "MagicDuck/grug-far.nvim",
    keys = {
      {
        "<leader>sr",
        function()
          local grug = require("grug-far")
          local ignore_these = "!dist/ !.next/ !.git/ !.gitlab/ !build/ !target/"
          local ext = vim.bo.buftype == "" and vim.fn.expand("%:e")
          grug.open({
            helpLine = {
              enabled = false,
            },
            showCompactInputs = true,
            showInputsTopPadding = false,
            showInputsBottomPadding = false,
            transient = true,
            prefills = {
              filesFilter = ignore_these,
              --.. (ext and ext ~= "" and "*." .. ext or nil),

              flags = "",
            },
          })
        end,
        mode = { "n", "v" },
        desc = "Search and Replace",
      },
    },
  },
}
