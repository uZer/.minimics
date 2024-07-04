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
          schemas = require('schemastore').json.schemas {
            ignore = {
              -- '.eslintrc',
              -- 'package.json',
            },
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

  ["yamlls"] = function()
    require("lspconfig").yamlls.setup {
      settings = {
        redhat = {
          telemetry = { enabled = false },
        },
        schemaStore = {
          enable = false,
          url = ""
        },
        schemas = require('schemastore').yaml.schemas {
          ignore = {},
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
      "tsserver",
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
    -- "tflint",
    -- "tfsec",
    -- "yamlfix",
    -- "yamlfmt",
    -- "yamllint",
    automatic_installation = true,
    handlers = handlers,
  }
}

-- local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()
