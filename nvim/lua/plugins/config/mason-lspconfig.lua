local options = {
  automatic_installation = true,

}

require("mason-lspconfig").setup(options)
require("mason-lspconfig").setup_handlers({
  -- The first entry (without a key) will be the default handler
  -- and will be called for each installed server that doesn't have
  -- a dedicated handler.
  function (server_name) -- default handler (optional)
    require("lspconfig")[server_name].setup {}
  end,
  ["yamlls"] = function(server_name)
    require("lspconfig")[server_name].setup {
      settings = {
        redhat = {
            telemetry = { enabled = false },
        },
        yaml = {
          keyOrdering = false,
        }
      }
    }
  end
})
