{ ... }: {
  services.swaync = {
    enable = true;
    settings = {
      positionX = "right";
      positionY = "top";
      cssPriority = "user";
    
      layer = "overlay";
      control-center-layer = "top";
      layer-shell = true;
    
      control-center-width = 390;
      control-center-height = 800;
      control-center-margin-top = 10;
      control-center-margin-bottom = 10;
      control-center-margin-right = 10;
      control-center-margin-left = 0;
    
      notification-window-width = 380;
      notification-icon-size = 50;
      notification-body-image-height = 200;
      notification-body-image-width = 200;
    
      timeout = 8;
      timeout-low = 6;
      timeout-critical = 0;
    
      fit-to-screen = false;
      keyboard-shortcuts = true;
      image-visibility = "when-available";
      transition-time = 200;
      hide-on-clear = false;
      hide-on-action = true;
      text-empty = "No Notifications";
      script-fail-notify = true;
    
      notification-visibility = {
        example-name = {
          state = "muted";
          urgency = "Low";
          app-name = "Spotify";
        };
      };
    
      widgets = [
        "buttons-grid"
        "mpris"
        "volume"
        "backlight"
        "dnd"
        "title"
        "notifications"
      ];
    
      widget-config = {
        mpris = {
          image-size = 50;
          image-radius = 0;
        };
        volume = {
          label = " 󰕾 ";
          expand-button-label = " ";
          collapse-button-label = " ";
          show-per-app = true;
          show-per-app-icon = true;
          show-per-app-label = false;
        };
        backlight = {
          label = "󰃟 ";
        };
        dnd = {
          text = "Do Not Disturb";
        };
        title = {
          text = "Notifications Center";
          clear-all-button = true;
          button-text = " 󰆴 ";
        };
        buttons-grid = {
          actions = [
            {
              label = " ";
              type = "toggle";
              active = true;
              command = "sh -c '[[ $SWAYNC_TOGGLE_STATE == true ]] && nmcli radio wifi on || nmcli radio wifi off'";
              update-command = "sh -c '[[ $(nmcli r wifi) == \"enabled\" ]] && echo true || echo false'";
            }
            {
              label = "󰂯";
              type = "toggle";
              active = true;
              command = "sh -c '[[ $SWAYNC_TOGGLE_STATE == true ]] && rfkill unblock bluetooth || rfkill block bluetooth'";
              update-command = "sh -c \"rfkill list bluetooth | grep -q \\\"Soft blocked: no\\\" && echo true || echo false\"";
            }
            {
              label = " ";
              type = "toggle";
              active = false;
              command = "sh -c '[[ $SWAYNC_TOGGLE_STATE == true ]] && pactl set-source-mute @DEFAULT_SOURCE@ 1 || pactl set-source-mute @DEFAULT_SOURCE@ 0'";
              update-command = "sh -c '[[ $(pactl get-source-mute @DEFAULT_SOURCE@) == *yes* ]] && echo true || echo false'";
            }
            {
              label = " ";
              type = "toggle";
              active = false;
              command = "sh -c '[[ $SWAYNC_TOGGLE_STATE == true ]] && pactl set-sink-mute @DEFAULT_SINK@ 1 || pactl set-sink-mute @DEFAULT_SINK@ 0'";
              update-command = "sh -c '[[ $(pactl get-sink-mute @DEFAULT_SINK@) == *yes* ]] && echo true || echo false'";
            }
          ];
        };
      };
    };
    style = ''
      @import "colors.css";
    
      @define-color cc_bg        @secondary_container;
      @define-color cc_bg_alt    @surface_container_high;
      @define-color cc_fg        @on_secondary_container;
      @define-color cc_fg_muted  @on_surface_variant;
      @define-color cc_border    @outline;
      @define-color cc_accent    @primary;
      @define-color cc_accent_fg @on_primary;
      @define-color cc_danger    @error_container;
      @define-color cc_danger_fg @on_error_container;
    
      * {
          font-family: "Poppins Semibold", "Symbols Nerd Font";
          font-size: 15px;
          outline: none;
          border: none;
          text-shadow: none;
          color: @cc_fg;
      }
    
      .control-center {
          background-color: @cc_bg;
          border-radius: 24px;
	  border: 2px solid @outline;
          padding: 8px;
          box-shadow: 0 4px 16px alpha(@shadow, 0.3);
      }
    
      .control-center .notification-row .notification-background {
          background-color: transparent;
          border-radius: 12px;
          margin-top: 6px;
      }
    
      .notification {
          background-color: @cc_bg;
          color: @cc_fg;
          border-radius: 12px;
          border: 2px solid alpha(@cc_border, 0.4);
          margin: 16px;
      }
    
      .notification > *:last-child > * {
          margin: 6px;
      }
    
      .notification-group {
          background-color: @cc_bg;
          border-radius: 16px;
          border: 1px solid alpha(@cc_border, 0.3);
          padding: 4px 4px 0 4px;
          margin-top: 6px;
      }
    
      .summary,
      .body,
      .widget-title > label,
      .widget-dnd > label,
      .widget-backlight > label,
      .widget-volume label,
      .widget-mpris .widget-mpris-title {
          color: @cc_fg;
      }
    
      .time,
      .widget-mpris .widget-mpris-subtitle,
      .notification-group-header,
      .notification-group-icon {
          color: @cc_fg_muted;
      }
    
      .summary { font-size: 1.02rem; padding-left: 12px; }
      .time    { font-size: 0.8rem; }
      .body    { font-size: 0.95rem; padding-left: 12px; }
    
      .notification-content {
          padding: 12px 12px 10px 14px;
      }
    
      .notification-action > button {
          background-color: @surface_container_highest;
          border-radius: 8px;
          padding: 6px;
          margin: 6px;
          color: @cc_fg;
      }
    
      .notification-action > label {
          font-size: 0.95rem;
          color: @cc_fg;
      }
    
      .notification.critical {
          background-color: @cc_danger;
          border: 1px solid alpha(@error, 0.5);
          color: @cc_danger_fg;
      }
    
      .notification.low,
      .notification.normal {
          background-color: @cc_bg_alt;
          border: 1px solid alpha(@cc_border, 0.4);
      }
    
      .close-button {
          background-color: @surface_container_highest;
          color: @cc_fg;
          padding: 6px;
          margin: 14px;
          border-radius: 999px;
      }
    
      .close-button:hover {
          background-color: @error;
          color: @on_error;
      }
    
      .notification-group-header,
      .notification-group-icon {
          font-size: 0.9rem;
      }
    
      .notification-group-collapse-button,
      .notification-group-close-all-button {
          background-color: @surface_container_highest;
          color: @cc_fg;
          border-radius: 999px;
      }
    
      .notification-group-collapse-button:hover {
          background-color: alpha(@surface_container_highest, 0.8);
      }
    
      .notification-group-close-all-button:hover {
          background-color: @error;
          color: @on_error;
      }
    
      scale trough {
          background-color: alpha(@cc_border, 0.5);
          border-radius: 999px;
          min-height: 6px;
          min-width: 100px;
          margin: 0 12px;
      }
    
      scale trough highlight {
          background-color: @cc_accent;
          border-radius: 999px;
      }
    
      scale trough slider {
          background-color: @cc_accent;
          border-radius: 999px;
          min-width: 14px;
          min-height: 14px;
          margin: -4px 0;
          box-shadow: none;
      }
    
      tooltip {
          background-color: @inverse_surface;
          color: @inverse_on_surface;
          border-radius: 10px;
      }
    
      scrollbar {
          background: transparent;
          min-width: 1px;
          margin: 6px 2px 6px 0;
      }
    
      scrollbar trough {
          background: transparent;
      }
    
      scrollbar slider {
          background-color: alpha(@cc_fg_muted, 0.35);
          border-radius: 999px;
          min-width: 1px;
          min-height: 16px;
      }
    
      scrollbar slider:hover {
          background-color: alpha(@cc_fg_muted, 0.55);
      }

      .control-center scrolledwindow {
          background: transparent;
          border: none;
          box-shadow: none;
      }

      .widget-buttons-grid {
          font-size: 1rem;
          padding: 14px 14px 8px;
      }
    
      .widget-buttons-grid > flowbox > flowboxchild > button {
          background: @surface_container_highest;
          color: @cc_fg;
          border-radius: 12px;
          min-width: 56px;
          min-height: 32px;
          padding: 6px;
          margin: 0 3px;
          transition: background 0.2s ease;
          border: 1px solid @outline_variant;
      }

      .widget-buttons-grid > flowbox > flowboxchild > button:hover {
          background: alpha(@on_surface, 0.08);
      }
    
      .widget-buttons-grid > flowbox > flowboxchild > button.toggle:checked {
          background: @primary_container;
          color: @on_primary_container;
      }
    
      .widget-buttons-grid > flowbox > flowboxchild > button.toggle:checked:hover {
          background: alpha(@primary_container, 0.85);
      }
    
      @define-color mpris-album-art-overlay rgba(0, 0, 0, 0.35);
      @define-color mpris-button-hover rgba(0, 0, 0, 0.15);
    
      .widget-mpris .widget-mpris-player {
          background-color: @cc_bg_alt;
          border-radius: 16px;
          border: 1px solid alpha(@cc_border, 0.3);
          padding: 14px;
          margin: 8px 12px;
      }
    
      .widget-mpris .widget-mpris-player .widget-mpris-album-art {
          border-radius: 8px;
      }
    
      .widget-mpris .widget-mpris-player .widget-mpris-title {
          font-weight: bold;
          font-size: 1.1rem;
          color: @cc_fg;
      }
    
      .widget-mpris .widget-mpris-player .widget-mpris-subtitle {
          font-size: 0.95rem;
          color: @cc_fg_muted;
      }
    
      .widget-mpris .widget-mpris-player > box > button:hover {
          background-color: alpha(@on_surface, 0.08);
          border-radius: 999px;
      }
    
      .widget-mpris > box > button:hover {
          background-color: alpha(@on_surface, 0.06);
          border-radius: 999px;
      }
    
      .widget-volume {
          padding: 4px 16px;
          font-size: 1.15rem;
          color: @cc_fg;
      }
    
      .widget-volume > box > button {
          color: @cc_fg;
      }
    
      .per-app-volume {
          padding: 4px 8px 8px 8px;
          margin: 0 8px 8px 8px;
      }
    
      .widget-backlight {
          padding: 4px 16px;
          font-size: 1.05rem;
          color: @cc_fg;
      }
    
      .widget-dnd {
          font-weight: bold;
          padding: 12px 16px;
          color: @cc_fg;
      }
    
      .widget-dnd > switch {
          border-radius: 999px;
          background: @surface_container_highest;
          padding: 3px;
      }
    
      .widget-dnd > switch:checked {
          background: @cc_accent;
      }
    
      .widget-dnd > switch:not(:checked) slider {
          background: @on_surface;
      }
    
      .widget-dnd > switch slider {
          background: @on_primary;
          border-radius: 999px;
          min-width: 18px;
          min-height: 18px;
      }
    
      .widget-title {
          padding: 14px 16px;
          font-weight: bold;
          color: @cc_fg;
      }
    
      .widget-title > label {
          font-size: 1.25rem;
          color: @cc_fg;
      }
    
      .widget-title > button {
          padding: 4px 12px;
          background: @error;
          color: @on_error;
          border-radius: 999px;
          transition: background 0.2s ease;
      }
    
      .widget-title > button:hover {
          background: alpha(@error, 0.85);
      }
    '';
  };
}
