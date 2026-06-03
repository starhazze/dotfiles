{ pkgs, pkgs-stable, inputs, ... }:

{ 
  home = {
    packages = with pkgs; [
      # --- shell ---
      inputs.caelestia-cli.packages.${system}.default
      inputs.caelestia-shell.packages.${system}.default

      # --- required for rice ---
      inputs.matugen.packages.${system}.default
      pywalfox-native
      kitty
      nautilus
      eza
      bat
      awww
      hyprpaper
      wl-clipboard
      flameshot
      fsel
      kdePackages.gwenview
      yazi
      glib
      adw-gtk3

      # --- deps for some yazi & caelestia features - optional but recommended ---
      exiftool
      mediainfo
      gpu-screen-recorder

      # --- personal apps i use, you can remove these ---
      inkscape
      easyeffects
      kdePackages.elisa
      kdePackages.kdeconnect-kde
      librewolf
      inputs.firefox.packages.${pkgs.stdenv.hostPlatform.system}.firefox-nightly-bin
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
      inputs.ckgpkgs.packages.${pkgs.system}.commet-chat

      godot

      osu-lazer-bin
      prismlauncher
      heroic
      r2modman
    ];
  };
}
