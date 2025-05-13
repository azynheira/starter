return {
  {
    "echasnovski/mini.starter",
    version = "*",
    event = "VimEnter",
    opts = function()
      local logo = "** Neo Vim **\n"
      local pad = ""
      local new_section = function(name, action, section)
        return { name = name, action = action, section = pad .. section }
      end

      local starter = require("mini.starter")
    --stylua: ignore
    local config = {
        autoopen = true,
        autowrite=true,
        evaluate_single = true,
        header = logo,
        items = {
          new_section("Find file",       LazyVim.pick(),                        "Snacks"),
          new_section("New file",        "ene | startinsert",                   "Built-in"),
          new_section("Recent files",    LazyVim.pick("oldfiles"),              "Snacks"),
          new_section("Projects",        LazyVim.pick("projects"),              "Projects"),
          new_section("Find Text",       LazyVim.pick("live_grep"),             "Snacks"),
          new_section("Config",          LazyVim.pick.config_files(),           "Config"),
          new_section("Restore session", [[lua require("persistence").load()]], "Session"),
          new_section("Lazy Extras",     "LazyExtras",                          "Config"),
          new_section("Lazy",            "Lazy",                                "Config"),
          new_section("Quit",            "qa",                                  "Built-in"),
        },
        content_hooks = {
          starter.gen_hook.adding_bullet(pad .. "░ ", true),
          starter.gen_hook.aligning("center", "center"),
        },
      }
      return config
    end,
    config = function(_, config)
      -- close Lazy and re-open when starter is ready
      if vim.o.filetype == "lazy" then
        vim.cmd.close()
        vim.api.nvim_create_autocmd("User", {
          pattern = "MiniStarterOpened",
          callback = function()
            require("lazy").show()
          end,
        })
      end

      local starter = require("mini.starter")
      starter.setup(config)

      vim.api.nvim_create_autocmd("User", {
        pattern = "LazyVimStarted",
        callback = function(ev)
          local stats = require("lazy").stats()
          local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
          local pad_footer = ""
          starter.config.footer = pad_footer .. "⚡ Neovim loaded " .. stats.loaded .. " plugins in " .. ms .. "ms"
          if vim.bo[ev.buf].filetype == "ministarter" then
            pcall(starter.refresh)
          end
        end,
      })
    end,
  },
}
