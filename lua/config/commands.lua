-- commands.lua Own commands
-- Last Changed:2025-06-09 09:05:41

-- Shorten function name
local command = vim.api.nvim_create_user_command
local opts = { noremap = true, silent = true }
local keymap = function(mode, keys, cmd, options)
  options = options or {}
  options = vim.tbl_deep_extend("force", opts, options)
  vim.api.nvim_set_keymap(mode, keys, cmd, options)
end

-- :SublimeMerge
command("SublimeMerge", function()
  vim.cmd("execute 'silent !smerge pwd'")
end, {})
keymap("n", "<leader>oS", ":SublimeMerge<cr>", { desc = "SublimeMerge" })

-- Convert markdown file to pdf using pandoc
command("MdToPdf", 'execute \'silent !pandoc "%" --listings -H ~/.config/pandoc/listings-setup.tex -o "%:r.pdf"\'', {})
command(
  "MdToPdfNumbered",
  'execute \'silent !pandoc "%" --listings -H ~/.config/pandoc/listings-setup.tex -o "%:r.pdf" --number-sections\'',
  {}
)
command("MdToPdfWatch", function()
  if _G.fswatch_job_id then
    print("Fswatch job already running.")
    return
  end
  vim.cmd(
    'execute \'silent !pandoc "%" --listings -H ~/.config/pandoc/listings-setup.tex -L ~/.config/pandoc/pagebreak.lua --include-in-header ~/.config/pandoc/header.tex -o "%:r.pdf"\''
  )
  local cmd = string.format(
    'fswatch -o "%s" | xargs -n1 -I{} pandoc "%s" --listings -H ~/.config/pandoc/listings-setup.tex -L ~/.config/pandoc/pagebreak.lua --include-in-header ~/.config/pandoc/header.tex -o "%s.pdf"',
    vim.fn.expand("%:p"),
    vim.fn.expand("%:p"),
    vim.fn.expand("%:r")
  )
  _G.fswatch_job_id = vim.fn.jobstart(cmd)
  if _G.fswatch_job_id ~= 0 then
    print("Started watching file changes.")
    vim.cmd("execute 'silent !zathura \"%:r.pdf\" & ~/scripts/focus_app zathura'")
  else
    print("Failed to start watching file changes.")
  end
end, {})

-- Stop watching markdown file changes
command("StopMdToPdfWatch", function()
  if _G.fswatch_job_id then
    vim.fn.jobstop(_G.fswatch_job_id)
    print("Stopped watching file changes.")
    _G.fswatch_job_id = nil
  else
    print("No fswatch process found.")
  end
end, {})

vim.keymap.set("n", "<leader>mw", function()
  if _G.fswatch_job_id then
    vim.cmd("StopMdToPdfWatch")
  else
    vim.cmd("MdToPdfWatch")
  end
end, { desc = "Custom Command: Convert MD to PDF - Toggle Watch" })

-- Convert markdown file to docx using pandoc
command("MdToDocx", 'execute \'silent !pandoc "%" -o "%:r.docx"\'', {})

-- Convert markdown file to Beamer presentation using pandoc
command("MdToBeamer", 'execute \'silent !pandoc "%" -t beamer -o "%:r.pdf"\'', {})

-- Reveal file in finder without changing the working dir in vim
command("RevealInFinder", "execute 'silent !open -R \"%\"'", {})
keymap("n", "<leader>;", ":RevealInFinder<cr>", { desc = "Custom command: Reveal in Finder" })

-- Code Run Script
command("CodeRun", function()
  -- vim.cmd("execute '!~/scripts/code_run \"%\"'")
  require("noice").redirect("execute '!~/scripts/code_run \"%\"'")
end, {})
keymap("n", "<leader>cr", ":CodeRun<cr>", { desc = "Custom command: Run code - own script" })

-- toggle more in the SimpleStatusline
vim.api.nvim_create_user_command("StatusMoreInfo", function()
  _G.show_more_info = not _G.show_more_info
  -- vim.g.show_more_info = not vim.g.show_more_info
  vim.cmd("redrawstatus!")
end, {})
keymap("n", "<leader>ti", ":StatusMoreInfo<cr>", { desc = "Custom command: Status more info" })

-- Other Commands
command("YankCwd", function()
  local cwd = vim.fn.getcwd()
  vim.cmd(string.format("call setreg('*', '%s')", cwd))
  print("Cwd copied to clipboard!")
end, {})
keymap("n", "<leader>cP", "<cmd>YankCwd<cr>", { desc = "Custom command: Yank current dir" })

-- open same file in nvim in a new tmux pane
vim.api.nvim_create_user_command("NewTmuxNvim", function()
  if os.getenv("TERM_PROGRAM") == "tmux" and vim.fn.expand("%"):len() > 0 then
    -- vim.cmd("execute 'silent !tmux new-window nvim %'")
    vim.cmd("execute 'silent !tmux split-window -h nvim %'")
  else
    print("Nothing to open...")
  end
end, {})
keymap("n", "<leader>on", "<cmd>NewTmuxNvim<cr>", { desc = "Custom command: Same file in TMUX window" })

-- new (tmux or terminal) window at current working directory
command("NewTerminalWindow", function()
  local cwd = vim.fn.getcwd()
  vim.cmd(
    string.format(
      "execute 'silent !open -na alacritty --args -o window.dimensions.columns=102 -o window.dimensions.lines=48 -o window.position.y=0 -o window.position.x=1600 --working-directory \"%s\"'",
      cwd
    )
  )
end, {})
keymap("n", "<leader>\\", "<cmd>NewTerminalWindow<cr>", { desc = "Custom command: Open Terminal in cwd" })

command("OpenGithubRepo", function()
  local mode = vim.api.nvim_get_mode().mode
  local text = ""

  if mode == "v" then
    text = vim.getVisualSelection()
    vim.fn.setreg('"', text) -- yank the selected text
  else
    local node = vim.treesitter.get_node() --[[@as TSNode]]
    -- Get the text of the node
    text = vim.treesitter.get_node_text(node, 0)
  end

  if text:match("^[%w%-%.%_%+]+/[%w%-%.%_%+]+$") == nil then
    local msg = string.format("OpenGithubRepo: '%s' Invalid format. Expected 'foo/bar' format.", text)
    vim.notify(msg, vim.log.levels.ERROR)
    return
  end

  local url = string.format("https://www.github.com/%s", text)
  print("Opening", url)
  vim.ui.open(url)
end, {})
vim.keymap.set({ "n", "v" }, "<leader>og", "<cmd>OpenGithubRepo<cr>", { desc = "Custom command: Open Github Repo" })

-- Command to preview files using macOS Quick Look
command("QuickLookPreview", function()
  local mode = vim.api.nvim_get_mode().mode
  local filepath = ""

  if mode == "v" then
    filepath = vim.getVisualSelection()
  else
    filepath = vim.fn.expand("<cfile>")
  end

  -- Get current buffer's directory
  local buf_dir = vim.fn.expand("%:p:h")

  -- Resolve relative path against current buffer's directory
  filepath = vim.fn.resolve(buf_dir .. "/" .. filepath)

  -- Check if file exists
  if vim.fn.filereadable(filepath) == 0 then
    local msg = string.format("QuickLookPreview: File '%s' does not exist", filepath)
    vim.notify(msg, vim.log.levels.ERROR)
    return
  end

  -- Preview file with Quick Look
  vim.system({ "qlmanage", "-p", filepath }, {
    stdout = false,
    stderr = false,
  })
  vim.defer_fn(function()
    vim.system({ "osascript", "-e", 'tell application "qlmanage" to activate' })
  end, 200)
end, {})
vim.keymap.set(
  { "n", "v" },
  "<leader>pv",
  "<cmd>QuickLookPreview<cr>",
  { desc = "Custom command: Quick Look File Preview" }
)

command("LuaInspect", function()
  local sel = vim.fn.mode() == "v" and vim.getVisualSelection() or nil
  if sel then
    local chunk, load_error = load("return " .. sel)
    if chunk then
      local success, result = pcall(chunk)
      if success then
        vim.notify(vim.inspect(result), vim.log.levels.INFO)
      else
        vim.notify("Error evaluating expression: " .. result, vim.log.levels.ERROR)
      end
    else
      vim.notify("Error loading expression: " .. load_error, vim.log.levels.ERROR)
    end
  else
    vim.api.nvim_feedkeys(":lua print(vim.inspect())", "n", true)
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Left><Left>", true, false, true), "n", true)
  end
end, {})
vim.keymap.set({ "n", "v" }, "<leader>pi", "<cmd>LuaInspect<cr>", { desc = "Custom command: Lua Inspect" })

command("LuaPrint", function()
  if vim.fn.mode() == "v" then
    vim.cmd("LuaInspect")
  else
    vim.api.nvim_feedkeys(":lua print()", "n", true)
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Left>", true, false, true), "n", true)
  end
end, {})
vim.keymap.set({ "n", "v" }, "<leader>pp", "<cmd>LuaPrint<cr>", { desc = "Custom command: Lua Print" })

command("TypstWatch", function()
  local input_file = vim.fn.expand("%:p")
  local output_file = vim.fn.expand("%:r") .. ".pdf"
  -- local cmd = string.format("typst watch %s --open sioyek", input_file)
  local cmd = string.format('typst watch "%s"', input_file)

  if _G.typst_job_id then
    vim.fn.jobstart({ "sioyek", string.format('"%s"', output_file) })
    -- vim.fn.jobstart({ "sioyek", string.format('"%s"', output_file) }, { detach = true })
    print("Typst watch job already running.")
    return
  end

  _G.typst_job_id = vim.fn.jobstart(cmd)

  if _G.typst_job_id ~= 0 then
    print("Started watching Typst file changes.")

    vim.fn.jobstart({ "sioyek", output_file })
  -- vim.cmd(string.format("execute 'silent !zathura \"%s\" & ~/scripts/focus_app zathura'", output_file))
  else
    print("Failed to start watching Typst file changes.")
  end
end, {})

command("TypstWatchStop", function()
  if _G.typst_job_id then
    vim.fn.jobstop(_G.typst_job_id)
    print("Stopped watching file changes.")
    _G.typst_job_id = nil
  else
    print("No typst watch process found.")
  end
end, {})

vim.keymap.set("n", "<leader>mt", function()
  if _G.typst_job_id then
    vim.cmd("TypstWatchStop")
  else
    vim.cmd("TypstWatch")
  end
end, { desc = "Custom command: TypstWatch Toggle" })

-- Function to shuffle lines
local function shuffle_lines()
  -- Get the start and end line numbers of the visual selection
  local start_line = vim.fn.line("'<")
  local end_line = vim.fn.line("'>")

  -- Extract the lines within the selection
  local lines = vim.fn.getline(start_line, end_line)

  -- Shuffle the lines
  math.randomseed(os.time())
  for i = #lines, 2, -1 do
    local j = math.random(i)
    lines[i], lines[j] = lines[j], lines[i]
  end

  -- Replace the original lines with the shuffled lines
  vim.fn.setline(start_line, lines)
end

command("ShuffleLines", shuffle_lines, { range = true })

-- Command to copy bullet list without bullets
command("CopyNoBullets", function(cmd_opts)
  local lines = vim.fn.getline(cmd_opts.line1, cmd_opts.line2)
  -- if type(lines) ~= "table" then
  if type(lines) == "string" then
    lines = { lines }
  end
  local text = table.concat(lines, "\n")

  if #text > 0 then
    -- Remove "- " from each line while preserving indentation
    local cleaned_text = text:gsub("(%s*)%- ?", "%1")
    vim.fn.setreg("+", cleaned_text)
    print("Bullet list copied without bullets!")
  end
end, { range = true })

keymap("v", "<leader>cb", ":CopyNoBullets<CR>", { desc = "Custom Command: Copy without bullets" })

command("ConvertHEXtoUpper", function()
  vim.cmd("'<,'>s/#[0-9A-Fa-f]\\{3,8}\\(\"\\)\\?/\\=toupper(submatch(0))")
end, { range = true })

keymap("v", "<leader>ch", ":ConvertHEXtoUpper<cr>", { desc = "Custom Command: Covert HEX color to Uppercase" })

command("ToggleSpellCheck", function()
  if vim.wo.spell then
    vim.wo.spell = false
    vim.notify("Spell checking disabled", vim.log.levels.INFO)
  else
    vim.wo.spell = true
    vim.cmd("setlocal spell spelllang=en_us")
    vim.notify("Spell checking enabled", vim.log.levels.INFO)
  end
end, {})
keymap("n", "<leader>tS", ":ToggleSpellCheck<cr>", { desc = "Toggle spell checking" })

-- Command to remove trailing whitespace
command("TrimTrailingWhitespace", function(cmd_opts)
  local start_line, end_line

  if cmd_opts.range == 0 then
    start_line = vim.fn.line(".")
    end_line = start_line
  else
    start_line = cmd_opts.line1
    end_line = cmd_opts.line2
  end

  -- Execute the substitution command
  vim.cmd(string.format("silent %d,%ds/\\s\\+$//e", start_line, end_line))
  vim.cmd("nohlsearch")

  -- Provide feedback
  local count = end_line - start_line + 1
  local message = "Trimmed trailing whitespace from " .. count .. " line" .. (count > 1 and "s" or "")
  vim.notify(message, vim.log.levels.INFO)
end, { range = true })

vim.keymap.set({ "n", "v" }, "<leader>cw", ":TrimTrailingWhitespace<cr>", { desc = "Trim trailing whitespace" })

-- Command to shuffle paragraphs within a visual selection
command("ShuffleParagraphs", function(cmd_opts)
  local start_line = cmd_opts.line1
  local end_line = cmd_opts.line2

  -- Get selected lines
  local lines = vim.api.nvim_buf_get_lines(0, start_line - 1, end_line, false)

  -- Identify paragraph boundaries within selection
  local paragraphs = {}
  local current_paragraph = {}

  for _, line in ipairs(lines) do
    table.insert(current_paragraph, line)
    -- Empty line marks paragraph boundary
    if line:match("^%s*$") then
      table.insert(paragraphs, current_paragraph)
      current_paragraph = {}
    end
  end

  -- Add the last paragraph if it's not empty
  if #current_paragraph > 0 then
    table.insert(paragraphs, current_paragraph)
  end

  -- Shuffle paragraphs using Fisher-Yates algorithm
  math.randomseed(os.time())
  for i = #paragraphs, 2, -1 do
    local j = math.random(i)
    paragraphs[i], paragraphs[j] = paragraphs[j], paragraphs[i]
  end

  -- Flatten paragraphs back into lines
  local shuffled_lines = {}
  for _, paragraph in ipairs(paragraphs) do
    for _, line in ipairs(paragraph) do
      table.insert(shuffled_lines, line)
    end
  end

  -- Replace only the selected portion with shuffled paragraphs
  vim.api.nvim_buf_set_lines(0, start_line - 1, end_line, false, shuffled_lines)
end, { range = true })
