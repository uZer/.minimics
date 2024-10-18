return {
  'nvimdev/lspsaga.nvim',
  config = function()
    require('lspsaga').setup({
      code_action = {
        extend_gitsigns = true,
      },
      lightbulb = {
        sign = false, -- Hide lightbulb as sign
        -- virtual_text = false, -- Disable virtual text for code action hints
      },
      finder = {
        keys = {
          toggle_or_open = '<cr>',
          vsplit = 'o',
          split = 'n',
        },
      },
      outline = {
        keys = {
          jump = '<CR>',
          toggle_or_jump = '<space>',
        }
      },
      ui = {
        code_action = ' '
      }
    })
  end,
  event = "LspAttach",
  keys = {
    { 'K',          '<cmd>Lspsaga hover_doc<CR>',            desc = 'Lspsaga hover doc' },
    { 'gh',         '<cmd>Lspsaga hover_doc<CR>',            desc = 'Lspsaga hover doc' },
    { '<leader>ca', '<cmd>Lspsaga code_action<CR>',          desc = 'Lspsaga code action',        mode = { 'n', 'v' }, },
    { 'J',          '<cmd>Lspsaga code_action<CR>',          desc = 'Lspsaga code action',        mode = { 'n', 'v' }, },
    { 'gd',         '<cmd>Lspsaga goto_definition<CR>',      desc = 'Lspsaga go to definition' },
    { 'gp',         '<cmd>Lspsaga peek_definition<CR>',      desc = 'Lspsaga peek definition' },
    { 'gs',         '<cmd>Lspsaga signature_help<CR>',       desc = 'Lspsaga signature help' },
    { 'gr',         '<cmd>Lspsaga finder<CR>',               desc = 'Lspsaga finder' },
    { '<leader>rn', '<cmd>Lspsaga rename<CR>',               desc = 'Lspsaga rename' },
    { '<leader>k',  '<cmd>Lspsaga diagnostic_jump_prev<CR>', desc = 'Lspsaga previous diagnostic' },
    { '<leader>j',  '<cmd>Lspsaga diagnostic_jump_next<CR>', desc = 'Lspsaga next diagnostic' },
    { '<leader>m',  '<cmd>Lspsaga outline<CR>',              desc = 'Lspsaga outline' },
  }
}
