-- nvim-snacks.lua Snacks configuration
-- Last Changed:2025-06-05 16:13:26
return {
  {
    "folke/snacks.nvim",
    ---@type snacks.Config
    opts = {
      words = { enabled = false },
      image = { enabled = false },
      bigfile = { enabled = true },
      bufdelete = { enabled = true },
      -- show hidden files in snacks.explorer
      explorer = {
        hidden = true,
        ignored = true,
        include = { ".*" },
        exclude = { "node_modules", ".git", ".hg" },
      },
      picker = {
        hidden = true,
        ignored = true,
        include = { ".*" },
        exclude = { "node_modules", ".git", ".hg" },
        sources = {
          buffers = {
            current = false,
          },
          files = {
            hidden = true,
          },
        },
      },
      -- Dashboard. This runs when neovim starts, and is what displays
      dashboard = {
        preset = {
          header = [[
                                        oo            

88d888b. .d8888b. .d8888b. dP   .dP dP 88d8b.d8b. 
88'  `88 88ooood8 88'  `88 88   d8' 88 88'`88'`88 
88    88 88.  ... 88.  .88 88 .88'  88 88  88  88 
dP    dP `88888P' `88888P' 8888P'   dP dP  dP  dP]],
          -- stylua: ignore
          ---@type snacks.dashboard.Item[]
          keys = {
            { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
            { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
            { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
            { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
            { icon = " ", key = "S", desc = "Scratch Buffer", action = ":lua Snacks.scratch()" },
            { icon = "󰐮 ", key = "p", desc = "Projects", action = ":lua Snacks.picker.projects()" },
            { icon = " ", key = "c", desc = "Config", action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
            { icon = " ", key = "s", desc = "Restore Session", section = "session" },
            { icon = " ", key = "x", desc = "Lazy Extras", action = ":LazyExtras" },
            { icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy" },
            { icon = " ", key = "q", desc = "Quit", action = ":qa" },
          },
        },
      },
      notifier = {
        enabled = true,
        --- available style: "compact"|"fancy"|"minimal"
        style = "compact",
      },
      statuscolumn = {
        enabled = true,
      },
      scratch = {
        enabled = true,
        ft = "text",
        name = "Scratch",
      },
      terminal = {
        enabled = true,
        win = {
          position = "bottom",
        },
      },
      -- convenience
      quickfile = {
        enabled = true,
      },
      --- special mode
      zen = {
        enabled = true,
        enter = true,
        fixbuf = false,
        minimal = false,
        width = 120,
        height = 0,
        backdrop = { transparent = true, blend = 40 },
        keys = { q = false },
        zindex = 40,
        wo = {
          winhighlight = "NormalFloat:Normal",
        },
        w = {
          snacks_main = true,
        },
        ---@type table<string, boolean>
        toggles = {
          dim = false,
          git_signs = true,
          mini_diff_signs = true,
          diagnostics = true,
          inlay_hints = true,
        },
      },
      -- integrations
      lazygit = {
        enabled = true,
        configure = true,
      },
    },
  },
}
