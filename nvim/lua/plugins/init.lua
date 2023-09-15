--
-- PLUGINS
-- Packer.nvim and plugin management
--

-- Make sure packer is installed, perform a git clone otherwise
local ensure_packer = function()
  local fn = vim.fn
  local install_path =
      fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({
      'git', 'clone',
      '--depth', '1',
      'https://github.com/wbthomason/packer.nvim',
      install_path
    })
    vim.api.nvim_command('packadd packer.nvim')
    return true
  end
  return false
end
local packer_bootstrap = ensure_packer()

-- Import associated plugin configuration
local function get_config(plugin_name)
  return string.format('require("plugins.config/%s")', plugin_name)
end

-- Load all plugins
return require('packer').startup(function(use)
  --
  -- Core
  --
  use 'wbthomason/packer.nvim'
  use 'lewis6991/impatient.nvim'

  --
  -- Behavior
  --
  use {
    'aymericbeaumet/vim-symlink',
    requires = {
      'moll/vim-bbye',
    }
  }
  use 'ojroques/nvim-bufdel'
  use {
    'numToStr/Comment.nvim',
    config = get_config('comment'),
  }
  use {
    'm4xshen/autoclose.nvim',
    config = get_config('autoclose'),
  }
  use {
    'ntpeters/vim-better-whitespace',
    config = get_config('vim-better-whitespace'),
  }
  use {
    'notjedi/nvim-rooter.lua',
    config = function() require 'nvim-rooter'.setup() end
  }

  --
  -- Text Enrichment & Interface
  --
  use {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.2',
    config = get_config('telescope'),
    requires = {
      'nvim-lua/plenary.nvim',
      {
        'stevearc/aerial.nvim',
        config = get_config('aerial'),
      }
    }
  }
  use {
    -- 'Yggdroot/indentLine',
    'lukas-reineke/indent-blankline.nvim',
    config = get_config('indent-blankline')
  }
  use {
    'lewis6991/gitsigns.nvim',
    config = get_config('gitsigns'),
  }
  use {
    'petertriho/nvim-scrollbar',
    config = get_config('scrollbar'),
  }
  use {
    'nvim-tree/nvim-tree.lua',
    config = get_config('nvimtree'),
    requires = { 'nvim-tree/nvim-web-devicons' },
    tag = 'nightly' -- optional, updated every week. (see issue #1193)
  }
  use {
    'nvim-lualine/lualine.nvim',
    config = get_config('lualine'),
  }
  use {
    'kdheepak/tabline.nvim',
    config = get_config('tabline'),
  }
  use 'majutsushi/tagbar'
  use {
    'm4xshen/smartcolumn.nvim',
    config = get_config('smartcolumn'),
  }

  --
  -- LSP & Completion
  --
  use {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v1.x',
    requires = {
      -- LSP Support
      { 'neovim/nvim-lspconfig' },
      { 'nvim-lua/plenary.nvim' },
      {
        'williamboman/mason.nvim',
        config = get_config('mason'),
      },
      {
        'williamboman/mason-lspconfig.nvim',
        config = get_config('mason-lspconfig'),
      },

      -- Autocompletion
      {
        'hrsh7th/nvim-cmp',
        config = get_config('nvim-cmp'),
        requires = {
          'onsails/lspkind.nvim',
        }
      },
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'hrsh7th/cmp-nvim-lsp-signature-help' },
      { 'hrsh7th/cmp-buffer' },
      { 'hrsh7th/cmp-cmdline' },
      { 'hrsh7th/cmp-path' },
      { 'hrsh7th/cmp-nvim-lua' },

      -- Snippets
      { 'saadparwaiz1/cmp_luasnip' },
      { 'L3MON4D3/LuaSnip' },
      { 'rafamadriz/friendly-snippets' },
    }
  }

  --
  -- Extra Language support
  --
  use {
    'nvim-treesitter/nvim-treesitter',
    config = get_config('treesitter'),
    run = function()
      local ts_update =
          require('nvim-treesitter.install').update({ with_sync = true })
      ts_update()
    end,
  }
  use {
    'echasnovski/mini.surround',
    config = get_config('mini-surround'),
  }
  use {
    'echasnovski/mini.splitjoin',
    config = get_config('mini-splitjoin'),
  }
  use {
    -- Supercollider
    'davidgranstrom/scnvim',
    config = get_config('scnvim'),
    ft = "supercollider",
  }
  use {
    -- Markdown preview in tui
    "ellisonleao/glow.nvim",
    config = get_config("glow"),
    ft = "markdown",
  }
  use({
    -- Markdown preview in browser
    "iamcco/markdown-preview.nvim",
    run = "cd app && npm install",
    setup = function() vim.g.mkdp_filetypes = { "markdown" } end,
    ft = { "markdown" },
  })
  use {
    'google/vim-jsonnet',
    ft = "jsonnet",
  }
  use 'mcfiredrill/vim-liquidsoap'

  use {
    'hashivim/vim-terraform',
    config = get_config("vim-terraform"),
    ft = "terraform",
  }
  -- use 'robbles/logstash.vim'
  -- use 'davidhalter/jedi-vim'
  -- use 'parkr/vim-jekyll'
  -- use 'Glench/Vim-Jinja2-Syntax'
  -- use 'ekalinin/Dockerfile.vim'
  -- use 'cespare/vim-toml'
  -- use 'juliosueiras/vim-terraform-completion'
  -- use 'PProvost/vim-ps1'
  -- use 'elzr/vim-json'
  -- use 'mogelbrod/vim-jsonpath'
  -- use 'fatih/vim-go'
  -- use 'petrbroz/vim-glsl'
  -- use 'evanleck/vim-svelte'
  -- use 'pangloss/vim-javascript'
  -- use 'HerringtonDarkholme/yats.vim' -- typescript

  --
  -- Colorschemes
  --
  use 'uZer/pywal16.nvim'
  -- use '~/ypi.projects/pywal16.nvim'
  use {
    'NvChad/nvim-colorizer.lua',
    config = get_config('colorizer'),
  }

  -- Automatically set up your configuration after cloning packer.nvim
  if packer_bootstrap then
    require("packer").sync()
  end
end)
