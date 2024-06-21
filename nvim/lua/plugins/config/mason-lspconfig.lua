local options = {
  automatic_installation = true,
}

local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()

require("mason-lspconfig").setup(options)
require("mason-lspconfig").setup_handlers({
  -- The first entry (without a key) will be the default handler
  -- and will be called for each installed server that doesn't have
  -- a dedicated handler.
  function(server_name) -- default handler (optional)
    require("lspconfig")[server_name].setup {}
  end,
  ["dockerls"] = function()
    require("lspconfig").dockerls.setup {
      settings = {
        docker = {
          languageserver = {
            formatter = {
              ignoreMultilineInstructions = true,
            }
          }
        }
      }
    }
  end,
  ["eslint"] = function()
    require("lspconfig").eslint.setup {
      on_attach = function(_, bufnr)
        vim.api.nvim_create_autocmd("BufWritePre", {
          buffer = bufnr,
          command = "EslintFixAll",
        })
      end,
    }
  end,
  ["gopls"] = function()
    require("lspconfig").gopls.setup {
      settings = {
        gopls = {
          analyses = {
            nilness = true,
            unusedparams = true,
            unusedwrite = true,
            useany = true
          },
          gofumpt = true,
          staticcheck = true,
        }
      }
    }
  end,
  ["jsonls"] = function()
    require("lspconfig").jsonls.setup {
      settings = {
        json = {
          schemas = require('schemastore').json.schemas(),
          validate = { enable = true },
        }
      }
    }
  end,
  ["lua_ls"] = function()
    require("lspconfig").lua_ls.setup {
      settings = {
        Lua = {
          diagnostics = {
            globals = { 'vim' }
          }
        }
      }
    }
  end,
  ["yamlls"] = function()
    require("lspconfig").yamlls.setup {
      settings = {
        redhat = {
          telemetry = { enabled = false },
        },
        schemaStore = {
          enable = true,
        },
        yaml = {
          completion = true,
          hover = true,
          validate = true,
          -- keyOrdering = true,
        }
      }
    }
  end,
})
