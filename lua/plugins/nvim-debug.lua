-- nvim-debug.lua Debug related
-- Last Changed:2025-06-09 11:01:26

-- Docs at https://github.com/mfussenegger/nvim-dap-python are useful.
return {
  -- keep-sorted start block=yes
  {
    "mfussenegger/nvim-dap",
    lazy = true,
    -- Copied from LazyVim/lua/lazyvim/plugins/extras/dap/core.lua and
    -- modified.
    keys = {
      {
        "<leader>db",
        function()
          require("dap").toggle_breakpoint()
        end,
        desc = "Toggle Breakpoint",
      },
      {
        "<leader>dc",
        function()
          require("dap").continue()
        end,
        desc = "Continue",
      },

      {
        "<leader>dC",
        function()
          require("dap").run_to_cursor()
        end,
        desc = "Run to Cursor",
      },
      {
        "<leader>dT",
        function()
          require("dap").terminate()
        end,
        desc = "Terminate",
      },
    },
  },
  {
    "rcarriga/nvim-dap-ui",
    config = true,
    keys = {
      {
        "<leader>du",
        function()
          require("dapui").toggle({})
        end,
        desc = "Dap UI",
      },
    },
    dependencies = {
      -- keep-sorted start block=yes
      {
        "jay-babu/mason-nvim-dap.nvim",
        ---@type MasonNvimDapSettings
        opts = {
          -- This line is essential to making automatic installation work
          -- :exploding-brain
          handlers = {},
          automatic_installation = {
            -- These will be configured by separate plugins.
            exclude = {
              "delve",
              "python",
            },
          },
          -- DAP servers: Mason will be invoked to install these if necessary.
          ensure_installed = {
            "bash",
            "codelldb",
            "python",
          },
        },
        dependencies = {
          "mfussenegger/nvim-dap",
          "williamboman/mason.nvim",
        },
      },
      {
        "mfussenegger/nvim-dap-python",
        lazy = true,
        config = function()
          local python = vim.fn.expand("~/.local/share/nvim/mason/packages/debugpy/venv/bin/python")
          require("dap-python").setup(python)
        end,
        -- Consider the mappings at
        -- https://github.com/mfussenegger/nvim-dap-python?tab=readme-ov-file#mappings
        dependencies = {
          "mfussenegger/nvim-dap",
        },
      },
      {
        "nvim-neotest/nvim-nio",
      },
      {
        "theHamsta/nvim-dap-virtual-text",
        config = true,
        dependencies = {
          "mfussenegger/nvim-dap",
        },
      },
      -- keep-sorted end
    },
  },
  -- keep-sorted end
}
