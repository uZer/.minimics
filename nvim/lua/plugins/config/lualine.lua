local options = {
  options = {
    ignore_focus = {
      "NvimTree",
      "Mason",
      "_.*",
    },
    globalstatus = true,
    theme = 'pywal-nvim',
  },
  sections = {
    lualine_c = {
      {
        'filename',
        path = 3, -- use absolute paths with tilde as home
      }
    },
  },
}

require("lualine").setup(options)
