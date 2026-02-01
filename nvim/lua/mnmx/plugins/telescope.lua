return {
  'nvim-telescope/telescope.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make'
    },
  },
  config = function()
    local telescope = require("telescope")

    telescope.setup({
      extensions = {
        aerial = {
          show_nesting = {
            json = true,
            yaml = true,
          }
        },
        yaml_schema = {}
      }
    })
  end,
}
