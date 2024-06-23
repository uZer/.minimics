local slow_format_filetypes = {
  "liquidsoap",
}

require("conform").setup({
  formatters_by_ft = {
    javascript = { { "prettierd", "prettier" } },
    liquidsoap = { "liquidsoap-prettier" }
  },
  format_on_save = function(bufnr)
    if slow_format_filetypes[vim.bo[bufnr].filetype] then
      return
    end
    local function on_format(err)
      if err and err:match("timeout$") then
        slow_format_filetypes[vim.bo[bufnr].filetype] = true
      end
    end

    return { timeout_ms = 200, lsp_format = "fallback" }, on_format
  end,

  format_after_save = function(bufnr)
    if not slow_format_filetypes[vim.bo[bufnr].filetype] then
      return
    end
    return { timeout_ms = 15000, lsp_format = "fallback" }
  end,
})
