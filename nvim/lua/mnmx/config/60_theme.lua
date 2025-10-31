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
vim.opt.cmdheight = 1    -- command line height
vim.opt.number = true    -- display line numbers
vim.opt.showmode = false -- hides -- INSERT --, -- VISUAL --, etc.
vim.opt.ruler = false    -- hides line/column info in cmd area
vim.opt.showcmd = false  -- hides keys like 'gk', 'dd', etc.
