local scrollbar = require('scrollbar')

local options = {
  hide_if_all_visible = true,
  show_in_active_only = true,
  throttle_ms = 50,
  handlers = {
    gitsigns = true,
  },
  handle = {
    color_nr = "NONE", -- disable cterm
    highlight = "ScrollbarHandle", -- dedicated color instead of CursorColumn...
  },
}

scrollbar.setup(options)
