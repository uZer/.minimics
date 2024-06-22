local telescope = require("telescope")
local options = {
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

telescope.load_extension("aerial")
telescope.load_extension("yaml_schema")
telescope.setup(options)
