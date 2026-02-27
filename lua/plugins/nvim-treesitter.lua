-- nvim-treesitter.lua Treesitter related
-- Last Changed:2026-02-27 15:31:29
-- add more treesitter parsers
return {
  { "nvim-treesitter/playground", cmd = "TSPlaygroundToggle" },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "bash",
        "c",
        "cmake",
        "cpp",
        "diff",
        "dockerfile",
        "fish",
        "git_config",
        "git_rebase",
        "gitattributes",
        "gitcommit",
        "gitignore",
        "go",
        "graphql",
        "html",
        "http",
        "javascript",
        "json",
        "jsonc",
        "lua",
        "luadoc",
        "make",
        "markdown",
        "markdown_inline",
        "python",
        "query",
        "regex",
        "rust",
        "sql",
        "tmux",
        "toml",
        "vim",
        "vimdoc",
        "xml",
        "yaml",
      },
      -- matchup = {
      -- 	enable = true,
      -- },

      auto_install = true,

      -- Enable highlighting
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
        use_language_tree = true,
      },
      indent = { enable = true },
      -- https://github.com/nvim-treesitter/playground#query-linter
      query_linter = {
        enable = true,
        use_virtual_text = true,
        lint_events = { "BufWrite", "CursorHold" },
      },

      playground = {
        enable = true,
        disable = {},
        updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
        persist_queries = true, -- Whether the query persists across vim sessions
        keybindings = {
          toggle_query_editor = "o",
          toggle_hl_groups = "i",
          toggle_injected_languages = "t",
          toggle_anonymous_nodes = "a",
          toggle_language_display = "I",
          focus_language = "f",
          unfocus_language = "F",
          update = "R",
          goto_node = "<cr>",
          show_help = "?",
        },
      },
    },
    config = function(_, opts)
      require("nvim-treesitter.config").setup(opts)

      -- MDX
      vim.filetype.add({
        extension = {
          mdx = "mdx",
        },
      })
      vim.treesitter.language.register("markdown", "mdx")
    end,
  },
}
