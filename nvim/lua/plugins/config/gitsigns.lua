local options = {
  current_line_blame = true,
  current_line_blame_formatter = " <author>, <author_time:%Y/%m/%d %H:%M>  <abbrev_sha>  <summary>",
  current_line_blame_formatter_opts = {
    relative_time = false,
  },
  signcolumn = true,
  numhl = true,
  linehl = false,
  word_diff = false,
  current_line_blame_opts = {
    virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
  },
}

require('gitsigns').setup(options)
