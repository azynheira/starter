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
      opts = {
        servers = {
          -- pyright will be automatically installed with mason and loaded with lspconfig
          pyright = {},
        },
        -- you can do any additional lsp server setup here
        -- return true if you don't want this server to be setup with lspconfig
        setup = {},
      },
    },
  },
}
