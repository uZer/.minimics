vim.g.indentLine_setColors = 0 -- Use general colorscheme

local options = {
  bufname_exclude = { "_.*", "Mason.*" },
  -- buftype_exclude = { "help", "terminal", "nofile", "quickfix", "prompt" },
  char = '¦',
  char_blankline = '¦',
  show_current_context = true,
  show_current_context_start = true,
  show_current_context_start_on_current_line = true,
  use_treesitter = true,
  use_treesitter_scope = true,
  viewport_buffer = 300,
}

require("indent_blankline").setup(options)
