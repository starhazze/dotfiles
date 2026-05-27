{ config, ... }: {
  programs.yazi = {
    enable = true;
    shellWrapperName = "y";
    settings = {
      opener = {
        wallpaper-dark = [
          {
            run = ''matugen image -m dark "$@"''; 
            desc = "Set as wallpaper (dark mode)";
            shell = true;
	    block = true;
          }
        ];
        wallpaper-light = [
          {
            run = ''matugen image -m light "$@"''; 
            desc = "Set as wallpaper (light mode)";
            shell = true;
	    block = true;
          }
        ];
      };
      open = {
        prepend_rules = [
          {
            mime = "image/*";
            use = [ "open" "wallpaper-dark" "wallpaper-light" "reveal" ];
          }
        ];
      };
    };
  };
}
