return {
  "chentoast/marks.nvim",
  event = "VeryLazy",
  opts = {
    mappings = {

      preview = "mm",
      prev = "mk",
      next = "mj",

      -- bookmarks won't persist after nvim restart
      prev_bookmark = "mK",
      next_bookmark = "mJ",
      annotate = "<C-w>m", -- only works with bookmarks (marks 0-9)
    },
  },
}
