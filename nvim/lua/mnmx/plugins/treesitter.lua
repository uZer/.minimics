return {
  "nvim-treesitter/nvim-treesitter",
  lazy = false,
  branch = "master",
  build = ":TSUpdate",
  cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
  config = function()
    require("nvim-treesitter.configs").setup({
      auto_install = true,
      modules = {}, -- required by TSConfig type checker
      sync_install = false,
      ignore_install = {},
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
        "regex",
        "terraform",
        "toml",
        "vimdoc",
        "yaml",
      },
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
      indent = {
        enable = true,
      },
    })
  end,
}
