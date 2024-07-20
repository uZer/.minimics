return {
  'nvim-lualine/lualine.nvim',
  dependencies = {
    'arkav/lualine-lsp-progress',
    'ojroques/nvim-bufdel'
  },
  opts = {
    options = {
      disable_filetypes = {
        "NvimTree",
        "lazy",
        "mason",
        "_.*",
      },
      extensions = {
        'lazy',
        'nvim-tree',
        'mason',
      },
      ignore_focus = {
        "NvimTree",
        "lazy",
        "mason",
        "_.*",
      },
      theme = 'pywal16-nvim',
      globalstatus = true,
    },
    sections = {
      lualine_c = {
        {
          'filename',
          path = 3, -- use absolute paths with tilde as home
        }
      },
    },

    tabline = {
      lualine_a = {
        {
          'buffers',
          filetype_names = {
            NvimTree = '',
            mason = '',
            lazy = ''
          },
          mode = 2,
          symbols = {
            alternate_file = '',
          }
        }

      },
      lualine_b = {},
      lualine_c = {},
      lualine_x = {
        {
          'lsp_progress',
          -- timer = { lsp_client_name_enddelay = -1 }
        }
      },
      lualine_y = {
        {
          'diagnostics',
          sources = { 'nvim_lsp', 'nvim_diagnostic', 'coc' },
          always_visible = true,

        }
      },
      lualine_z = {},
    },
  }
}
