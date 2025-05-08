return {
  'mason-org/mason.nvim',
  priority = 2,
  opts = {
    max_concurrent_installers = 15,
    ui = {
      icons = {
        package_installed = "✓",
        package_pending = "➜",
        package_uninstalled = "✗"
      }
    }
  }
}
