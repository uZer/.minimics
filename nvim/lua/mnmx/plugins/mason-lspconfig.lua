local custom_schemas = {}
local handlers = {
  -- The first entry (without a key) will be the default handler
  -- and will be called for each installed server that doesn't have
  -- a dedicated handler.
  function(server_name) -- default handler (optional)
    require("lspconfig")[server_name].setup {}
  end,

  -- Language servers configurations
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
            unusedvariable = true,
            useany = true
          },
          gofumpt = true,
          staticcheck = true,
          usePlaceholders = true,
        }
      }
    }
  end,

  ["jsonls"] = function()
    require("lspconfig").jsonls.setup {
      settings = {
        json = {
          -- Disabling builtin schemaStore
          -- i'm using b0o/SchemaStore plugin for performance and flexibility
          -- reasons, especially to blacklist some files and extend the
          -- official store with extra json schemas
          schemaStore = { enable = false, url = "" },
          -- use b0o/SchemaStore plugin
          -- local file modeline should take precedence
          schemas = require('schemastore').json.schemas {
            extra = custom_schemas,
            ignore = {},
          },
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

  ["pylsp"] = function()
    require 'lspconfig'.pylsp.setup {
      settings = {
        pylsp = {
          plugins = {
            pycodestyle = {
              -- ignore = { 'W391' },
              maxLineLength = 120
            }
          }
        }
      }
    }
  end,

  ["yamlls"] = function()
    require("lspconfig").yamlls.setup {
      settings = {
        yaml = {
          -- Disabling builtin schemaStore
          -- i'm using b0o/SchemaStore plugin for performance and flexibility
          -- reasons, especially to blacklist some files and extend the
          -- official store with extra json schemas
          schemaStore = { enable = false, url = "" },
          -- use b0o/SchemaStore plugin
          -- local file modeline should take precedence
          schemas = require('schemastore').yaml.schemas {
            extra = custom_schemas,
            ignore = {},
          },
          completion = true,
          -- keyOrdering = true,
          hover = true,
          validate = { enable = true },
        }
      }
    }
  end,
}

return {
  'williamboman/mason-lspconfig.nvim',
  dependencies = {
    'williamboman/mason.nvim',
    'neovim/nvim-lspconfig',
    'b0o/SchemaStore.nvim',
  },
  opts = {
    ensure_installed = {
      "ansiblels",
      "bashls",
      "clangd",
      "cssls",
      "dockerls",
      "emmet_ls",
      "eslint",
      "golangci_lint_ls",
      "gopls",
      "helm_ls",
      "html",
      "jedi_language_server",
      "jqls",
      "jsonls",
      "jsonnet_ls",
      "lua_ls",
      "marksman",
      "pylsp",
      "pyright",
      "spectral",
      "sqlls",
      "svelte",
      "taplo",
      "terraformls",
      "vimls",
      "yamlls",
    },
    -- "ansible-lint",
    -- "flake8",
    -- "gitlab_ci_ls", -- way too slow to install
    -- "gitleaks",
    -- "gitlint",
    -- "glsl",
    -- "gofumpt",
    -- "golangci-lint",
    -- "hadolint",
    -- "htmlhint",
    -- "isort",
    -- "jsonlint",
    -- "jsonnetfmt",
    -- "luacheck",
    -- "luaformatter",
    -- "markdownlint",
    -- "markuplint",
    -- "nginx_language_server", -- can't work with python 3.12 yet!
    -- "pint",
    -- "prettierd",
    -- "shellcheck",
    -- "shellharden",
    -- "shfmt",
    -- "sqlfmt",
    -- "stylua",
    -- "systemdlint",
    -- "tsserver", -- half renamed to ts_ls, waiting for the end of the mess
    -- "tflint",
    -- "tfsec",
    -- "yamlfix",
    -- "yamlfmt",
    -- "yamllint",
    automatic_installation = true,
    handlers = handlers,
  },
  priority = 20,
}

-- local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()
