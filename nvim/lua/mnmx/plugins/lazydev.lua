return {
  "folke/lazydev.nvim",
  ft = "lua", -- only load on lua files
  opts = {
    library = {
      { path = "${MIN_PATH}/nvim/lua/", words = { "vim" } },
    },
  }
}
