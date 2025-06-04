-- nvim-tools.lua  - Generic tools
-- Last Changed:2025-06-04 05:56:17
return {
  {
    "StonyBoy/nvim-update-time",
    config = function()
      require("nvim-update-time").setup({
        first = 0,
        last = 5,
        pattern = "Last Changed:",
        format = "%Y-%m-%d %H:%M:%S",
      })
    end,
  },
  {
    "mikavilpas/yazi.nvim",
    event = "VeryLazy",
    ---@type YaziConfig
    opts = {
      -- if you want to open yazi instead of netrw, see below for more info
      open_for_directories = false,
      keymaps = {},
    },
  },
  {
    "stevearc/oil.nvim",
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {
      view_options = {
        show_hidden = true,
      },
    },
    -- Optional dependencies
    dependencies = { { "echasnovski/mini.icons", opts = {} } },
    -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
    -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
    lazy = false,
  },
  {
    "bngarren/checkmate.nvim",
    ft = "markdown", -- Lazy loads for Markdown files matching patterns in 'files'
    opts = {
      -- your configuration here
    },
  },
  {
    {
      "stevearc/aerial.nvim",
      event = "LazyFile",
      opts = function()
        local icons = vim.deepcopy(LazyVim.config.icons.kinds)

        -- HACK: fix lua's weird choice for `Package` for control
        -- structures like if/else/for/etc.
        icons.lua = { Package = icons.Control }

        ---@type table<string, string[]>|false
        local filter_kind = false
        if LazyVim.config.kind_filter then
          filter_kind = assert(vim.deepcopy(LazyVim.config.kind_filter))
          filter_kind._ = filter_kind.default
          filter_kind.default = nil
        end

        local opts = {
          attach_mode = "global",
          backends = { "lsp", "treesitter", "markdown", "man" },
          show_guides = true,
          layout = {
            resize_to_content = false,
            win_opts = {
              winhl = "Normal:NormalFloat,FloatBorder:NormalFloat,SignColumn:SignColumnSB",
              signcolumn = "yes",
              statuscolumn = " ",
            },
          },
          icons = icons,
          filter_kind = filter_kind,
        -- stylua: ignore
        guides = {
          mid_item   = "├╴",
          last_item  = "└╴",
          nested_top = "│ ",
          whitespace = "  ",
        },
        }
        return opts
      end,
      keys = {
        { "<leader>cs", "<cmd>AerialToggle<cr>", desc = "Aerial (Symbols)" },
      },
    },
  },
}
