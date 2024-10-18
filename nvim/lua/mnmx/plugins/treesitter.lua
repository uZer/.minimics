return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  -- cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
  config = function()
    local configs = require("nvim-treesitter.configs")

    configs.setup({
      ensure_install = { "lua", "vimdoc", "markdown_inline" },
      -- sync_install = true,
      auto_install = true,
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
      indent = {
        enable = true
      },
    })
  end,
}
