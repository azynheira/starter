-- nvim-games.lua Games
-- Last Changed:2025-06-04 09:23:19
return {
  {
    "eandrju/cellular-automaton.nvim",
    vim.keymap.set("n", "<leader>Xcr", "<cmd>CellularAutomaton make_it_rain<CR>"),
    vim.keymap.set("n", "<leader>Xcg", "<cmd>CellularAutomaton game_of_life<CR>"),
  },
}
