{ pkgs, config, lib, ... }: {
  imports = [ ./wm/hyprland.nix ./wm/caelestia.nix ./wm/matugen.nix ./fish.nix ./kitty.nix ./nvim.nix ./apps.nix ./fastfetch.nix ./yazi.nix ];
  home.username = "starhaze";
  home.homeDirectory = "/home/starhaze";
  home.stateVersion = "25.11";

  gtk = {
    enable = true;
    theme = {
      name = "adw-gtk3-dark";
      package = pkgs.adw-gtk3;
    };
    gtk4.theme = config.gtk.theme;
    gtk3.extraCss = "@import 'colors.css';";
    gtk4.extraCss = "@import 'colors.css';";
  };

  services.gnome-keyring = {
    enable = true;
    components = [ "secrets" ];
  };

  home.file.".local/share/themes/adw-gtk3".source = "${pkgs.adw-gtk3}/share/themes/adw-gtk3";
  home.file.".local/share/themes/adw-gtk3-dark".source = "${pkgs.adw-gtk3}/share/themes/adw-gtk3-dark";

  home.pointerCursor = 
    let 
      getFrom = url: hash: name: {
          gtk.enable = true;
          x11.enable = true;
          name = name;
          size = 24;
          package = 
            pkgs.runCommand "moveUp" {} ''
              mkdir -p $out/share/icons
              ln -s ${pkgs.fetchzip {
                url = url;
                hash = hash;
              }} $out/share/icons/${name}
          '';
        };
    in
      getFrom 
        "https://github.com/ful1e5/Bibata_Cursor/releases/download/v2.0.7/Bibata-Modern-Classic.tar.xz"
        "sha256-2Fd0OVSCgFZVLRAVo/MxgHp1qK5WUNhKY685XPYrBmk="
        "Bibata-Classic";

  xdg.userDirs.createDirectories = true;
}
