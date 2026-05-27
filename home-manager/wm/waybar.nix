{ config, pkgs, ... }:

{
  programs.waybar = {
    enable = true;

    settings = [{
      layer = "top";
      position = "top";
      height = 32;
      mode = "dock";
      margin-top = 14;
      margin-left = 14;
      margin-right = 14;

      modules-left = [
        "clock"
        "niri/workspaces"
      ];
      modules-center = [ "niri/window" ];
      modules-right = [
        "custom/swaync"
        "memory"
        "battery"
        "pulseaudio"
	"mpris"
        "custom/power"
      ];

      "custom/separator#line" = {
        format = "|";
        interval = "once";
        tooltip = false;
      };

      "custom/separator#dot" = {
        format = "";
        interval = "once";
        tooltip = false;
      };

      "custom/swaync" = {
        tooltip = true;
        tooltip-format = "Left Click: Launch Notification Center\nRight Click: Do not Disturb";
        format = "  {text} ";
        format-icons = {
          notification = "<span foreground='red'><sup></sup></span>";
          none = "";
          dnd-notification = "<span foreground='red'><sup></sup></span>";
          dnd-none = "";
          inhibited-notification = "<span foreground='red'><sup></sup></span>";
          inhibited-none = "";
          dnd-inhibited-notification = "<span foreground='red'><sup></sup></span>";
          dnd-inhibited-none = "";
        };
        return-type = "json";
        exec-if = "which swaync-client";
        exec = "swaync-client -swb";
        on-click = "sleep 0.1 && swaync-client -t -sw";
        on-click-right = "swaync-client -d -sw";
        escape = true;
      };

      "niri/workspaces" = {
        disable-scroll = true;
        format = "{icon}";
        format-icons = {
          focused = "";
          active = "";
          empty = "";
	  default = "";
        };
        all-outputs = true;
      };

      mpris = {
        format = "{status_icon}";
        status-icons = {
          playing = "󰎇";
          paused = "";
          stopped = "";
        };
      };

      clock = {
        format = "  {:%H:%M}";
        format-alt = "  {:%A, %B %d, %Y (%R)}";	
        tooltip-format = "<tt><small>{calendar}</small></tt>";
        calendar = {
          mode = "year";
          mode-mon-col = 3;
          weeks-pos = "right";
          on-scroll = 1;
          format = {
            months   = "<span color='#ffead3'><b>{}</b></span>";
            days     = "<span color='#ecc6d9'><b>{}</b></span>";
            weeks    = "<span color='#99ffdd'><b>W{}</b></span>";
            weekdays = "<span color='#ffcc66'><b>{}</b></span>";
            today    = "<span color='#ff6699'><b><u>{}</u></b></span>";
          };
        };
        actions = {
          on-click-right  = "mode";
          on-scroll-up    = "shift_up";   # de-duped from original
          on-scroll-down  = "shift_down";
        };
      };

      battery = {
        format = "󱐋  {capacity}%";
        tooltip-format = "{power}, {time} until full or empty";
      };

      memory = {
        format = "  {percentage}%";
        tooltip-format = "{used}GiB / {total}GiB used\n{swapUsed}GiB / {swapTotal} swap used\n";
      };

      pulseaudio = {
        format = "󰕾  {volume}%";
      };

      "custom/power" = {
        format = "⏻";
	on-click = "kitty --app-id=otter 'otter-launcher' 'p'";
      };
    }];

    style = ''
      @import "${config.xdg.configHome}/waybar/colors.css";

      * {
        font-family: "Poppins Semibold", "Symbols Nerd Font", Roboto, Arial;
      }

      window#waybar > box {
        margin: 0;
        padding: 0;
        background-color: @secondary_container;
        border-radius: 24px;
        box-shadow: inset 0 0 0 2px @outline;
      }

      window#waybar {
        font-size: 16px;
        background-color: transparent;
        border-radius: 24px;
      }

      .modules-left {
        margin-left: 12px;
      }

      .modules-right {
        margin-right: 12px;
      }

      #workspaces button.active {
        color: @primary;
        font-weight: bold;
      }

      #workspaces button {
        color: @on_secondary_container;
      }

      #workspaces button.empty {
        color: @on_secondary_container;
      }

      #workspaces button.active.empty {
        color: @primary;
      }

      #clock, #mpris, #battery, #pulseaudio,
      #memory, #custom-power, #custom-swaync, #window, #niri-language {
        padding: 10px;
	color: @on_secondary_container;
      }
    '';
  };
}
