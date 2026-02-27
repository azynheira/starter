-- nvim-org.lua ORG mode
-- Last Changed:2026-02-27 15:31:47
return {
  {
    "nvim-orgmode/orgmode",
    event = "VeryLazy",
    ft = { "org" },
    config = function()
      -- Setup orgmode
      require("orgmode").setup({
        org_agenda_files = "~/orgfiles/**/*",
        org_default_notes_file = "~/orgfiles/refile.org",
      })

      -- NOTE: If you are using nvim-treesitter with ~ensure_installed = "all"~ option
      -- add ~org~ to ignore_install
      require("nvim-treesitter.config").setup({
        --ensure_installed = "all",
        --ignore_install = { "org" },
      })
    end,
  },
}
