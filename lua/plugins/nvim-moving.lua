-- nvim-moving.lua Code related to moving around
-- Last Changed:2025-06-04 17:43:27
return {
  {
    "ggandor/flit.nvim",
    enabled = true,
    keys = function()
      local ret = {}
      for _, key in ipairs({ "f", "F", "t", "T" }) do
        ret[#ret + 1] = { key, mode = { "n", "x", "o" } }
      end
      return ret
    end,
    opts = { labeled_modes = "nx" },
  },
  {
    "ggandor/leap.nvim",
    enabled = true,
    keys = {
      { "gl", mode = { "n", "x", "o" }, desc = "Leap" },
      { "gls", mode = { "n", "x", "o" }, desc = "Leap Forward to" },
      { "glS", mode = { "n", "x", "o" }, desc = "Leap Backward to" },
      { "glw", mode = { "n", "x", "o" }, desc = "Leap from Windows" },
    },
    config = function(_, opts)
      local leap = require("leap")
      for k, v in pairs(opts) do
        leap.opts[k] = v
      end
      leap.add_default_mappings(true)
      vim.keymap.del({ "x", "o" }, "x")
      vim.keymap.del({ "x", "o" }, "X")
    end,
  },
  -- Go forward/backward with square brackets
  {
    "echasnovski/mini.bracketed",
    event = "BufReadPost",
    config = function()
      local bracketed = require("mini.bracketed")
    end,
  },
  { "echasnovski/mini.ai", version = false },
}
