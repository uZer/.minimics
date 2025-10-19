return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  -- cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
  config = function()
    require("nvim-treesitter.configs").setup({
      auto_install = true,
      ensure_installed = {
        "bash",
        "dockerfile",
        "go",
        "gomod",
        "gosum",
        "hyprlang",
        "json",
        "jsonnet",
        "liquidsoap",
        "lua",
        "markdown",
        "markdown_inline",
        "python",
        "terraform",
        "toml",
        "vimdoc",
        "yaml",
      },
      -- sync_install = true,
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
