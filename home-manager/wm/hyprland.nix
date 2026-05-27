{ config, ... }: {

  xdg.configFile."hypr/vars.lua".text = ''
    return {
      term        = "kitty",
      screenshot  = "caelestia shell picker open",
      files       = "nautilus",
      dmenu       = "caelestia shell drawers toggle launcher",
      shell       = "caelestia-shell -d",
      notifcenter = "caelestia shell drawers toggle sidebar"
    }
  '';

  xdg.configFile."hypr/hyprland.lua".text = ''
    package.path = package.path .. ';' .. os.getenv('HOME') .. '/.config/hypr/?.lua'
    require("binds")
    require("misc")
    require("rules")

    ------------
    -- CONFIG --
    ------------

    hl.config({
      general = {
        gaps_in  = 7,
        gaps_out = 14,
        border_size = 2,
        col = {
          active_border   = rgba(c.primary,  "b7bdf8"),
          inactive_border = rgba(c.outline,  "6e738d"),
        },
        layout           = "scrolling",
        resize_on_border = true,
      },

      decoration = {
        rounding         = 12,
        active_opacity   = 1.0,
        inactive_opacity = 1.0,
        shadow = {
          enabled = false,
        },
        blur = {
          enabled = true,
        },
      },

      input = {
        kb_layout    = "us,ru",
        follow_mouse = 1,
        touchpad = {
          tap_to_click   = true,
          tap_button_map = "lrm",
        },
      },

      misc = {
        force_default_wallpaper = 0,
        disable_hyprland_logo   = true,
      },

      animations = {
        enabled = true,
      },
    })

    ----------------
    -- ANIMATIONS --
    ----------------

    hl.curve("snap",       { type = "bezier", points = { {0.19, 1}, {0.22, 1} } })
    hl.curve("smooth",     { type = "bezier", points = { {0.4, 0},  {0.2, 1}  } })
    hl.curve("snappyOut",  { type = "bezier", points = { {0.23, 1}, {0.32, 1} } })
    hl.curve("linear",     { type = "bezier", points = { {0, 0},    {1, 1}    } })
    
    hl.animation({ leaf = "windows",          enabled = true, speed = 4,   bezier = "snap",      style = "slide" })
    hl.animation({ leaf = "windowsIn",        enabled = true, speed = 4,   bezier = "snap",      style = "slide" })
    hl.animation({ leaf = "windowsOut",       enabled = true, speed = 3,   bezier = "snappyOut", style = "slide" })
    hl.animation({ leaf = "border",           enabled = true, speed = 6,   bezier = "smooth" })
    hl.animation({ leaf = "fade",             enabled = true, speed = 4,   bezier = "smooth" })
    hl.animation({ leaf = "fadeIn",           enabled = true, speed = 3,   bezier = "smooth" })
    hl.animation({ leaf = "fadeOut",          enabled = true, speed = 2.5, bezier = "smooth" })
    hl.animation({ leaf = "layers",           enabled = true, speed = 3,   bezier = "snap",      style = "slide" })
    hl.animation({ leaf = "layersIn",         enabled = true, speed = 3,   bezier = "snap",      style = "fade"  })
    hl.animation({ leaf = "layersOut",        enabled = true, speed = 2,   bezier = "linear",    style = "fade"  })
    hl.animation({ leaf = "workspaces",       enabled = true, speed = 4,   bezier = "snap",      style = "slide" })
    hl.animation({ leaf = "workspacesIn",     enabled = true, speed = 4,   bezier = "snap",      style = "slide" })
    hl.animation({ leaf = "workspacesOut",    enabled = true, speed = 3,   bezier = "snappyOut", style = "slide" })
    hl.animation({ leaf = "specialWorkspace", enabled = true, speed = 4,   bezier = "snap",      style = "slidevert" })
  '';

  xdg.configFile."hypr/binds.lua".text = ''
    package.path = package.path .. ';' .. os.getenv('HOME') .. '/.config/hypr/?.lua'
    local var = require("vars")
    --------------
    -- KEYBINDS --
    --------------

    local M = "SUPER"

    -- exit
    local exitCmd = "caelestia shell drawers toggle session"
    hl.bind(M .. " + SHIFT + E",   hl.dsp.exec_cmd(exitCmd))
    hl.bind("CTRL + ALT + Delete", hl.dsp.exec_cmd(exitCmd))

    -- apps
    hl.bind(M .. " + Return",    hl.dsp.exec_cmd(var.term))
    hl.bind(M .. " + backslash", hl.dsp.exec_cmd(var.files))
    hl.bind("ALT + Space",       hl.dsp.exec_cmd(var.dmenu))

    -- open the sidebar
    hl.bind(M .. " + O",     hl.dsp.exec_cmd(var.notifcenter))

    -- capslock combos (caps is rebound to Ctrl+Alt+Shift+Super in nixos config)
    hl.bind("CTRL + ALT + SHIFT + SUPER + F", hl.dsp.exec_cmd(var.term))
    -- hl.bind("CTRL + ALT + SHIFT + SUPER + E", hl.dsp.exec_cmd(var.term yazi))

    -- keyboard layout cycle
    hl.bind(M .. " + Space",                  hl.dsp.exec_cmd("hyprctl switchxkblayout all next"))
    hl.bind("CTRL + ALT + SHIFT + SUPER + W", hl.dsp.exec_cmd("hyprctl switchxkblayout all next"))

    -- window management
    hl.bind("ALT + F4",           hl.dsp.window.close())
    hl.bind(M .. " + Q",          hl.dsp.window.close())
    hl.bind(M .. " + F",          hl.dsp.window.fullscreen())
    hl.bind("F11",                hl.dsp.window.fullscreen())
    hl.bind(M .. " + SHIFT + F",  hl.dsp.window.fullscreen({ mode = 1 }))
    hl.bind(M .. " + CTRL + F",   hl.dsp.window.fullscreen({ mode = 1 }))
    hl.bind(M .. " + V",          hl.dsp.window.float({ action = "toggle" }))
    hl.bind(M .. " + SHIFT + V",  hl.dsp.window.float({ action = "toggle" }))
    hl.bind(M .. " + SHIFT + SPACE",  hl.dsp.window.float({ action = "toggle" }))

    -- scrolling layout: consume/expel
    hl.bind(M .. " + comma",  hl.dsp.layout("consume"))
    hl.bind(M .. " + period", hl.dsp.layout("expel"))

    -- screenshot
    hl.bind("Print", hl.dsp.exec_cmd(var.screenshot))

    -- focus (vim + arrows)
    hl.bind(M .. " + H",     hl.dsp.focus({ direction = "left" }))
    hl.bind(M .. " + J",     hl.dsp.focus({ direction = "down" }))
    hl.bind(M .. " + K",     hl.dsp.focus({ direction = "up" }))
    hl.bind(M .. " + L",     hl.dsp.focus({ direction = "right" }))
    hl.bind(M .. " + left",  hl.dsp.focus({ direction = "left" }))
    hl.bind(M .. " + down",  hl.dsp.focus({ direction = "down" }))
    hl.bind(M .. " + up",    hl.dsp.focus({ direction = "up" }))
    hl.bind(M .. " + right", hl.dsp.focus({ direction = "right" }))

    -- move windows (vim + arrows)
    hl.bind(M .. " + SHIFT + H",     hl.dsp.window.move({ direction = "left" }))
    hl.bind(M .. " + SHIFT + J",     hl.dsp.window.move({ direction = "down" }))
    hl.bind(M .. " + SHIFT + K",     hl.dsp.window.move({ direction = "up" }))
    hl.bind(M .. " + SHIFT + L",     hl.dsp.window.move({ direction = "right" }))
    hl.bind(M .. " + SHIFT + left",  hl.dsp.window.move({ direction = "left" }))
    hl.bind(M .. " + SHIFT + down",  hl.dsp.window.move({ direction = "down" }))
    hl.bind(M .. " + SHIFT + up",    hl.dsp.window.move({ direction = "up" }))
    hl.bind(M .. " + SHIFT + right", hl.dsp.window.move({ direction = "right" }))

    -- mouse scroll: workspace switching
    hl.bind(M .. " + mouse_down",           hl.dsp.focus({ workspace = "e-1" }))
    hl.bind(M .. " + mouse_up",             hl.dsp.focus({ workspace = "e+1" }))
    hl.bind(M .. " + CTRL + mouse_down",    hl.dsp.window.move({ workspace = "e-1" }))
    hl.bind(M .. " + CTRL + mouse_up",      hl.dsp.window.move({ workspace = "e+1" }))

    -- mouse scroll: column focus
    hl.bind(M .. " + mouse_right",          hl.dsp.focus({ direction = "r" }))
    hl.bind(M .. " + mouse_left",           hl.dsp.focus({ direction = "l" }))
    hl.bind(M .. " + CTRL + mouse_right",   hl.dsp.window.move({ direction = "r" }))
    hl.bind(M .. " + CTRL + mouse_left",    hl.dsp.window.move({ direction = "l" }))

    -- focus-column-right/left
    hl.bind(M .. " + SHIFT + mouse_down",         hl.dsp.focus({ direction = "r" }))
    hl.bind(M .. " + SHIFT + mouse_up",           hl.dsp.focus({ direction = "l" }))
    hl.bind(M .. " + CTRL + SHIFT + mouse_down",  hl.dsp.window.move({ direction = "r" }))
    hl.bind(M .. " + CTRL + SHIFT + mouse_up",    hl.dsp.window.move({ direction = "l" }))

    -- mouse: drag and resize windows
    hl.bind(M .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
    hl.bind(M .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

    -- workspaces 1-10
    for i = 1, 10 do
      local key = i % 10  -- 10 → key 0
      hl.bind(M .. " + " .. key,         hl.dsp.focus({ workspace = i }))
      hl.bind(M .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
    end

    -- media keys
    hl.bind("XF86AudioMute",         hl.dsp.exec_cmd("pactl set-sink-mute @DEFAULT_SINK@ toggle"),     { locked = true })
    hl.bind("XF86AudioLowerVolume",  hl.dsp.exec_cmd("pactl set-sink-volume @DEFAULT_SINK@ -5%"),      { locked = true, repeating = true })
    hl.bind("XF86AudioRaiseVolume",  hl.dsp.exec_cmd("pactl set-sink-volume @DEFAULT_SINK@ +5%"),      { locked = true, repeating = true })
    hl.bind("XF86AudioMicMute",      hl.dsp.exec_cmd("pactl set-source-mute @DEFAULT_SOURCE@ toggle"), { locked = true })
    hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl set 5%-"),                         { locked = true, repeating = true })
    hl.bind("XF86MonBrightnessUp",   hl.dsp.exec_cmd("brightnessctl set 5%+"),                         { locked = true, repeating = true })
  '';

  xdg.configFile."hypr/rules.lua".text = ''
    ------------------
    -- WINDOW RULES --
    ------------------

    hl.window_rule({
      name  = "global-rounding",
      match = { class = ".*" },
      rounding = 12,
    })

    hl.window_rule({
      name  = "suppress-maximize",
      match = { class = ".*" },
      suppress_event = "maximize",
    })

    hl.window_rule({
      name  = "otter-launcher",
      match = { class = "^otter$" },
      float = true,
      size  = "600 400",
    })

    hl.window_rule({
      name  = "matugen-picker",
      match = { class = "^matugen-picker$" },
      float = true,
      size  = "1200 800",
    })
  '';

  xdg.configFile."hypr/misc.lua".text = ''
    package.path = package.path .. ';' .. os.getenv('HOME') .. '/.config/hypr/?.lua'
    local var = require("vars")

    ---------------
    -- AUTOSTART --
    ---------------

    hl.on("hyprland.start", function()
      hl.exec_cmd(var.shell)
      hl.exec_cmd("ydotoold")
      hl.exec_cmd("wl-paste --watch cliphist store")
      hl.exec_cmd("hyprpaper")
      hl.exec_cmd("gsr-ui launch-daemon")
      hl.exec_cmd("dex --autostart --environment hyprland")
    end)

    ------------
    -- MONITOR --
    ------------

    hl.monitor({
      output   = "eDP-1",
      mode     = "1920x1080@60.012",
      position = "auto",
      scale    = 1,
    })

    ----------
    -- ENV  --
    ----------

    hl.env("XCURSOR_SIZE",   "24")
    hl.env("HYPRCURSOR_SIZE", "24")

    ------------------
    -- COLOR SCHEME --
    ------------------
    -- reads ~/.config/hypr/scheme/current.conf (managed by caelestia)

    function loadScheme(path)
      local scheme = {}
      local f = io.open(path, "r")
      if not f then return scheme end
      for line in f:lines() do
        local key, val = line:match("^%$(%w+)%s*=%s*(%x+)%s*$")
        if key and val then scheme[key] = val end
      end
      f:close()
      return scheme
    end

    home = os.getenv("HOME")
    c = loadScheme(home .. "/.config/hypr/scheme/current.conf")

    -- wrap a 6-char hex into rgba(rrggbbaa); fallback used if key missing
    function rgba(hex, fallback, alpha)
      local h = hex or fallback
      return "rgba(" .. h .. (alpha or "ff") .. ")"
    end
  '';

}
