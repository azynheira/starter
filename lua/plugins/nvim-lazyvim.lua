-- nvim-lazyvim.lua Lazyvim special setup
-- Last Changed:2025-06-16 11:30:12
return {
  { "folke/lazy.nvim", version = false },
  { "LazyVim/LazyVim", version = false },
  {
    "rootiest/nvim-updater.nvim",
    version = "*", -- Pin to GitHub releases
    config = function()
      require("nvim_updater").setup({
        source_dir = "~/.local/src/neovim", -- Custom target directory
        build_type = "RelWithDebInfo", -- Set the desired build type
        branch = "master", -- Track nightly branch
        check_for_updates = true, -- Enable automatic update checks
        notify_updates = true, -- Enables update notifications
        default_keymaps = false, -- Disable default keymaps
      })
    end,
    keys = { -- Custom keymappings
      { -- Custom Update Neovim
        "<Leader>cu",
        desc = "Update Neovim",
      },
      { -- Custom Update Neovim
        "<Leader>cuU",
        function()
          require("nvim_updater").update_neovim()
        end,
        desc = "Custom Update Neovim",
      },
      { -- Debug Build Neovim
        "<Leader>cuD",
        function()
          require("nvim_updater").update_neovim({ build_type = "Debug" })
        end,
        desc = "Debug Build Neovim",
      },
      { -- Remove Neovim Source
        "<Leader>cuR",
        ":NVUpdateRemoveSource<CR>",
        desc = "Remove Neovim Source Directory",
      },
    },
  },
}
