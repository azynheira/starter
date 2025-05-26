-- Project specific options
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.g.autoformat = true

return {
    {
        "stevearc/conform.nvim",
        opts = {
            formatters_by_ft = {
                java = { "google-java-format" },
                vue = { " EsLintFixAll" },
            },
        },
    },
}

