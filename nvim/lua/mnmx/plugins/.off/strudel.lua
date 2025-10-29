return {
  "gruvw/strudel.nvim",
  ft = "str",
  cmd = "StrudelLaunch",
  build = "npm install --no-save",
  keys = function()
    local strudel = require("strudel")
    return {
      { "<leader>sl", strudel.launch,     desc = "Launch Strudel" },
      { "<leader>sq", strudel.quit,       desc = "Quit Strudel" },
      { "<leader>st", strudel.toggle,     desc = "Strudel Toggle Play/Stop" },
      { "<leader>su", strudel.update,     desc = "Strudel Update" },
      { "<leader>ss", strudel.stop,       desc = "Strudel top Playback" },
      { "<leader>sb", strudel.set_buffer, desc = "Strudel set current buffer" },
      { "<leader>sx", strudel.execute,    desc = "Strudel set current buffer and update" },
    }
  end,

  config = function()
    require("strudel").setup {
      ui = {
        -- Maximise the menu panel
        -- (optional, default: true)
        -- maximise_menu_panel = false,

        -- Hide the Strudel menu panel (and handle)
        -- (optional, default: false)
        -- hide_menu_panel = false,

        -- Hide the default Strudel top bar (controls)
        -- (optional, default: false)
        -- hide_top_bar = false,

        -- Hide the Strudel code editor
        -- (optional, default: false)
        -- hide_code_editor = true,
      },
      -- Set to `true` to automatically trigger the code evaluation after saving the buffer content
      -- Only works if the playback was already started (doesn't start the playback on save)
      -- (optional, default: false)
      update_on_save = true,
    }
  end,
}
