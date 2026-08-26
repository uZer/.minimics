hl.on("hyprland.start", function()
  hl.exec_cmd("/usr/lib/polkit-kde-authentication-agent-1")

  hl.exec_cmd("kanshi")
  hl.exec_cmd("swaync")
  hl.exec_cmd("nm-applet")

  hl.exec_cmd("env QT_QPA_PLATFORM=xcb copyq")

  hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")

  hl.exec_cmd("mini startup")

  -- Original:
  -- exec = kanshictl reload ; sleep 1 ; if ! pgrep waybar; then waybar ; else killall -SIGUSR2 waybar ; fi

  hl.exec_cmd(
    "kanshictl reload ; "
      .. "sleep 1 ; "
      .. "if ! pgrep waybar; then "
      .. "waybar ; "
      .. "else "
      .. "killall -SIGUSR2 waybar ; "
      .. "fi"
  )

  -- Original:
  -- exec = killall swaybg ; swaybg -m fill -i "$(cat ~/.cache/wal/wal)" 2>/dev/null &

  hl.exec_cmd([[killall swaybg ; swaybg -m fill -i "$(cat ~/.cache/wal/wal)" 2>/dev/null &]])
end)
