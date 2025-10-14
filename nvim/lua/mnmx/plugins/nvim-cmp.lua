return {
  --   'VonHeikemen/lsp-zero.nvim',
  --   branch = 'v3.x',
  'hrsh7th/nvim-cmp',
  dependencies = {
    -- LSP Support
    'neovim/nvim-lspconfig',
    'mason-org/mason-lspconfig.nvim',
    'b0o/SchemaStore.nvim',

    -- Autocompletion
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-nvim-lsp-signature-help',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-cmdline',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-nvim-lua',
    'davidsierradz/cmp-conventionalcommits',
    'onsails/lspkind.nvim',

    -- -- Snippets
    'saadparwaiz1/cmp_luasnip',
    'L3MON4D3/LuaSnip',
    'rafamadriz/friendly-snippets',
  },

  opts = function()
    local cmp = require('cmp')
    local lspkind = require('lspkind')
    local luasnip = require('luasnip')

    -- repair tabs in insert mode
    ---@diagnostic disable-next-line: deprecated
    table.unpack = table.unpack or unpack -- Lua 5.1 compatibility

    local has_words_before = function()
      local line, col = table.unpack(vim.api.nvim_win_get_cursor(0))
      return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
    end

    return {
      confirmation = {
        -- completeopt = 'menu,menuone,noinsert,noselect',
        completeopt = 'menu,menuone,noinsert,noselect',
        default_behavior = cmp.ConfirmBehavior.Replace,
      },

      formatting = {
        format = lspkind.cmp_format({
          mode = 'symbol_text',
          maxwidth = 50,
          ellipsis_char = '...',
          before = function(_, vim_item)
            return vim_item
          end
        })
      },

      sources = {
        { name = 'buffer',                 keyword_length = 3 },
        { name = 'path',                   option = { trailing_slash = true }, },
        { name = 'conventionalcommits' },
        { name = 'nvim_lsp' },
        { name = 'nvim_lsp_signature_help' },
        { name = 'nvim_lua' },
        { name = 'luasnip' },
      },

      window = {
        completion = {
          scrollbar = false,
        }
      },

      mapping = {
        ['<C-D>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.scroll_docs(-2)
          else
            fallback()
          end
        end, { "i", "s" }),

        ['<C-F>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.scroll_docs(2)
          else
            fallback()
          end
        end, { "i", "s" }),

        ['<C-Space>'] = cmp.mapping(function(_)
          if cmp.visible() then
            cmp.confirm({
              behavior = cmp.ConfirmBehavior.Replace,
              select = true,
            })
          else
            cmp.complete()
          end
        end, { "i", "s" }),

        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          elseif has_words_before() then
            cmp.complete()
          else
            fallback()
          end
        end, { "i", "s" }),

        ["<S-Tab>"] = cmp.mapping(function()
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          elseif has_words_before() then
            cmp.complete()
          end
        end, { "i", "s" }),

        ["<C-J>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          else
            fallback()
          end
        end, { "i", "s" }),

        ["<C-K>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          else
            fallback()
          end
        end, { "i", "s" }),

        -- Remove mapping of <CR>
        ['<CR>'] = function(fallback) fallback() end
      },
    }
  end,
}
