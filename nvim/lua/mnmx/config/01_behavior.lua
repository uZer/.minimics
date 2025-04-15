--
-- Behaviour options 
--

-- Show special chars
vim.opt.list = true
vim.opt.listchars = "tab:| ,trail:-,nbsp:+"

-- Indentation and tabulations
vim.opt.tabstop = 2        -- a tab is two spaces
vim.opt.shiftwidth = 2     -- indentation is two spaces
vim.opt.expandtab = true   -- no tab char in the files, use spaces
vim.opt.autoindent = true  -- keep current indentation after pressing <cr>
vim.opt.smartindent = true -- indent accordingly to the syntax
vim.opt.smarttab = true    -- indent by shiftwidth spaces when pressing tab

-- Folding and Conceal
vim.opt.foldenable = false -- disable folding by default

-- Search
vim.opt.hlsearch = true   -- highlight search patterns
vim.opt.incsearch = true  -- go to matches when searching
vim.opt.ignorecase = true -- ignore case in search pattern
vim.opt.smartcase = true  -- check case if the pattern contains uppercase chars

-- Copy / Paste settings
vim.api.nvim_set_option("clipboard", "unnamed") -- Copy to system clipboard

-- Spell
vim.opt.spelllang = 'en_us,fr'
vim.opt.spell = false -- enable spell check with <leader>ss

-- Other
vim.opt.fileformats = { "unix", "dos", "mac" }         -- use Unix first
vim.opt.textwidth = 80                                 -- for `gq` and linebreak text at 80 columns when typing
vim.opt.lazyredraw = true                              -- don't redraw while executing macros (perfs.)
vim.opt.scrolloff = 7                                  -- scroll when at n lines from the borders of the buffer
vim.opt.swapfile = false                               -- reduce pollution, save the planet
vim.opt.wildignore = { "*.o", "*.obj", "*~", "*.pyc" } -- ignore some files

local augroup = vim.api.nvim_create_augroup            -- Create/get autocommand group
local autocmd = vim.api.nvim_create_autocmd            -- Create autocommand

-- Filetype specific: fix indentation and remove tabs
augroup('setIndent', { clear = true })
autocmd('Filetype', {
  group = 'setIndent',
  pattern = {
    'css',
    'html',
    'javascript',
    'lua',
    'scss',
    'typescript',
    'xhtml',
    'xml',
    'yaml',
  },
  command = 'setlocal shiftwidth=2 tabstop=2 expandtab'
})

vim.filetype.add({
  pattern = {
    [".*/playbooks/.*%.yml"] = "yaml.ansible",
    [".*/playbooks/.*%.yaml"] = "yaml.ansible",
    [".*/roles/.*/tasks/.*%.yml"] = "yaml.ansible",
    [".*/roles/.*/tasks/.*%.yaml"] = "yaml.ansible",
    [".*/roles/.*/handlers/.*%.yml"] = "yaml.ansible",
    [".*/roles/.*/handlers/.*%.yaml"] = "yaml.ansible",
    ["ansible/.*%.yml"] = "yaml.ansible",
    [".*%.tf"] = "terraform",
    [".*%.tfvars"] = "terraform",
    [".terraformrc"] = "hcl",
    [".terraform.rc"] = "hcl",
    [".*%.hcl"] = "hcl",
    [".*%.tfstate"] = "json",
    [".*%.tfstate.backup"] = "json",
    [".*%.libjsonnet"] = "jsonnet",
  },
})

-- Return to last edit position when opening files
vim.cmd([[
autocmd BufReadPost *
  \ if line("'\"") > 0 && line("'\"") <= line("$") |
  \   exe "normal! g`\"" |
  \ endif
]])

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function(args)
    require("conform").format({ bufnr = args.buf })
  end,
})
