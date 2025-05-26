-- nvim-shell.lua Shell related
-- Last Changed:2025-05-26 20:08:31
return {
  {
    "GR3YH4TT3R93/zellij-nav.nvim",
    cond = os.getenv("ZELLIJ") == "0", -- Only load plugin if in active Zellij instance
    event = "VeryLazy", -- Lazy load plugin for improved startup times
  },
}
