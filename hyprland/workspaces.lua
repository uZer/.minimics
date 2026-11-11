-- Icon workspaces, keyed by their keybind.
--
-- They use numeric ids with the icon as default name instead of `name:<icon>`
-- workspaces: since Hyprland 0.57, named workspaces have no "id" in IPC, and
-- waybar's hyprland/workspaces module drops them.
local workspaces = {
  T = { id = "11", icon = "" },
  Y = { id = "12", icon = "󰙯" },
  SEMICOLON = { id = "13", icon = "" },
  I = { id = "14", icon = "" },
  O = { id = "15", icon = "" },
  P = { id = "16", icon = "" },
}

for _, ws in pairs(workspaces) do
  hl.workspace_rule({
    workspace = ws.id,
    default_name = ws.icon,

    gaps_in = 0,
    gaps_out = 0,
    border_size = 0,

    no_rounding = true,
  })
end

return workspaces
