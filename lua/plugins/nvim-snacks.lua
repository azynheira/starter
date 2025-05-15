-- stylua: ignore
return {
  { "snacks.nvim",
    opts = {
      words = { enabled = false },
      image = { enabled = true },
      notifier = { enabled = true },
      -- show hidden files in snacks.explorer
      explorer = {
        hidden = true,
        ignored = true,
        include = {".*"},
        exclude = { "node_modules", ".git" , ".hg"},
      },
      picker = {
        hidden = true,
        ignored = true,
        exclude = { "node_modules", ".git", ".hg"},
      },
      sources = {
        explorer = {
          exclude = { '.git', ".hg" },
          include = { '.*' },
        },
      },
    }
  }
}
