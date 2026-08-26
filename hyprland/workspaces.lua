local workspaces = {
  "",
  "󰙯",
  "",
  "",
  "",
  "",
}

for _, name in ipairs(workspaces) do
  hl.workspace_rule({
    workspace = "name:" .. name,

    gaps_in = 0,
    gaps_out = 0,
    border_size = 0,

    no_rounding = true,
  })
end
