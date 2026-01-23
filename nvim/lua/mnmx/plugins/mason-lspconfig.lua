local custom_schemas = {
  {
    name = "Kubernetes Strict",
    description = "Kubernetes JSON Schema - strict",
    url = "kubernetes",
    fileMatch = {
      "*.k8s.yaml",
      "*.k8s.yml",
      "*.kubernetes.yaml",
      "gitops/apps/**/*.yaml",
      "gitops/apps/**/*.yml"
    },
  },
}

return {
  'mason-org/mason-lspconfig.nvim',
  dependencies = {
    'mason-org/mason.nvim',
    'neovim/nvim-lspconfig',
    'b0o/SchemaStore.nvim',
  },
  config = function()
    local mason_lspconfig = require("mason-lspconfig")
    mason_lspconfig.setup({
      automatic_installation = true,
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
        "jqls",
        "jsonls",
        "jsonnet_ls",
        "lua_ls",
        "marksman",
        "pylsp",
        "pyright",
        "sqlls",
        "svelte",
        "taplo",
        "terraformls",
        "vimls",
        "yamlls",
      },
      -- "gitlab_ci_ls",
      -- "jedi_language_server",
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
      -- "spectral",
      -- "sqlfmt",
      -- "stylua",
      -- "systemdlint",
      -- "tsserver", -- half renamed to ts_ls, waiting for the end of the mess
      -- "tflint",
      -- "tfsec",
      -- "yamlfix",
      -- "yamlfmt",
      -- "yamllint",
    })
    -- local capabilities = vim.lsp.protocol.make_client_capabilities()
    -- capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities) -- if using nvim-cmp

    vim.lsp.config('dockerls', {
      settings = {
        docker = {
          languageserver = {
            formatter = {
              ignoreMultilineInstructions = true,
            }
          }
        }
      }
    })

    vim.lsp.config('eslint', {
      on_attach = function(_, bufnr)
        vim.api.nvim_create_autocmd("BufWritePre", {
          buffer = bufnr,
          command = "EslintFixAll",
        })
      end,
    })

    vim.lsp.config('gopls', {
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
    })

    vim.lsp.config('jsonls', {
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
    })

    vim.lsp.config('lua_ls', {
      settings = {
        Lua = {
          diagnostics = {
            globals = { 'vim' }
          }
        }
      }
    })

    vim.lsp.config('pylsp', {
      settings = {
        pylsp = {
          configurationSources = { "flake8" },
          -- plugins = {
          --   autopep8 = { enabled = false },
          --   flake8 = {
          --     enabled = true,
          --   },
          --   jedi_completion = { enabled = false },
          --   jedi_definition = { enabled = false },
          --   mccabe = { enabled = false },
          --   preload = { enabled = false },
          --   pycodestyle = { enabled = false },
          --   pydocstyle = { enabled = false },
          --   pylint = { enabled = false },
          --   rope_autoimport = { enabled = false },
          --   ruff = { enabled = false },
          -- }
        }
      }
    })

    vim.lsp.config('yamlls', {
      settings = {
        redhat = {
          telemetry = { enabled = false, },
        },
        -- settings are defined here:
        -- https://github.com/redhat-developer/yaml-language-server?tab=readme-ov-file#language-server-settings
        yaml = {
          format = {
            enable = true,
            -- singleQuote = true, # default false
          },
          validate = true,
          hover = true,
          completion = true,

          -- Disabling builtin schemaStore
          -- i'm using b0o/SchemaStore plugin for performance and flexibility
          -- reasons, especially to blacklist some files and extend the
          -- official store with extra json schemas
          schemaStore = {
            enable = false,
            url = ""
          },
          -- use b0o/SchemaStore plugin
          -- local file modeline should take precedence
          schemas = require('schemastore').yaml.schemas {
            extra = custom_schemas,
            ignore = {},
          },

          kubernetesCRDStore = {
            enable = true,
            url = "https://raw.githubusercontent.com/datreeio/CRDs-catalog/main"
          },
        }
      }
    })
  end,
  -- default handler
}

-- local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()
