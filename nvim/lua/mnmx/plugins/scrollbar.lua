return {
  "petertriho/nvim-scrollbar",
  -- v2 replaces v1 on main on 2026-11-16, drop this line afterwards
  branch = "refactor/v2",
  opts = {
    providers = {
      gitsigns = true,
    },
    scrollbar = {
      visibility = "active",
      hide_if_all_visible = true,
      throttle_ms = 50,
      thumb = {
        highlight = "ScrollbarHandle", -- pywal16 only defines the v1 group name
      },
    },
  },
}
