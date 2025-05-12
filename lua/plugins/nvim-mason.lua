return {
  {
    {
      "mason-org/mason.nvim",
      version = "^1.0.0",
      opts = {
        ensure_installed = {
          "stylua",
          "shellcheck",
          "shfmt",
          "flake8",
        },
      },
    },
    {
      "mason-org/mason-lspconfig.nvim",
      version = "^1.0.0",
    },
    {
      "neovim/nvim-lspconfig",
      opts = function()
        local keys = require("lazyvim.plugins.lsp.keymaps").get()
        keys[#keys + 1] = {
          "<leader>cr",
          function()
            local inc_rename = require("inc_rename")
            return ":" .. inc_rename.config.cmd_name .. " " .. vim.fn.expand("<cword>")
          end,
          expr = true,
          desc = "Rename (inc-rename.nvim)",
          has = "rename",
        }
      end,
    },
  },
}
