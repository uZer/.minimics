return {
  {
    'linrongbin16/lsp-progress.nvim',
    config = function()
      require('lsp-progress').setup()
      -- listen lsp-progress event and refresh lualine
      vim.api.nvim_create_augroup("lualine_augroup", { clear = true })
      vim.api.nvim_create_autocmd("User", {
        group = "lualine_augroup",
        pattern = "LspProgressStatusUpdated",
        callback = require("lualine").refresh,
      })
    end,
  },
  {
    'nvim-lualine/lualine.nvim',
    dependencies = {
      'ojroques/nvim-bufdel'
    },
    opts = function()
      local function diff_gitsigns()
        local gitsigns = vim.b.gitsigns_status_dict
        if gitsigns then
          return {
            added = gitsigns.added,
            modified = gitsigns.changed,
            removed = gitsigns.removed
          }
        end
      end
      return {
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
          lualine_b = {
            { 'branch' },
            {
              'diff',
              source = diff_gitsigns
            }
          },
          lualine_c = {
            {
              'filename',
              path = 3, -- use absolute paths with tilde as home
              newfile_status = true,
            }
          },
          lualine_x = {},
          lualine_y = {
            'encoding',
            'fileformat'
          },
          lualine_z = {
            'progress',
            'location',
            'searchcount'
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
              'diagnostics',
              sources        = { 'nvim_diagnostic' },
              always_visible = false,
            },
            {
              function()
                return require("lsp-progress").progress({
                  max_size = 80,
                  format = function(messages)
                    local active_clients =
                        vim.lsp.get_clients()
                    if #messages > 0 then
                      return table.concat(messages, " ")
                    end
                    local client_names = {}
                    for _, client in ipairs(active_clients) do
                      if client and client.name ~= "" then
                        table.insert(
                          client_names,
                          1,
                          client.name
                        )
                      end
                    end
                    return table.concat(client_names, "  ")
                  end,
                })
              end,
              icon = { "", align = "left" },
            },

          },
          lualine_y = {
            {
              function()
                local linters = require('lint')._resolve_linter_by_ft(vim.bo.filetype)
                if not linters or #linters == 0 then
                  -- no linter
                  return ''
                end
                return table.concat(linters, '  ')
              end,
              icon = { "󰱺", align = "left" },
            },
          },
          lualine_z = {
            {
              'filetype',
              icon = { align = "left" }
            }
          },
        },
      }
    end
  },
}
