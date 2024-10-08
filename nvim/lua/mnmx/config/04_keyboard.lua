--
-- Keyboard options 
--

-- create a local map function to ease key mapping declarations
local function map(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then
    options = vim.tbl_extend('force', options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- leader is <space> bar
vim.g.mapleader = ' '
vim.g.maplocalleader = "\\"

-- switch CWD to the directory of the open buffer
map('', '<leader>cd', ':cd %:p:h<cr>:pwd<cr>')

-- window management
map('', '<leader>wj', '<C-w>j') -- move to window...
map('', '<leader>wk', '<C-w>k')
map('', '<leader>wh', '<C-w>h')
map('', '<leader>wl', '<C-w>l')
map('', '<leader>wn', ':vsplit<cr>')
map('', '<leader>wb', ':split<cr>')
map('', '<leader>wc', ':close<cr>')
map('', '<leader>wJ', '<C-w>J') -- move window...
map('', '<leader>wK', '<C-w>K')
map('', '<leader>wH', '<C-w>H')
map('', '<leader>wL', '<C-w>L')

-- press tab to autoindent
map('n', '<TAB>', '==')
map('v', '<TAB>', '=')

-- movements
map('', '<C-h>', 'b')
map('', '<C-l>', 'w')
map('', '<C-a>', '^')
map('', '<C-e>', '$')

-- treat long lines as break lines (useful when moving around in them)
map('', 'j', 'gj')
map('', 'k', 'gk')

-- move entire lines up and down with ctrl+{j, k}
map('n', '<C-j>', ':m .+1<CR>==')
map('n', '<C-k>', ':m .-2<CR>==')
map('v', '<C-j>', ":m '>+1<CR>gv=gv")
map('v', '<C-k>', ":m '<-2<CR>gv=gv")
map('i', '<C-j>', '<Esc>:m .+1<CR>==gi')
map('i', '<C-k>', '<Esc>:m .-2<CR>==gi')

-- remove the Windows ^M when the encodings gets messed up
map('n', '<Leader>M', "mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm")

-- spell check
map('', '<leader>ss', ':set invspell<CR>')

-- buffers, files & tabs management
map('', '<F2>', ':bprev<cr>')
map('', '<F3>', ':bnext<cr>')
map('', '<C-S-Tab>', ':bprev<cr>')
map('', '<C-Tab>', ':bnext<cr>')
map('', '<leader>tn', ':enew<cr>')
map('', '<leader>tc', ':BufDel<cr>') -- [plugin: bufdel]

-- [plugin: telescope] find stuff
map('', '<C-o>', ':Telescope find_files<CR>')
map('', '<C-f>', ':lua require("telescope.builtin").live_grep({grep_open_files=false})<CR>')
map('', '<C-g>', ':Telescope grep_string<CR>')
map('', '<C-p>', ':Telescope<CR>')
map('', '<leader>p', ':Telescope<CR>')
