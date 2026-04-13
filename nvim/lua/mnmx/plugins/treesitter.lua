return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    event = { "BufReadPre", "BufNewFile" },
    build = ":TSUpdate",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-context",
      "nvim-treesitter/nvim-treesitter-textobjects",
      "MeanderingProgrammer/treesitter-modules.nvim",
    },
    config = function()
      local languages = {
        "bash",
        "c",
        "css",
        "diff",
        "dockerfile",
        "gitignore",
        "go",
        "gomod",
        "gosum",
        "graphql",
        "html",
        "hyprlang",
        "javascript",
        "jsdoc",
        "json",
        "jsonnet",
        "liquidsoap",
        "lua",
        "lua",
        "luadoc",
        "luap",
        "markdown",
        "markdown_inline",
        "printf",
        "python",
        "query",
        "regex",
        "regex",
        "sql",
        "terraform",
        "toml",
        "toml",
        "tsx",
        "typescript",
        "vim",
        "vimdoc",
        "xml",
        "yaml",
      }

      -- Covers ensure_installed + highlight + indent + fold + incremental selection
      require("treesitter-modules").setup({
        ensure_installed = languages,
        ignore_install = {},
        sync_install = false,
        auto_install = false,

        highlight = {
          enable = true,
        },
        indent = {
          enable = true,
        },
        fold = {
          enable = true,
        },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "gnn",
            node_incremental = "grn",
            scope_incremental = "grc",
            node_decremental = "grm",
          },
        },
      })

      -- Fold settings
      vim.opt.foldmethod = "expr"
      vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"

      -- textobjects plugin now uses its own setup + keymaps
      require("nvim-treesitter-textobjects").setup({
        move = {
          set_jumps = false,
        },
        select = {
          lookahead = true,
        },
      })
    end,
  },
}
