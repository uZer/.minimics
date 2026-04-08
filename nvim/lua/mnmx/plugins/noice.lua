return {
  "folke/noice.nvim",
  event = "VeryLazy",
  opts = {
    views = {
      notify = {
        -- position = {
        --   row = "100%",
        --   col = "100%",
        -- },
        anchor = "SE",
      },
    },
  },
  keys = {
    {
      "?",
      "<cmd>Notifications<cr>",
      desc = "show history of notifications"
    },
  },
  dependencies = {
    -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
    -- "MunifTanjim/nui.nvim",
    -- OPTIONAL:
    --   `nvim-notify` is only needed, if you want to use the notification view.
    --   If not available, we use `mini` as the fallback
    {
      "rcarriga/nvim-notify",
      opts = {
        top_down = false, -- newer notifications appear at the bottom
      },
    },
    -- "nvim-mini/mini.notify"
  }
}
