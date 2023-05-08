local options = {
  ensure_installed = {
    "ansible-language-server",
    "ansible-lint",
    "bash-language-server",
    "clangd",
    "css-lsp",
    "dockerfile-language-server",
    "emmet-ls",
    "flake8",
    "gitlint",
    "glow",
    "gofumpt",
    "golangci-lint",
    "golangci-lint-langserver",
    "gopls",
    "html-lsp",
    "jedi-language-server",
    "jq",
    "jq-lsp",
    "json-lsp",
    "jsonlint",
    "jsonnet-language-server",
    "lua-language-server",
    "luacheck",
    "luaformatter",
    "markdownlint",
    "marksman",
    "pyright",
    "shellcheck",
    "spectral-language-server",
    "svelte-language-server",
    "taplo",
    "terraform-ls",
    "tflint",
    "vim-language-server",
    "yaml-language-server",
    "yamlfmt",
    "yamllint",
  },
  max_concurrent_installers = 10,
  ui = {
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗"
    }
  }
}

require("mason").setup(options)

vim.api.nvim_create_user_command("MasonInstallAll", function()
  vim.cmd("MasonInstall " .. table.concat(options.ensure_installed, " "))
end, {})
