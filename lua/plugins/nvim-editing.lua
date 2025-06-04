-- nvim-editing.lua Editing related stuff
-- Last Changed:2025-06-04 20:58:42
return {
  { "tpope/vim-repeat", event = "VeryLazy" },
  {
    "smjonas/inc-rename.nvim",
    cmd = "IncRename",
    opts = {},
  },
  {
    "windwp/nvim-autopairs",
    event = { "InsertEnter" },
    opts = {
      check_ts = true,
      ts_config = {
        lua = { "string" }, -- don't add pairs in lua string treesitter nodes
      },
    },
  },
  {
    "echasnovski/mini.comment",
    event = "VeryLazy",
    opts = {
      options = {
        -- Whether to ignore blank lines when commenting
        ignore_blank_line = true,
        -- Whether to ignore blank lines in actions and textobject
        start_of_line = true,
        -- Whether to force single space inner padding for comment parts
        pad_comment_parts = true,
        custom_commentstring = function()
          return require("ts_context_commentstring.internal").calculate_commentstring() or vim.bo.commentstring
        end,
      },
    },
  },
  {
    "mbbill/undotree",
    keys = {
      {
        "<leader>U",
        "<CMD>UndotreeToggle<CR><C-h>",
        mode = "n",
        desc = "Toggle Undo Tree",
      },
    },
  },
  {
    "KashifKhn/nvim-remove-comments",
    config = function()
      require("nvim-remove-comments").setup()
    end,
  },
}
