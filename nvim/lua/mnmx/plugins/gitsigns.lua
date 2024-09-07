return {
  'lewis6991/gitsigns.nvim',
  keys = {
    { "<leader>df", "<cmd>Gitsigns toggle_linehl<cr>", desc = "Gitsigns toggle git diff" },
  },
  opts = {
    current_line_blame = true,
    current_line_blame_formatter = " <abbrev_sha> <author> <author_time:%Y/%m/%d %H:%M>  <summary>",
    numhl = true,
  }
}
