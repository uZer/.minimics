return {
  'nvim-lualine/lualine.nvim',
  dependencies = {
    'arkav/lualine-lsp-progress',
    'ojroques/nvim-bufdel'
  },
  opts = {
    options = {
      component_separators = { left = '', right = '' },
      section_separators = { left = '', right = '' },
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
      lualine_a = { 'mode' },
      lualine_b = { 'branch', 'diff', 'diagnostics' },
      lualine_c = {
        {
          'filename',
          path = 3, -- use absolute paths with tilde as home
          newfile_status = true,
        }
      },
      lualine_x = {},
      lualine_y = { 'filetype', 'encoding', 'fileformat' },
      lualine_z = { 'progress', 'location' },
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
        }
      },
      lualine_y = {
        {
          'diagnostics',
          sources        = { 'nvim_lsp', 'nvim_diagnostic', 'coc' },
          always_visible = true,

        }
      },
      lualine_z = {
        {
          'searchcount',
        }
      },
    },
  }
}
