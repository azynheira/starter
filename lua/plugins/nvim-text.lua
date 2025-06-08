-- nvim-test.lua Text files
-- Last Changed:2025-06-08 09:52:55
return {
  {
    "MeanderingProgrammer/render-markdown.nvim",
    enabled = true,
  },
  {
    "OXY2DEV/markview.nvim",
    lazy = false,
  },
  {
    "quarto-dev/quarto-nvim",
    dev = false,
    ft = { "quarto" },
    dependencies = {
      {
        "jmbuhr/otter.nvim",
        dependencies = {
          { "neovim/nvim-lspconfig" },
        },
        config = true,
      },
    },
    opts = {
      lspFeatures = {
        languages = { "python", "julia", "bash", "lua", "html" },
      },
      codeRunner = {
        enabled = true,
        default_method = "molten",
      },
    },
    config = function(_, opts)
      require("quarto").setup(opts)
      local runner = require("quarto.runner")
      vim.keymap.set("n", "<localleader>qc", runner.run_cell, { desc = "run cell" })
      vim.keymap.set("n", "<localleader>qa", runner.run_above, { desc = "run cell and above" })
      vim.keymap.set("n", "<localleader>qA", runner.run_all, { desc = "run all cells" })
      vim.keymap.set("n", "<localleader>ql", runner.run_line, { desc = "run line" })
      vim.keymap.set("v", "<localleader>qr", runner.run_range, { desc = "run visual range" })
      vim.keymap.set("n", "<localleader>qA", function()
        runner.run_all(true)
      end, { desc = "run all cells of all languages" })
    end,
  },
}
