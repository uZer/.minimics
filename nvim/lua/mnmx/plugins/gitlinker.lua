return {
  "linrongbin16/gitlinker.nvim",
  cmd = "GitLink",
  opts = function()
    return {
      router = {
        browse = {
          ["^gitlab%.dnm%.radiofrance%.fr"] = require("gitlinker.routers").gitlab_browse,
        },
        blame = {
          ["^gitlab%.dnm%.radiofrance%.fr"] = require("gitlinker.routers").gitlab_blame,
        },
      },
      -- Neovim ≥ 0.10 native osc52
      clipboard_override = function(url)
        require("vim.ui.clipboard.osc52").copy("+")({ url })
      end,
    }
  end,
  keys = {
    { "gy", "<cmd>GitLink blame<cr>",  mode = { "n", "v" }, desc = "Yank git blame link" },
    { "gY", "<cmd>GitLink! blame<cr>", mode = { "n", "v" }, desc = "Open git blame link" },
  },
}
