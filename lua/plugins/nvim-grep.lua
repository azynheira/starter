-- nvim-grep.lua Grep configuration
-- Last Changed:2025-06-19 11:58:19
return {
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
              filesFilter = ignore_these .. (ext and ext ~= "" and "*." .. ext or nil),

              flags = "",
            },
          })
        end,
        mode = { "n", "v" },
        desc = "Search and Replace",
      },
    },
  },
  { "junegunn/fzf", dir = "~/.fzf", build = "./install --all" },
}
