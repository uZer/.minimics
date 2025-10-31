return {
  {
    'linrongbin16/lsp-progress.nvim',
    config = function()
      require('lsp-progress').setup({})

      -- listen for LSP progress updates and refresh lualine
      local group = vim.api.nvim_create_augroup("lualine_augroup", { clear = true })
      vim.api.nvim_create_autocmd("User", {
        group = group,
        pattern = "LspProgressStatusUpdated",
        callback = function()
          require("lualine").refresh()
        end,
      })
    end,
  },
  {
    'nvim-lualine/lualine.nvim',
    dependencies = {
      'ojroques/nvim-bufdel',
      'lewis6991/gitsigns.nvim',
      'mfussenegger/nvim-lint',
    },
    opts = function()
      -- define diff source safely
      local function diff_source()
        local signs = vim.b.gitsigns_status_dict
        if signs then
          return {
            added = signs.added,
            modified = signs.changed,
            removed = signs.removed,
          }
        end
        return nil
      end

      -- linter display helper
      local function active_linters()
        local lint = require('lint')
        local linters = lint._resolve_linter_by_ft(vim.bo.filetype)
        if not linters or #linters == 0 then
          return ''
        end
        return table.concat(linters, '  ')
      end

      -- LSP progress display helper
      local function lsp_status()
        local progress = require("lsp-progress")
        return progress.progress({
          max_size = 80,
          format = function(messages)
            local clients = vim.lsp.get_clients()
            if #messages > 0 then
              return table.concat(messages, " ")
            end
            local names = {}
            for _, client in ipairs(clients) do
              if client and client.name ~= "" then
                table.insert(names, 1, client.name)
              end
            end
            return table.concat(names, "  ")
          end,
        })
      end

      return {
        options = {
          component_separators = { left = '', right = '' },
          section_separators = { left = '', right = '' },
          disable_filetypes = { "NvimTree", "lazy", "mason", "_.*" },
          extensions = { 'lazy', 'nvim-tree', 'mason' },
          ignore_focus = { "NvimTree", "lazy", "mason", "_.*" },
          theme = 'pywal16-nvim',
          globalstatus = true,
        },

        sections = {
          lualine_a = {
            'mode'
          },
          lualine_b = {
            -- {
            --   'branch'
            -- },
            {
              'diff',
              source = diff_source
            },
          },
          lualine_c = {
            {
              'filename',
              path = 3,
              newfile_status = true
            },
          },
          lualine_x = {},
          lualine_y = {
            'fileformat',
            'encoding',
          },
          lualine_z = {
            'selectioncount',
            'searchcount',
            'progress',
            'location',
          },
        },

        tabline = {
          lualine_a = {
            {
              'buffers',
              filetype_names = { NvimTree = '', mason = '', lazy = '' },
              mode = 2,
              symbols = { alternate_file = '' },
            },
          },
          lualine_x = {
            {
              'diagnostics',
              sources = { 'nvim_diagnostic' },
              always_visible = false,
            },
            {
              lsp_status,
              icon = { "", align = "left" }
            },
          },
          lualine_y = {
            {
              active_linters,
              icon = { "󰱺", align = "left" }
            },
          },
          lualine_z = {
            {
              'filetype',
              icon = { align = "left" }
            },
          },
        },
      }
    end,
  },
}
