local telescope = require("telescope")
local options = {
  extensions = {
    aerial = {
      show_nesting = {
        json = true,
        yaml = true,
      }
    }
  }
}

telescope.load_extension('aerial')
telescope.setup(options)
