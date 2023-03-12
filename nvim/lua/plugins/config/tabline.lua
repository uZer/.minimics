local options = {
  -- If lualine is installed tabline will use separators configured in lualine by default.
  max_bufferline_percent = 66, -- set to nil by default, and it uses vim.o.columns * 2/3
  show_tabs_always = true, -- this shows tabs only when there are more than one tab or if the first tab is named
  modified_icon = "+ ", -- change the default modified icon
  modified_italic = true, -- set to true by default; this determines whether the filename turns italic if modified
  show_tabs_only = true, -- this shows only tabs instead of tabs + buffers
}

require("tabline").setup(options)
