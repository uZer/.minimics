local options = {
  colorcolumn = "80",
  limit_to_line = false,
  limit_to_window = false,
  disabled_filetypes = { "help", "text", "mason", "lazy", "scnvim" }
}

require("smartcolumn").setup(options)
