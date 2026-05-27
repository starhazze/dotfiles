{ config, ... }: {
  xdg.configFile."niri/config.kdl".text = ''
    include "./colors.kdl"
    // --- input ---
    input {
        keyboard {
            xkb {
                layout "us,ru"
            }
        }

        touchpad {
            tap
            tap-button-map "left-right-middle"
            scroll-method "two-finger"
            // natural-scroll
        }

        focus-follows-mouse max-scroll-amount="0%"
    }

    output "eDP-1" {
        mode "1920x1080@60.012"
        scale 1
    }

    prefer-no-csd

    hotkey-overlay {
        skip-at-startup
    }

    spawn-sh-at-startup "matuwall --daemon"
    spawn-at-startup "waybar" 
    spawn-at-startup "ydotoold"
    spawn-at-startup "wl-paste" "--watch" "cliphist" "store"
    spawn-at-startup "swaync"
    spawn-at-startup "awww-daemon"
    spawn-sh-at-startup "gsr-ui launch-daemon"
    spawn-at-startup "dex --autostart --environment niri"

    overview {
      zoom 0.70
      workspace-shadow {
        off
      }
    }

    layout {
        gaps 14

        center-focused-column "never"

        preset-column-widths {
            proportion 0.33333
            proportion 0.5
            proportion 0.66667
        }

        default-column-width { proportion 0.5; }

        background-color "transparent"
        focus-ring {
	    width 2
        //    active-color "#b7bdf8"
        //    inactive-color "#6e738d"
        //    urgent-color "#fcb167"
        }

        border {
            off
            width 4
            active-color "#ffc87f"
            inactive-color "#505050"
            urgent-color "#9b0000"
        }

        shadow {
            off
            draw-behind-window true
            softness 30
            spread 5
            offset x=0 y=5
            color "#0007"
        }	

        struts {
            // left 64
            // right 64
            // top 64
            // bottom 64
        }
    }

    animations {
        workspace-switch {
            spring damping-ratio=0.8 stiffness=600 epsilon=0.0001
        }

        window-open {
            spring damping-ratio=0.8 stiffness=700 epsilon=0.0001
        }

        window-close {
            duration-ms 150
            curve "ease-out-quad"
        }

        horizontal-view-movement {
            spring damping-ratio=0.8 stiffness=450 epsilon=0.0001
        }

        window-movement {
            spring damping-ratio=0.7 stiffness=500 epsilon=0.0001
        }

        window-resize {
            spring damping-ratio=0.7 stiffness=500 epsilon=0.0001
        }

        config-notification-open-close {
            spring damping-ratio=0.6 stiffness=1000 epsilon=0.001
        }

        exit-confirmation-open-close {
            spring damping-ratio=0.6 stiffness=500 epsilon=0.01
        }

        screenshot-ui-open {
            duration-ms 200
            curve "ease-out-quad"
        }

        overview-open-close {
            spring damping-ratio=0.7 stiffness=600 epsilon=0.0001
        }

        recent-windows-close {
            spring damping-ratio=0.7 stiffness=600 epsilon=0.001
        }
    }

    window-rule {
        geometry-corner-radius 12
        clip-to-geometry true
    }

    window-rule {
        match app-id="otter"
        open-floating true
        default-column-width { fixed 600; }
        default-window-height { fixed 400; }
    }

    window-rule {
        match app-id="matugen-picker"
        open-floating true
        default-column-width { fixed 1200; }
        default-window-height { fixed 800; }
    }

    binds {
        Mod+Shift+E { quit; }
        Ctrl+Alt+Delete { quit; }

        Mod+Shift+Slash { show-hotkey-overlay; }

        Mod+O repeat=false { toggle-overview; }

        Print { screenshot; }

        Mod+Return { spawn "kitty"; }
        Mod+BackSlash { spawn "kitty" "yazi"; }
        Alt+Space { spawn "kitty" "--app-id" "'otter'" "otter-launcher"; }

	// !! the long ass keybinds are just capslock, i rebound it to that combo in my nixos config !!
	Ctrl+Alt+Shift+Super+F { spawn "kitty"; }
	Ctrl+Alt+Shift+Super+C { spawn "kitty" "--app-id" "'otter'" "otter-launcher"; } 
	Ctrl+Alt+Shift+Super+D { spawn "sh" "-c" "kitty --app-id matugen-picker yazi ~/Pictures/Wallpapers"; }
        Ctrl+Alt+Shift+Super+E { spawn "kitty" "yazi"; } 

        Ctrl+Alt+Shift+Super+W { switch-layout "next"; } 

        Mod+Space {
            switch-layout "next"
        }

        Mod+Comma { consume-window-into-column; }
        Mod+Period { expel-window-from-column; }

        Alt+F4 { close-window; }
        Mod+Q { close-window; }

        Mod+R { switch-preset-column-width; }
        Mod+Shift+R { switch-preset-window-height; }
        Mod+Ctrl+R { reset-window-height; }

        Mod+Shift+F { maximize-column; }
        Mod+Ctrl+F { expand-column-to-available-width; }

        Mod+C { center-column; }
        Mod+Ctrl+C { center-visible-columns; }

        Mod+Minus { set-column-width "-10%"; }
        Mod+Equal { set-column-width "+10%"; }
        Mod+Shift+Minus { set-window-height "-10%"; }
        Mod+Shift+Equal { set-window-height "+10%"; }

        Mod+V { toggle-window-floating; }
        Mod+Shift+V { switch-focus-between-floating-and-tiling; }

        Mod+W { toggle-column-tabbed-display; }

        Mod+H { focus-column-left; }
        Mod+J { focus-window-down; }
        Mod+K { focus-window-up; }
        Mod+L { focus-column-right; }

        Mod+Left { focus-column-left; }
        Mod+Down { focus-window-down; }
        Mod+Up { focus-window-up; }
        Mod+Right { focus-column-right; }

        Mod+Shift+H { move-column-left; }
        Mod+Shift+J { move-window-down; }
        Mod+Shift+K { move-window-up; }
        Mod+Shift+L { move-column-right; }

        Mod+Shift+Left { move-column-left; }
        Mod+Shift+Down { move-window-down; }
        Mod+Shift+Up { move-window-up; }
        Mod+Shift+Right { move-column-right; }

        Mod+WheelScrollDown cooldown-ms=150 { focus-workspace-down; }
        Mod+WheelScrollUp cooldown-ms=150 { focus-workspace-up; }
        Mod+Ctrl+WheelScrollDown cooldown-ms=150 { move-column-to-workspace-down; }
        Mod+Ctrl+WheelScrollUp cooldown-ms=150 { move-column-to-workspace-up; }

        Mod+WheelScrollRight { focus-column-right; }
        Mod+WheelScrollLeft { focus-column-left; }
        Mod+Ctrl+WheelScrollRight { move-column-right; }
        Mod+Ctrl+WheelScrollLeft { move-column-left; }

        Mod+Shift+WheelScrollDown { focus-column-right; }
        Mod+Shift+WheelScrollUp { focus-column-left; }
        Mod+Ctrl+Shift+WheelScrollDown { move-column-right; }
        Mod+Ctrl+Shift+WheelScrollUp { move-column-left; }

        Mod+F { fullscreen-window; }
        F11 { fullscreen-window; }

        Mod+Shift+Space { toggle-window-floating; }

        Mod+1 { focus-workspace 1; }
        Mod+2 { focus-workspace 2; }
        Mod+3 { focus-workspace 3; }
        Mod+4 { focus-workspace 4; }
        Mod+5 { focus-workspace 5; }
        Mod+6 { focus-workspace 6; }
        Mod+7 { focus-workspace 7; }
        Mod+8 { focus-workspace 8; }
        Mod+9 { focus-workspace 9; }
        Mod+0 { focus-workspace 10; }

        Mod+Shift+1 { move-window-to-workspace 1; }
        Mod+Shift+2 { move-window-to-workspace 2; }
        Mod+Shift+3 { move-window-to-workspace 3; }
        Mod+Shift+4 { move-window-to-workspace 4; }
        Mod+Shift+5 { move-window-to-workspace 5; }
        Mod+Shift+6 { move-window-to-workspace 6; }
        Mod+Shift+7 { move-window-to-workspace 7; }
        Mod+Shift+8 { move-window-to-workspace 8; }
        Mod+Shift+9 { move-window-to-workspace 9; }
        Mod+Shift+0 { move-window-to-workspace 10; }

        XF86AudioMute {
            spawn "pactl" "set-sink-mute" "@DEFAULT_SINK@" "toggle"
        }

        XF86AudioLowerVolume {
            spawn "pactl" "set-sink-volume" "@DEFAULT_SINK@" "-5%"
        }

        XF86AudioRaiseVolume {
            spawn "pactl" "set-sink-volume" "@DEFAULT_SINK@" "+5%"
        }

        XF86AudioMicMute {
            spawn "pactl" "set-source-mute" "@DEFAULT_SOURCE@" "toggle"
        }

        XF86MonBrightnessDown {
            spawn "brightnessctl" "set" "5%-"
        }

        XF86MonBrightnessUp {
            spawn "brightnessctl" "set" "5%+"
        }
    }

    workspace "󰖟"
    workspace ""
    workspace "󰅴"
    workspace ""
    workspace "󰍡"
    workspace "󰊖"
    workspace ""
    workspace "󰇘"
  '';
}
