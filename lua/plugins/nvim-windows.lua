-- nvim-windows.lua windows related stuff
-- Last Changed:2025-06-09 08:20:20
return {
  { "tiagovla/scope.nvim", config = true },
  {
    "folke/edgy.nvim",
    opts = {
      animate = { enabled = false },
      exit_when_last = true,
      right = {
        {
          title = "Outline",
          ft = "aerial",
          pinned = true,
          open = "AerialToggle",
          size = { width = 0.15 },
        },
      },
      icons = {
        closed = " ▸",
        open = " 𝅍",
      },
    },
  },
}
