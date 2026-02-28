-- nvim-lsp.lua LSP configuration
-- Last Changed:2026-02-28 18:45:50

return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      ["*"] = {
        keys = {
          -- Only set this keymap for servers that support code actions
          { "<leader>ca", vim.lsp.buf.code_action, desc = "Code Action", has = "codeAction" },
          -- Multiple capabilities
          {
            "<leader>cR",
            function()
              Snacks.rename.rename_file()
            end,
            desc = "Rename File",
            has = { "workspace/didRenameFiles", "workspace/willRenameFiles" },
          },
        },
      },
    },
  },
  {
    "RRethy/vim-illuminate",
    event = "LazyFile",
    opts = {
      delay = 200,
      large_file_cutoff = 2000,
      filetypes_denylist = {
        "aerial",
        "neo-tree",
      },
      modes_denylist = { "v", "V" },
      under_cursor = false,
      large_file_overrides = {
        providers = { "lsp" },
      },
    },
    config = function(_, opts)
      require("illuminate").configure(opts)
      Snacks.toggle({
        name = "Illuminate",
        get = function()
          return not require("illuminate.engine").is_paused()
        end,
        set = function(enabled)
          local m = require("illuminate")
          if enabled then
            m.resume()
          else
            m.pause()
          end
        end,
      }):map("<leader>ux")

      local function map(key, dir, buffer)
        vim.keymap.set("n", key, function()
          require("illuminate")["goto_" .. dir .. "_reference"](false)
        end, { desc = dir:sub(1, 1):upper() .. dir:sub(2) .. " Reference", buffer = buffer })
      end

      map("]]", "next")
      map("[[", "prev")

      -- also set it after loading ftplugins, since a lot overwrite [[ and ]]
      vim.api.nvim_create_autocmd("FileType", {
        callback = function()
          local buffer = vim.api.nvim_get_current_buf()
          map("]]", "next", buffer)
          map("[[", "prev", buffer)
        end,
      })
    end,
    keys = {
      { "]]", desc = "Next Reference" },
      { "[[", desc = "Prev Reference" },
    },
  },
  -- better diagnostics list and others
  {
    "folke/trouble.nvim",
    cmd = { "Trouble" },
    opts = {
      use_diagnostic_signs = true,
      modes = {
        lsp = {
          win = { position = "right" },
        },
        diagnostics = {
          auto_close = true, -- auto close when there are no items
          auto_open = false, -- auto open when there are items
          auto_jump = false, -- auto jump to the item when there's only one
          focus = true, -- Focus the window when opened
          restore = true, -- restores the last location in the list when opening
          follow = true, -- Follow the current item
          indent_guides = false, -- show indent guides
        },
      },
    },
    keys = {
      { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (Trouble)" },
      { "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics (Trouble)" },
      { "<leader>cs", "<cmd>Trouble symbols toggle<cr>", desc = "Symbols (Trouble)" },
      { "<leader>cS", "<cmd>Trouble lsp toggle<cr>", desc = "LSP references/definitions/... (Trouble)" },
      { "<leader>xL", "<cmd>Trouble loclist toggle<cr>", desc = "Location List (Trouble)" },
      { "<leader>xQ", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix List (Trouble)" },
      {
        "[q",
        function()
          if require("trouble").is_open() then
            require("trouble").prev({ skip_groups = true, jump = true })
          else
            local ok, err = pcall(vim.cmd.cprev)
            if not ok then
              vim.notify(err, vim.log.levels.ERROR)
            end
          end
        end,
        desc = "Previous Trouble/Quickfix Item",
      },
      {
        "]q",
        function()
          if require("trouble").is_open() then
            require("trouble").next({ skip_groups = true, jump = true })
          else
            local ok, err = pcall(vim.cmd.cnext)
            if not ok then
              vim.notify(err, vim.log.levels.ERROR)
            end
          end
        end,
        desc = "Next Trouble/Quickfix Item",
      },
    },
  },
  {
    "onsails/lspkind.nvim",
    config = function()
      require("lspkind").init({
        -- Customize options here if needed
        mode = "symbol_text", -- Show both symbol and text
        preset = "default", -- Use default preset
        symbol_map = {
          Text = "",
          Method = "",
          Function = "",
          Constructor = "",
          Field = "",
          Variable = "",
          Class = "ﴯ",
          Interface = "",
          Module = "",
          Property = "ﰠ",
          Unit = "",
          Value = "",
          Enum = "",
          Keyword = "",
          Snippet = "",
          Color = "",
          File = "",
          Reference = "",
          Folder = "",
          EnumMember = "",
          Constant = "",
          Struct = "",
          Event = "",
          Operator = "",
          TypeParameter = "",
        },
      })
    end,
  },
}
