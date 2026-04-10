local slow_format_filetypes = {
  "liquidsoap",
}

return {
  "stevearc/conform.nvim",
  dependencies = {
    "mason-org/mason.nvim",
  },
  init = function()
    vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
  end,
  opts = {
    default_format_opts = {
      lsp_format = "fallback",
    },
    formatters_by_ft = {
      ["*"] = { "trim_whitespace" },
      lua = { "stylua" },
      go = { "goimports", "gofmt" },
      jsonnet = { "jsonnetfmt" },
      liquidsoap = { "liquidsoap-prettier" },
    },

    format_on_save = function(bufnr)
      local ft = vim.bo[bufnr].filetype

      if slow_format_filetypes[ft] then
        return
      end

      return {
        timeout_ms = 5000,
        lsp_format = "fallback",
      }
    end,

    format_after_save = function(bufnr)
      if slow_format_filetypes[vim.bo[bufnr].filetype] then
        return {
          timeout_ms = 15000,
          lsp_format = "fallback",
        }
      end
    end,
  },
}
