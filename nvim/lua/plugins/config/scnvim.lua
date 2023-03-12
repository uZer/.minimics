local scnvim = require("scnvim")

local map = scnvim.map
local map_expr = scnvim.map_expr

local options = {
  keymaps = {
    ['<leader><cr>'] = map('editor.send_line', { 'i', 'n' }),
    ['<cr>'] = {
      map('editor.send_block', { 'n' }),
      map('editor.send_selection', { 'x' }),
    },
    ['<leader>b'] = map('postwin.toggle'),
    ['<leader>sck'] = map('signature.show', 'i'),
    ['<leader>scl'] = map('postwin.clear', 'i'),
    ['<leader>sc.'] = map('sclang.hard_stop', { 'n', 'x', 'i' }),
    ['<leader>scs'] = map('sclang.start'),
    ['<leader>scc'] = map('sclang.recompile'),
    ['<leader>scb'] = map_expr('s.boot'),
    ['<leader>scm'] = map_expr('s.meter'),
  },
  editor = {
    highlight = {
      color = 'IncSearch',
    },
  },
  postwin = {
    float = {
      width = 80,
      height = 32,
      enabled = true,
    },
  },
}

scnvim.setup(options)
