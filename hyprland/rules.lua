local function float_class(class)
  hl.window_rule({
    match = {
      class = class,
    },
    float = true,
  })
end

local function float_title(title)
  hl.window_rule({
    match = {
      title = title,
    },
    float = true,
  })
end

-- ============================================================
-- FLOATING WINDOWS
-- ============================================================

float_class("^.*(c|C)ontrol.*")
float_class("^.*(s|S)tatistics.*")

float_title("^.*(c|C)onfiguration.*")
float_title("^.*(s|S)ettings.*")
float_title("^.*(p|P)arameters.*")
float_title("^.*(p|P)references.*")
float_title("^.*(q|Q)uarks$")

float_class("^feh")
float_class("^Nautilus")
float_class("^SuperCollider")
float_class("^(k|K)rusader")
float_class("^(n|N)emo")
float_class("^qt\\.ct")
float_class("^.*ctl")
float_class("^.*copyq")

float_title("^Microsoft Teams Notification$")
float_title("^Loading Microsoft Teams$")

-- ============================================================
-- TILED WINDOWS
-- ============================================================

hl.window_rule({
  match = {
    class = "^strudel\\.cc$",
  },
  tile = true,
})

-- ============================================================
-- APPLICATION WORKSPACES
-- ============================================================

hl.window_rule({
  match = {
    class = "^Discord$",
  },
  workspace = "name:󰙯",
})

hl.window_rule({
  match = {
    class = "^Spotify",
  },
  workspace = "name:",
})

hl.window_rule({
  match = {
    class = "^Plexamp",
  },
  workspace = "name:",
})

hl.window_rule({
  match = {
    class = "^Slack",
  },
  workspace = "name:",
})

hl.window_rule({
  match = {
    title = ".*Microsoft Teams.*",
  },
  workspace = "10",
})
