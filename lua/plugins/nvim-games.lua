-- nvim-games.lua Games
-- Last Changed:2025-05-27 07:26:27
return {
  {
    "eandrju/cellular-automaton.nvim",
    vim.keymap.set("n", "<leader>fml", "<cmd>CellularAutomaton make_it_rain<CR>"),
    vim.keymap.set("n", "<leader>fmg", "<cmd>CellularAutomaton game_of_life<CR>"),
  },
}
