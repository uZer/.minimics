return {
  'nvim-telescope/telescope.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make'
    },
  },
  opts = {
    extensions = {
      aerial = {
        show_nesting = {
          json = true,
          yaml = true,
        }
      },
      yaml_schema = {}
    }
  }
}
