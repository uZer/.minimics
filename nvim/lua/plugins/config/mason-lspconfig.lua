local options = {
  automatic_installation = true,
}

local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()

require("mason-lspconfig").setup(options)
require("mason-lspconfig").setup_handlers({
  -- The first entry (without a key) will be the default handler
  -- and will be called for each installed server that doesn't have
  -- a dedicated handler.
  function (server_name) -- default handler (optional)
    require("lspconfig")[server_name].setup {}
  end,
  ["yamlls"] = function(server_name)
    require("lspconfig")[server_name].setup {
      settings = {
        redhat = {
            telemetry = { enabled = false },
        },
        yaml = {
          keyOrdering = false,
        }
      }
    }
  end,
  ["lua_ls"] = function(server_name)
    require("lspconfig")[server_name].setup {
      settings = {
        Lua = {
          diagnostics = {
            globals = { 'vim' }
          }
        }
      }
    }
  end,
  ["gopls"] = function(server_name)
    require("lspconfig")[server_name].setup {
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
})
