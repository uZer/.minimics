return {
  'mfussenegger/nvim-lint',
  config = function()
    local lint = require("lint")

    lint.linters_by_ft = {
      gitcommit = { "commitlint" },
    }

    -- Automatically lint on save or when leaving insert mode
    local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
    vim.api.nvim_create_autocmd({ "BufWritePost", "InsertLeave" }, {
      group = lint_augroup,
      callback = function()
        lint.try_lint()
      end,
    })
  end,
}
