-- Hyprland Lua Configuration

------------------
---- MONITORS ----
------------------

hl.exec_cmd("touch $XDG_CONFIG_HOME/hypr/monitors.lua")
require("monitors")

-------------------------
---- MY PROGRAMS / VARS ----
-------------------------

local terminal    = "kitty"
local fileManager = "thunar"
local menu        = "fuzzel"
local mainMod     = "SUPER"

------------------------------
---- ENVIRONMENT VARIABLES ----
------------------------------

hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")

-------------------
---- CORE CONFIG ----
-------------------

hl.config({
  general = {
    gaps_in       = 1,
    gaps_out      = 0,
    border_size   = 2,
    col           = {
      active_border   = { colors = { "rgba(bf00ffee)", "rgba(000059ee)" }, angle = 45 },
      inactive_border = "rgba(595959aa)",
    },
    layout        = "master",
    allow_tearing = false,
  },

  decoration = {
    rounding       = 0,
    rounding_power = 2,

    blur           = {
      enabled  = true,
      size     = 3,
      passes   = 1,
      vibrancy = 0.1696,
    },

    shadow         = {
      enabled      = true,
      range        = 4,
      render_power = 3,
      color        = "rgba(1a1a1aee)",
    },
  },

  animations = {
    enabled = true,
  },

  master = {
    mfact = 0.5,
  },

  input = {
    kb_layout    = "us",
    kb_variant   = "",
    kb_model     = "",
    kb_options   = "",
    kb_rules     = "",

    follow_mouse = 2,

    repeat_delay = 250,
    repeat_rate  = 40,

    touchpad     = {
      natural_scroll = true,
    },

    sensitivity  = 0,
  },

  misc = {
    force_default_wallpaper = 0,
    disable_hyprland_logo   = true,
    enable_anr_dialog       = false,
  },

  ecosystem = {
    no_update_news = true,
    no_donation_nag = true,
  },
})

-----------------------------
---- ANIMATIONS / CURVES ----
-----------------------------

-- Custom bezier curve from hyprlang config
hl.curve("myBezier", { type = "bezier", points = { { 0.05, 0.9 }, { 0.1, 1.05 } } })

-- Animations matching hyprlang config
hl.animation({ leaf = "windows", enabled = true, speed = 7, bezier = "myBezier" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 7, bezier = "default", style = "popin 80%" })
hl.animation({ leaf = "border", enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "borderangle", enabled = true, speed = 8, bezier = "default" })
hl.animation({ leaf = "fade", enabled = true, speed = 7, bezier = "default" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 6, bezier = "default" })

------------------------
---- INPUT / GESTURES ----
------------------------

hl.gesture({
  fingers   = 3,
  direction = "horizontal",
  action    = "workspace",
})

-----------------------
---- KEYBINDINGS ----
-----------------------

-- Terminal
hl.bind(mainMod .. " + RETURN", hl.dsp.exec_cmd(terminal))

-- Kill active window
hl.bind(mainMod .. " + Q", hl.dsp.window.close())

-- Exit Hyprland
hl.bind(mainMod .. " + M", hl.dsp.exit())

-- File manager
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))

-- Toggle floating
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))

-- Application menu
hl.bind(mainMod .. " + D", hl.dsp.exec_cmd(menu))

-- Move focus (vim-style)
hl.bind(mainMod .. " + h", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + l", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + j", hl.dsp.focus({ direction = "down" }))
hl.bind(mainMod .. " + k", hl.dsp.focus({ direction = "up" }))

-- Switch workspaces with mainMod + [1-9,0]
for i = 1, 10 do
  local key = i % 10 -- 10 maps to 0
  hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
end

-- Move active window to workspace with mainMod + SHIFT + [1-9,0]
for i = 1, 10 do
  local key = i % 10
  hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Scroll through workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e-1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e+1" }))

-- Screenshot (region copy to clipboard)
hl.bind("Print", hl.dsp.exec_cmd('grim -g "$(slurp -d)" - | wl-copy'), { locked = true })

-- Move/resize windows with mainMod + LMB/RMB
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Volume keys
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 5%+"),
  { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 5%-"),
  { locked = true, repeating = true })

-- Brightness keys
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl set +5%"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -n240 set 5%-"), { locked = true, repeating = true })


---------------------------------
---- WINDOW / WORKSPACE RULES ----
---------------------------------

-- Discord: opacity 0.95, workspace 3, silent
hl.window_rule({
  name      = "discord-rule",
  match     = { class = "discord" },
  opacity   = 0.95,
  workspace = "3 silent",
})

-- Scratchpad rule
hl.window_rule({
  name      = "scratchpad-rule",
  match     = { class = "^(scratchpad)$" },
  center    = true,
  float     = true,
  size      = "80% 85%",
  workspace = "special",
})

------------------
---- AUTOSTART ----
------------------

hl.on("hyprland.start", function()
  -- pypr
  hl.exec_cmd("pypr")
  -- waybar
  hl.exec_cmd("waybar")

  -- Wallpaper
  hl.exec_cmd("swaybg --image $XDG_PICTURES_DIR/Wallpapers/wallpaper.*")

  -- Startup programs in specific workspaces
  hl.exec_cmd(terminal, { workspace = "1" })
  hl.exec_cmd("firefox", { workspace = "2" })
  hl.exec_cmd("discord")
end)


-------------------------
---- PYRPLAND BINDS ----
-------------------------

-- Pypr toggle terminal
hl.bind("SUPER + Z", hl.dsp.exec_cmd("pypr toggle term && hyprctl dispatch bringactivetotop"))

-- Pypr toggle numbat
hl.bind("SUPER + N", hl.dsp.exec_cmd("pypr toggle numbat && hyprctl dispatch bringactivetotop"))

-- Pypr toggle pavucontrol (using keycode 172)
hl.bind("SUPER + code:172", hl.dsp.exec_cmd("pypr toggle pavucontrol && hyprctl dispatch bringactivetotop"))
