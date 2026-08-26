local programs = require("programs")

local mainMod = "SUPER"

local function bind(key, dispatcher)
  hl.bind(mainMod .. " + " .. key, dispatcher)
end

local function bind_exec(key, command)
  bind(key, hl.dsp.exec_cmd(command))
end

-- ============================================================
-- APPLICATIONS
-- ============================================================

bind("F", hl.dsp.window.fullscreen())
bind_exec("RETURN", programs.terminal)
bind_exec("BACKSPACE", programs.passmenu)
bind_exec("R", programs.pywaltheme)
bind_exec("N", programs.fm)
bind_exec("D", programs.menu)
bind_exec("C", programs.clipSel)
bind_exec("M", programs.lock)
bind_exec("SLASH", programs.notifyshow)

hl.bind(mainMod .. " + SHIFT + C", hl.dsp.exec_cmd(programs.clipClear))
hl.bind(mainMod .. " + ALT + P", hl.dsp.exec_cmd(programs.colorPicker))
hl.bind(mainMod .. " + SHIFT + M", hl.dsp.exec_cmd(programs.lock .. " privacy"))
hl.bind(mainMod .. " + SHIFT + R", hl.dsp.exec_cmd(programs.pywal))

bind(
  "SHIFT + SPACE",
  hl.dsp.window.float({
    action = "toggle",
  })
)

bind("SHIFT + Q", hl.dsp.window.kill())
bind("SHIFT + E", hl.dsp.exit())

-- ============================================================
-- DWINDLE
-- ============================================================

bind("V", hl.dsp.layout("togglesplit"))

-- ============================================================
-- MEDIA KEYS
-- ============================================================

hl.bind("Print", hl.dsp.exec_cmd(programs.screenshot))
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd(programs.volumeUp), { repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd(programs.volumeDown), { repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd(programs.volumeMute))
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd(programs.micMute))
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd(programs.lightUp), { repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd(programs.lightDown), { repeating = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd(programs.playerPrev))
hl.bind("XF86AudioNext", hl.dsp.exec_cmd(programs.playerNext))
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd(programs.playerPause))
hl.bind("XF86Display", hl.dsp.exec_cmd(programs.display))

-- ============================================================
-- FOCUS
-- ============================================================

local focus_keys = {
  LEFT = "l",
  RIGHT = "r",
  UP = "u",
  DOWN = "d",

  H = "l",
  L = "r",
  K = "u",
  J = "d",
}

for key, direction in pairs(focus_keys) do
  bind(
    key,
    hl.dsp.focus({
      direction = direction,
    })
  )
end

-- ============================================================
-- MOVE WINDOW
-- ============================================================

local move_keys = {
  LEFT = "l",
  RIGHT = "r",
  UP = "u",
  DOWN = "d",

  H = "l",
  L = "r",
  K = "u",
  J = "d",
}

for key, direction in pairs(move_keys) do
  hl.bind(
    mainMod .. " + SHIFT + " .. key,
    hl.dsp.window.move({
      direction = direction,
    })
  )
end

-- ============================================================
-- WORKSPACES 1-10
-- ============================================================

local numeric_workspaces = {
  ["1"] = "1",
  ["2"] = "2",
  ["3"] = "3",
  ["4"] = "4",
  ["5"] = "5",
  ["6"] = "6",
  ["7"] = "7",
  ["8"] = "8",
  ["9"] = "9",
  ["0"] = "10",
}

for key, workspace in pairs(numeric_workspaces) do
  bind(key, hl.dsp.focus({ workspace = workspace }))
end

-- ============================================================
-- NAMED WORKSPACES
-- ============================================================

local named_workspaces = {
  T = "name:",
  Y = "name:󰙯",
  SEMICOLON = "name:",
  I = "name:",
  O = "name:",
  P = "name:",
}

bind("T", hl.dsp.focus({ workspace = named_workspaces.T }))
bind("Y", hl.dsp.focus({ workspace = named_workspaces.Y }))
bind("SEMICOLON", hl.dsp.focus({ workspace = named_workspaces.SEMICOLON }))
bind("I", hl.dsp.focus({ workspace = named_workspaces.I }))
bind("O", hl.dsp.focus({ workspace = named_workspaces.O }))
bind("P", hl.dsp.focus({ workspace = named_workspaces.P }))

-- ============================================================
-- MOVE WORKSPACE TO MONITOR
-- ============================================================

local monitor_numbers = { ["1"] = 0, ["2"] = 1, ["3"] = 2, ["4"] = 3 }

for key, monitor in pairs(monitor_numbers) do
  hl.bind(mainMod .. " + ALT + " .. key, hl.dsp.workspace.move({ monitor = monitor }))
end

hl.bind(mainMod .. " + ALT + J", hl.dsp.workspace.move({ monitor = "down" }))
hl.bind(mainMod .. " + ALT + K", hl.dsp.workspace.move({ monitor = "up" }))
hl.bind(mainMod .. " + ALT + H", hl.dsp.workspace.move({ monitor = "left" }))
hl.bind(mainMod .. " + ALT + L", hl.dsp.workspace.move({ monitor = "right" }))

-- ============================================================
-- MOVE ACTIVE WINDOW TO WORKSPACE
-- ============================================================

for key, workspace in pairs(numeric_workspaces) do
  hl.bind(
    mainMod .. " + SHIFT + " .. key,
    hl.dsp.window.move({
      workspace = workspace,
    })
  )
end

hl.bind(
  mainMod .. " + SHIFT + T",
  hl.dsp.window.move({
    workspace = named_workspaces.T,
  })
)

hl.bind(
  mainMod .. " + SHIFT + Y",
  hl.dsp.window.move({
    workspace = named_workspaces.Y,
  })
)

hl.bind(
  mainMod .. " + SHIFT + SEMICOLON",
  hl.dsp.window.move({
    workspace = named_workspaces.SEMICOLON,
  })
)

hl.bind(
  mainMod .. " + SHIFT + I",
  hl.dsp.window.move({
    workspace = named_workspaces.I,
  })
)

hl.bind(
  mainMod .. " + SHIFT + O",
  hl.dsp.window.move({
    workspace = named_workspaces.O,
  })
)

hl.bind(
  mainMod .. " + SHIFT + P",
  hl.dsp.window.move({
    workspace = named_workspaces.P,
  })
)

-- ============================================================
-- SPECIAL WORKSPACE / SCRATCHPAD
-- ============================================================

bind("S", hl.dsp.workspace.toggle_special("magic"))

hl.bind(
  mainMod .. " + SHIFT + S",
  hl.dsp.window.move({
    workspace = "special:magic",
  })
)

-- ============================================================
-- SCROLL THROUGH WORKSPACES
-- ============================================================

hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- ============================================================
-- MOUSE
-- ============================================================

hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })
