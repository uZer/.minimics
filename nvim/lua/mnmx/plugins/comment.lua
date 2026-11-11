return {
  "numToStr/Comment.nvim",
  opts = {
    -- Neovim >= 0.12 get_parser() returns nil instead of erroring when no parser
    -- exists, which crashes Comment.nvim's treesitter lookup ("[Comment.nvim] nil").
    -- Fall back to the filetype commentstring in that case.
    pre_hook = function(ctx)
      local ok, parser = pcall(vim.treesitter.get_parser, 0)
      if ok and parser then
        return nil
      end
      return require("Comment.ft").get(vim.bo.filetype, ctx.ctype) or vim.bo.commentstring
    end,
    toggler = {
      line = "<leader>c",
      block = "<leader>b",
    },
    opleader = {
      line = "<leader>c",
      block = "<leader>b",
    },
    extra = {
      above = "<leader>cO",
      below = "<leader>co",
      eol = "<leader>cA",
    },
  },
}
