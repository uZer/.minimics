local colors = require("colors")

hl.config({
  xwayland = {
    force_zero_scaling = true,
  },

  input = {
    follow_mouse = 1,

    kb_layout = "us",
    kb_variant = "intl",
    kb_model = "pc105",

    sensitivity = 0,

    repeat_delay = 210,
    repeat_rate = 60,

    touchpad = {
      natural_scroll = true,
    },
  },

  general = {
    gaps_in = 6,
    gaps_out = 12,

    border_size = 0,

    col = {
      active_border = colors.color2,
      inactive_border = colors.color0,
    },

    layout = "dwindle",

    allow_tearing = false,
  },

  decoration = {
    rounding = 6,

    blur = {
      enabled = true,
      size = 2,
      passes = 2,
    },

    shadow = {
      enabled = true,
      range = 3,
      render_power = 3,
      color = "rgba(1a1a1aee)",
    },
  },

  dwindle = {
    preserve_split = true,
    force_split = 2,
  },

  ecosystem = {
    no_update_news = true,
    no_donation_nag = true,
  },

  misc = {
    disable_hyprland_logo = true,
    force_default_wallpaper = 0,
  },
})
