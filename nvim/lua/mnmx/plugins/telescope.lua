return {
  'nvim-telescope/telescope.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
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
