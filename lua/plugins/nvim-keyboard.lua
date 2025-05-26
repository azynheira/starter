-- nvim-keyboard.lua Keyboard related
-- Last Changed:2025-05-26 20:01:59
return {
  {
    "folke/which-key.nvim",
    enabled = true,
    opts = {
      preset = "helix",
      spec = {},
    },
    icons = {
      mappings = vim.g.have_nerd_font,
    },
  },
}
