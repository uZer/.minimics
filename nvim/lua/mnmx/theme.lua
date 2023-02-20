--
-- Cosmetic infidelities 
--

-- enable guicolors in case the colorscheme doesn't do it on it's own
vim.opt.termguicolors = true

-- change window separator chars to something fancy
vim.opt.fillchars = {
  vert = "|",
  horiz = "―",
  horizdown = "―",
  horizup = "―",
  vertleft = "|",
  vertright = "|",
  verthoriz = "|",
}

-- misc
vim.opt.cmdheight = 1 -- command line height
vim.opt.number = true -- display line numbers

-- [plugin: pywal.nvim] colorscheme
vim.cmd.colorscheme("pywal")

-- [plugin: indentLine] conceal configuration
vim.g.indentLine_concealcursor = 'c'
vim.g.vim_json_syntax_conceal = 0
