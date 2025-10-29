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
      lsp_format = "first"
    },
    formatters_by_ft = {
      ["*"] = { "trim_whitespace" },
      ua = { "stylua" },
      go = { "goimports", "gofmt" },
      jsonnet = { "jsonnetfmt" },
      liquidsoap = { "liquidsoap-prettier" },
    },
    -- format_on_save = {
    --   timeout_ms = 500,
    --   lsp_format = "fallback",
    -- },
    format_on_save = function(bufnr)
      if slow_format_filetypes[vim.bo[bufnr].filetype] then
        return
      end
      local function on_format(err)
        if err and err:match("timeout$") then
          slow_format_filetypes[vim.bo[bufnr].filetype] = true
        end
      end

      return { timeout_ms = 5000, lsp_format = "fallback" }, on_format
    end,

    format_after_save = function(bufnr)
      if not slow_format_filetypes[vim.bo[bufnr].filetype] then
        return
      end
      return { timeout_ms = 15000, lsp_format = "fallback" }
    end,
  }
}
