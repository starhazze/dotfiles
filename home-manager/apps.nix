{ pkgs, pkgs-stable, inputs, ... }:

{ 
  home = {
    packages = with pkgs; [
      # --- required for rice ---
      inputs.matugen.packages.${system}.default
      pywalfox-native
      kitty
      thunar
      eza
      bat
      awww
      fsel
      kdePackages.gwenview
      yazi
      glib
      adw-gtk3 

      # --- deps for some yazi features - optional but recommended ---
      exiftool
      mediainfo

      # --- personal apps i use, you can remove these ---
      inkscape
      easyeffects
      kdePackages.elisa
      kdePackages.kdeconnect-kde
      librewolf
      obs-studio
      qbittorrent
      vscodium
      cinny
      vlc
      redact
      feishin
      insomnia
      lmms
      ayugram-desktop
      fluffychat

      osu-lazer-bin
      prismlauncher
      heroic
      r2modman
    ];
  };
}
