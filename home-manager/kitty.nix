{ config, ... }: {
  programs.kitty = {
    enable = true;
    #themeFile = "Catppuccin-Macchiato";
    font = {
      name = "JetBrainsMono Nerd Font";
      size = 12;
    };
    shellIntegration = { 
      enableFishIntegration = true;
    };
    extraConfig = "
      include ${config.xdg.configHome}/kitty/current-theme.conf
      confirm_os_window_close 0
      cursor_trail 1
      scrollback_lines 2000
      wheel_scroll_min_lines 1
      enable_audio_bell no
      window_padding_width 20
      selection_foreground none
      selection_background none

      background_opacity 0.95
      background_blur 24
      
      mouse_map alt+left press ungrabbed mouse_selection rectangle";
  };
}
