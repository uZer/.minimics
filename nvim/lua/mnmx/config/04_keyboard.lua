--
-- Keyboard options 
--

-- convenience wrapper
local map = function(mode, lhs, rhs, opts)
  opts = vim.tbl_extend('force', { noremap = true, silent = true }, opts or {})
  vim.keymap.set(mode, lhs, rhs, opts)
end

-- leader is <space> bar
vim.g.mapleader = ' '
vim.g.maplocalleader = "\\"

-- switch CWD to the directory of the current buffer
map('n', '<C-w>cd', function()
  vim.cmd.cd('%:p:h')
  vim.cmd.pwd()
end)

-- yank to clipboard (OSC 52)
-- no paste support due to security concerns (see alacritty configuration)
-- so please use terminal paste with shift+insert
map({ 'n', 'v' }, 'Y', '"+y')

-- window management
map('n', '<leader>wj', '<C-w>j')
map('n', '<leader>wk', '<C-w>k')
map('n', '<leader>wh', '<C-w>h')
map('n', '<leader>wl', '<C-w>l')
map('n', '<leader>wn', '<cmd>vsplit<cr>')
map('n', '<leader>wb', '<cmd>split<cr>')
map('n', '<leader>wc', '<cmd>close<cr>')
map('n', '<leader>wJ', '<C-w>J')
map('n', '<leader>wK', '<C-w>K')
map('n', '<leader>wH', '<C-w>H')
map('n', '<leader>wL', '<C-w>L')

-- press tab to autoindent
map('n', '<Tab>', '==')
map('v', '<Tab>', '=')

-- movements
map({ 'n', 'v' }, '<C-h>', 'b')
map({ 'n', 'v' }, '<C-l>', 'w')
map({ 'n', 'v' }, '<C-a>', '^')
map({ 'n', 'v' }, '<C-e>', '$')

-- treat long lines as break lines (useful when moving around in them)
map({ 'n', 'v' }, 'j', 'gj')
map({ 'n', 'v' }, 'k', 'gk')

-- move entire lines up and down with ctrl+{j, k}
map('n', '<C-j>', '<cmd>m .+1<cr>==')
map('n', '<C-k>', '<cmd>m .-2<cr>==')
map('v', '<C-j>', "<cmd>m '>+1<cr>gv=gv")
map('v', '<C-k>', "<cmd>m '<-2<cr>gv=gv")
map('i', '<C-j>', '<Esc><cmd>m .+1<cr>==gi')
map('i', '<C-k>', '<Esc><cmd>m .-2<cr>==gi')

-- spell check
map('n', '<leader>sc', '<cmd>set invspell<cr>')

-- buffers, files & tabs management
map('n', '<F2>', '<cmd>bprev<cr>')
map('n', '<F3>', '<cmd>bnext<cr>')
map('n', '<C-Tab>', '<cmd>bnext<cr>')
map('n', '<C-S-Tab>', '<cmd>bprev<cr>')
map('n', '<leader>tn', '<cmd>enew<cr>')
map('n', '<leader>tc', '<cmd>BufDel<cr>') -- [plugin: bufdel]

-- [plugin: telescope] find stuff
map('n', '<C-o>', '<cmd>Telescope find_files<cr>')
map('n', '<C-p>', '<cmd>Telescope<cr>')
map('n', '<leader>p', '<cmd>Telescope<cr>')
map('n', '<C-g>', function()
  require('telescope.builtin').live_grep({ grep_open_files = false })
end)

map('n', '<C-f>', function()
  require('telescope.builtin').grep_string({ grep_open_files = false })
end)

local function getVisualSelection()
  vim.cmd('noau normal! "vy"')
  local text = vim.fn.getreg("v")
  vim.fn.setreg("v", {})

  text = string.gsub(text, "\n", "")
  if #text > 0 then
    return text
  else
    return ""
  end
end

map('v', '<C-f>', function()
  require("telescope.builtin").live_grep({
    default_text = getVisualSelection(),
    only_sort_text = true,
    additional_args = function()
      return { "--pcre2" }
    end,
  })
end)
