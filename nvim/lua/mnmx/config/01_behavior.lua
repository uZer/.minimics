--
-- Behaviour options 
--

-- loglevel
vim.lsp.set_log_level("ERROR")

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
-- My terminal is alacritty now. It doesn't support runtime capability detection
-- (the XTGETTCAP sequence) so Neovim can't tell that the terminal supports it.
-- Because of that I get a clipboard: No provider error when I try to copy to "+
-- register. In order to prevent this, I enforce the usage of osc52 clipboard
-- https://www.reddit.com/r/neovim/comments/1d6wreh/tips_for_debugging_osc_52_not_detected_in_neovim/
--
-- To paste from terminal, use shift+insert (pasteSelection).
-- To copy to selection/primary, use "+y or Y (Yy for full line)
local osc52 = require('vim.ui.clipboard.osc52')
vim.g.clipboard = {
  name = 'osc52-write',
  copy = {
    ['+'] = osc52.copy('+'),
    ['*'] = osc52.copy('*'),
  },
  paste = {
    ['+'] = function() return { {}, 'v' } end,
    ['*'] = function() return { {}, 'v' } end,
  },
}

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
    'lisp',
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
    [".*%.str"] = "javascript", -- strudel
    [".*%.hcl"] = "hcl",
    [".*%.libjsonnet"] = "jsonnet",
    [".*%.tf"] = "terraform",
    [".*%.tfstate"] = "json",
    [".*%.tfstate.backup"] = "json",
    [".*%.tfvars"] = "terraform",
    [".*/playbooks/.*%.yaml"] = "yaml.ansible",
    [".*/playbooks/.*%.yml"] = "yaml.ansible",
    [".*/roles/.*/handlers/.*%.yaml"] = "yaml.ansible",
    [".*/roles/.*/handlers/.*%.yml"] = "yaml.ansible",
    [".*/roles/.*/tasks/.*%.yaml"] = "yaml.ansible",
    [".*/roles/.*/tasks/.*%.yml"] = "yaml.ansible",
    [".terraform.rc"] = "hcl",
    [".terraformrc"] = "hcl",
    ["ansible/.*%.yml"] = "yaml.ansible",
    [".*%.kicad_sch"] = "lisp",
    [".*%.kicad_pcb"] = "lisp",
    [".*%.kicad_sym"] = "lisp",
    [".*%.kicad_prl"] = "json",
    [".*%.kicad_pro"] = "json",
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
