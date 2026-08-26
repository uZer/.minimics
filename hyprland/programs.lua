return {
  bar = "sleep 1 ; waybar",
  editor = "nvim-qt",
  fm = "nemo",
  terminal = "alacritty",

  clipSel = "copyq toggle",
  clipClear = "copyq remove",

  colorPicker = "hyprpicker -a",
  display = "wdisplays",

  lock = "mini lock",
  menu = "mini menu apps",
  passmenu = "mini menu pass",

  screenshot = "mini screen shot",

  notify = "swaync",
  notifyshow = "swaync-client -t",

  pywal = "~/.minimics/bin/pywal -f -q",
  pywaltheme = "~/.minimics/bin/pywal sw16-sixteal-vibrant",

  volumeUp = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 3%+",
  volumeDown = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 3%-",
  volumeMute = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle",
  micMute = "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle",

  playerPrev = "playerctl previous",
  playerNext = "playerctl next",
  playerPause = "playerctl play-pause",

  lightUp = "brightnessctl set +5%",
  lightDown = "brightnessctl set 5%-",
}
