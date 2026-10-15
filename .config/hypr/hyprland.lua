-- Converted from hyprland.conf (hyprlang) to the Lua config format (Hyprland 0.55+).
-- The original is kept as hyprland.conf for reference.

local mod = "SUPER"


------------------
---- MONITORS ----
------------------

hl.monitor({ output = "DP-3",     mode = "3440x1440@144", position = "2120x-1440", scale = 1 })
hl.monitor({ output = "DP-2",     mode = "2560x1440@180", position = "5120x0",     scale = 1 })
hl.monitor({ output = "DP-1",     mode = "2560x1440@170", position = "2560x0",     scale = 1 })
hl.monitor({ output = "HDMI-A-1", mode = "2560x1440@60",  position = "0x0",        scale = 1 })


-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

hl.env("HYPRCURSOR_THEME", "GoogleDot-Black")
hl.env("HYPRCURSOR_SIZE", "24")


-------------------
---- AUTOSTART ----
-------------------

hl.on("hyprland.start", function()
    hl.exec_cmd("hyprpaper")
    hl.exec_cmd("wl-paste --type text --watch cliphist store")  -- Stores only text data
    hl.exec_cmd("wl-paste --type image --watch cliphist store") -- Stores only image data
    hl.exec_cmd("waybar")
    hl.exec_cmd("fcitx5 -d")
    -- hl.exec_cmd("hyprsunset")
    hl.exec_cmd("sunsetr")
end)


-----------------
---- OPTIONS ----
-----------------

hl.config({
    cursor = {
        no_hardware_cursors = true,
    },

    input = {
        kb_layout  = "us,de,ru",
        kb_variant = ",,phonetic",
        -- kb_model = "",
        kb_options = "grp:win_space_toggle",
        -- kb_rules = "",
        repeat_delay = 180,

        follow_mouse  = 1,
        mouse_refocus = false,

        touchpad = {
            natural_scroll = false,
        },
    },

    general = {
        gaps_in     = 5,
        gaps_out    = 20,
        border_size = 2,

        col = {
            active_border   = 0x66fbf1c7,
            inactive_border = 0x6633333,
        },
    },

    decoration = {
        rounding = 10,

        blur = {
            size              = 5, -- minimum 1
            passes            = 3, -- minimum 1, more passes = more resource intensive.
            new_optimizations = true,
            xray              = true,
        },
        -- Your blur "amount" is blur_size * blur_passes, but high blur_size (over around 5-ish) will produce artifacts.
        -- if you want heavy blur, you need to up the blur_passes.
        -- the more passes, the more you can up the blur_size without noticing artifacts.
    },

    animations = {
        enabled = true,
    },

    -- dwindle = {
    --     pseudotile = false, -- enable pseudotiling on dwindle
    -- },

    misc = {
        vrr                      = 0,
        disable_hyprland_logo    = true,
        disable_splash_rendering = true,
        force_default_wallpaper  = 0,
    },
})


--------------------
---- ANIMATIONS ----
--------------------

hl.curve("wind",   { type = "bezier", points = { {0.05, 0.9}, {0.1, 1.05} } })
hl.curve("winIn",  { type = "bezier", points = { {0.1, 1.1},  {0.1, 1.1}  } })
hl.curve("winOut", { type = "bezier", points = { {0.3, -0.3}, {0, 1}      } })
hl.curve("liner",  { type = "bezier", points = { {1, 1},      {1, 1}      } })

hl.animation({ leaf = "windows",     enabled = true, speed = 6,  bezier = "wind",    style = "slide" })
hl.animation({ leaf = "windowsIn",   enabled = true, speed = 6,  bezier = "winIn",   style = "slide" })
hl.animation({ leaf = "windowsOut",  enabled = true, speed = 5,  bezier = "winOut",  style = "slide" })
hl.animation({ leaf = "windowsMove", enabled = true, speed = 5,  bezier = "wind",    style = "slide" })
hl.animation({ leaf = "border",      enabled = true, speed = 1,  bezier = "liner" })
hl.animation({ leaf = "borderangle", enabled = true, speed = 30, bezier = "liner",   style = "loop" })
hl.animation({ leaf = "fade",        enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "workspaces",  enabled = true, speed = 5,  bezier = "wind" })


---------------------
---- KEYBINDINGS ----
---------------------

hl.bind(mod .. " + H", hl.dsp.focus({ direction = "left" }))
hl.bind(mod .. " + L", hl.dsp.focus({ direction = "right" }))
hl.bind(mod .. " + K", hl.dsp.focus({ direction = "up" }))
hl.bind(mod .. " + J", hl.dsp.focus({ direction = "down" }))

hl.bind(mod .. " + RETURN", hl.dsp.exec_cmd("kitty"))
hl.bind(mod .. " + Q",      hl.dsp.window.close())
hl.bind(mod .. " + C",      hl.dsp.exec_cmd("hyprpicker -a"))
-- hl.bind(mod .. " + M",   hl.dsp.exit())
hl.bind(mod .. " + E",      hl.dsp.exec_cmd("pcmanfm"))
hl.bind(mod .. " + V",      hl.dsp.window.float({ action = "toggle" }))
hl.bind(mod .. " + P",      hl.dsp.exec_cmd("wofi --show drun -o DP-1"))
-- hl.bind(mod .. " + R",   hl.dsp.window.pseudo())
hl.bind(mod .. " + F",      hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }))
hl.bind(mod .. " + Up",     hl.dsp.exec_cmd("~/.local/bin/volume up"),   { repeating = true })
hl.bind(mod .. " + Down",   hl.dsp.exec_cmd("~/.local/bin/volume down"), { repeating = true })
-- hl.bind(mod .. " + SPACE", hl.dsp.exec_cmd("cliphist list | wofi --dmenu | cliphist decode | wl-copy"))

hl.bind(mod .. " + ALT + SPACE", hl.dsp.exec_cmd("playerctl play-pause"))
hl.bind(mod .. " + LEFT",        hl.dsp.exec_cmd("playerctl previous"))
hl.bind(mod .. " + RIGHT",       hl.dsp.exec_cmd("playerctl next"))
hl.bind(mod .. " + SHIFT + S",   hl.dsp.exec_cmd("grimblast copy area"))
hl.bind(mod .. " + PRINT",       hl.dsp.exec_cmd("grimblast copy output"))
hl.bind(mod .. " + ALT + L",     hl.dsp.exec_cmd("hyprlock"))

-- mod + [0-9] switches workspace, ALT + [0-9] moves the active window there (and follows it)
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(mod .. " + " .. key, hl.dsp.focus({ workspace = i }))
    hl.bind("ALT + " .. key,     hl.dsp.window.move({ workspace = i, follow = true }))
end

-- Move/resize windows with mod + LMB/RMB and dragging
hl.bind(mod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- hl.bind(mod .. " + SHIFT + H", hl.dsp.window.move({ direction = "left" }))
-- hl.bind(mod .. " + SHIFT + L", hl.dsp.window.move({ direction = "right" }))
-- hl.bind(mod .. " + SHIFT + K", hl.dsp.window.move({ direction = "up" }))
-- hl.bind(mod .. " + SHIFT + J", hl.dsp.window.move({ direction = "down" }))


-----------------------------------------------
---- OLD COMMENTED-OUT RULES (hyprlang)    ----
---- port to hl.window_rule / hl.layer_rule ----
---- before re-enabling                    ----
-----------------------------------------------

-- windowrule=pseudo,fcitx

-- Jetbrains products https://github.com/hyprwm/Hyprland/issues/933
-- windowrulev2 = float,floating:0,class:^(jetbrains-.*),title:^(win.*)
-- windowrulev2 = float,class:^(jetbrains-.*),title:^(Welcome to.*)
-- windowrulev2 = center,class:^(jetbrains-.*),title:^(Replace All)$
-- windowrulev2 = forceinput,class:^(jetbrains-.*)
-- windowrulev2 = windowdance,class:^(jetbrains-.*)

-- windowrulev2 = opacity 0.0 override 0.0 override,class:^(xwaylandvideobridge)$
-- windowrulev2 = noanim,class:^(xwaylandvideobridge)$
-- windowrulev2 = nofocus,class:^(xwaylandvideobridge)$
-- windowrulev2 = noinitialfocus,class:^(xwaylandvideobridge)$

-- layerrule=blur,waybar

-- gestures { workspace_swipe=no }

-- Plugin: hyprtasking (see hyprland.conf for the full old block)
-- bind = super, t, hyprtasking:toggle, cursor
-- bind = super, Y/U/I/O, hyprtasking:move, left/down/up/right


----------------------
---- WINDOW RULES ----
----------------------

-- Ignore maximize requests from apps (e.g. kitty), so new windows tile normally
hl.window_rule({
    name  = "suppress-maximize-events",
    match = { class = ".*" },

    suppress_event = "maximize",
})
