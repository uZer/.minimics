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
float_class("^(org\\.gnome\\.)?[Nn]autilus")
float_class("^(SuperCollider|scide)")
float_class("^(k|K)rusader")
float_class("^(n|N)emo")
float_class("^qt[56]ct$")
float_class("^.*ctl")
float_class("^.*copyq")

float_title("^Microsoft Teams Notification$")
float_title("^Loading Microsoft Teams$")

-- Firefox extension popups open titled "Mozilla Firefox" and get their real
-- title later; window rules only apply `float` at open, so float on retitle.
local float_on_retitle = {
  -- French locale: the space before ":" is a no-break space (U+00A0)
  "^Extension[^:]*: %(Torrent Control%) %- ",
}

hl.on("window.title", function(window)
  if not window or window.floating then
    return
  end
  for _, pattern in ipairs(float_on_retitle) do
    if window.title:find(pattern) then
      hl.dispatch(hl.dsp.window.float({
        action = "enable",
        window = "address:" .. window.address,
      }))
      return
    end
  end
end)

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

local workspaces = require("workspaces")

hl.window_rule({
  match = {
    class = "^[Dd]iscord$",
  },
  workspace = workspaces.Y.id,
})

hl.window_rule({
  match = {
    class = "^[Ss]potify$",
  },
  workspace = workspaces.SEMICOLON.id,
})

hl.window_rule({
  match = {
    class = "^[Pp]lexamp$",
  },
  workspace = workspaces.SEMICOLON.id,
})

hl.window_rule({
  match = {
    class = "^feishin$",
  },
  workspace = workspaces.SEMICOLON.id,
})

hl.window_rule({
  match = {
    class = "^[Ss]lack$",
  },
  workspace = workspaces.I.id,
})

hl.window_rule({
  match = {
    title = ".*Microsoft Teams.*",
  },
  workspace = "10",
})
