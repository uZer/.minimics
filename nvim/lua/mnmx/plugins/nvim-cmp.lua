return {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",

  dependencies = {
    -- LSP
    "neovim/nvim-lspconfig",
    "mason-org/mason-lspconfig.nvim",
    "b0o/SchemaStore.nvim",

    -- Completion sources
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-nvim-lsp-signature-help",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-cmdline",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-nvim-lua",
    {
      "davidsierradz/cmp-conventionalcommits",
      ft = "gitcommit",
    },

    -- UI
    "onsails/lspkind.nvim",

    -- Snippets
    "saadparwaiz1/cmp_luasnip",
    "L3MON4D3/LuaSnip",
    "rafamadriz/friendly-snippets",
  },

  opts = function()
    local cmp = require("cmp")
    local luasnip = require("luasnip")
    local lspkind = require("lspkind")

    require("luasnip.loaders.from_vscode").lazy_load()

    return {
      performance = {
        debounce = 60,
        throttle = 30,
        fetching_timeout = 200,
        max_view_entries = 40,
      },

      completion = {
        completeopt = "menu,menuone,noinsert,noselect",
        keyword_length = 2,
      },

      experimental = {
        ghost_text = true, -- inline suggestions
      },

      preselect = cmp.PreselectMode.None, -- strict behavior

      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },

      formatting = {
        format = lspkind.cmp_format({
          mode = "symbol_text",
          maxwidth = 50,
          ellipsis_char = "...",
        }),
      },

      sources = cmp.config.sources({
        { name = "nvim_lsp_signature_help", priority = 1100 },
        { name = "nvim_lsp", priority = 1000 },
        { name = "luasnip", priority = 800 },
        { name = "nvim_lua", priority = 600 },
        { name = "path", priority = 400 },
        { name = "conventionalcommits", priority = 300 },
      }, {
        {
          name = "buffer",
          priority = 100,
          keyword_length = 3,
          option = {
            -- Only use visible buffers (huge perf win)
            get_bufnrs = function()
              local bufs = {}
              for _, win in ipairs(vim.api.nvim_list_wins()) do
                bufs[vim.api.nvim_win_get_buf(win)] = true
              end
              return vim.tbl_keys(bufs)
            end,
          },
        },
      }),

      -- Better sorting
      sorting = {
        priority_weight = 2,
        comparators = {
          cmp.config.compare.exact,
          cmp.config.compare.score,
          cmp.config.compare.recently_used,
          cmp.config.compare.kind,
          cmp.config.compare.length,
          cmp.config.compare.order,
        },
      },

      window = {
        completion = {
          scrollbar = false,
          border = "rounded",
        },
        documentation = {
          border = "rounded",
        },
      },

      mapping = cmp.mapping.preset.insert({

        -- Docs
        ["<C-n>"] = cmp.mapping.scroll_docs(-4),
        ["<C-p>"] = cmp.mapping.scroll_docs(4),

        -- Abort
        ["<C-e>"] = cmp.mapping.abort(),

        -- Complete
        -- Confirm (explicit, safe)
        ["<C-Space>"] = cmp.mapping(function()
          if cmp.visible() then
            cmp.confirm({
              behavior = cmp.ConfirmBehavior.Replace,
              select = true,
            })
          else
            cmp.complete()
          end
        end),

        -- Navigation
        ["<C-j>"] = cmp.mapping.select_next_item(),
        ["<C-k>"] = cmp.mapping.select_prev_item(),

        -- Tab logic (correct hierarchy)
        ["<Tab>"] = cmp.mapping(function(fallback)
          if luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          elseif cmp.visible() then
            cmp.select_next_item()
          else
            fallback()
          end
        end),

        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if luasnip.jumpable(-1) then
            luasnip.jump(-1)
          elseif cmp.visible() then
            cmp.select_prev_item()
          else
            fallback()
          end
        end),
      }),
    }
  end,

  config = function(_, opts)
    local cmp = require("cmp")
    cmp.setup(opts)

    -- Search (/)
    cmp.setup.cmdline("/", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = "buffer" },
      },
    })

    -- Command (:)
    cmp.setup.cmdline(":", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = "path", priority = 1200 },
        { name = "nvim_lsp", priority = 1000 },
      }, {
        { name = "cmdline" },
      }),
    })

    -- Git commit completion
    cmp.setup.filetype("gitcommit", {
      completion = {
        keyword_length = 1, -- trigger early
      },
      sources = cmp.config.sources({
        { name = "conventionalcommits", priority = 1000 },
        { name = "luasnip", priority = 800 },
      }, {
        { name = "buffer", keyword_length = 3, priority = 100 },
      }),
    })
  end,
}
