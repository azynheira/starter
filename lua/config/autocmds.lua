-- Turn off paste mode when leaving insert
vim.api.nvim_create_autocmd("InsertLeave", {
  pattern = "*",
  command = "set nopaste",
})

-- Disable the concealing in some file formats
-- The default conceallevel is 3 in LazyVim
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "json", "jsonc", "markdown" },
  callback = function()
    vim.opt.conceallevel = 0
  end,
})

-- Show errors and warnings in a floating window
vim.api.nvim_create_autocmd("CursorHold", {
  callback = function()
    vim.diagnostic.open_float(nil, { focusable = false, source = "if_many" })
  end,
})

-- Copy clipboard on FocusLost
vim.api.nvim_create_autocmd("FocusLost", {
  desc = "Copy to Clipboard on FocusLost",
  callback = function()
    vim.fn.setreg("+", vim.fn.getreg("0"))
  end,
})
