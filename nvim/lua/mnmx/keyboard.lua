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

-- [plugin: telescope] find stuff
map('', '<C-o>', ':Telescope find_files<CR>')
map('', '<C-f>', ':lua require("telescope.builtin").live_grep({grep_open_files=true})<CR>')
map('', '<C-g>', ':lua require("telescope.builtin").live_grep({grep_open_files=false})<CR>')
map('', '<C-p>', ':Telescope<CR>')

-- [plugin: aerial] toogle
map('', '<F6>', ':AerialNavToggle<CR>')
map('', '<F7>', ':AerialToggle<CR>')
map('', '<leader>f', ':AerialNavToggle<cr>')
map('', '<leader>m', ':AerialToggle<cr>')

-- [plugin: tagbar] toogle
map('', '<F8>', ':TagbarToggle<CR>')

-- [plugin: tabline] buffers, files & tabs management
map('', '<F2>', ':TablineBufferPrevious<cr>')
map('', '<F3>', ':TablineBufferNext<cr>')
map('', '<C-S-Tab>', ':TablineBufferPrevious<cr>')
map('', '<C-Tab>', ':TablineBufferNext<cr>')
map('', '<leader>tn', ':TablineTabNew<cr>')
map('', '<leader>tc', ':BufDel<cr>')

-- [plugin: lsp-zero] magic shortcuts
map('', '<leader>k', '<cmd>lua vim.diagnostic.goto_prev()<cr>')
map('', '<leader>j', '<cmd>lua vim.diagnostic.goto_next()<cr>')
map('', '<leader>l', '<cmd>lua vim.diagnostic.open_float()<cr>')
map('', 'gj', '<cmd>lua vim.diagnostic.goto_prev()<cr>')
map('', 'gk', '<cmd>lua vim.diagnostic.goto_next()<cr>')
-- map('', '<leader>f', ':LspZeroFormat<cr>')
