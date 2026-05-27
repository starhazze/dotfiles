{ config, pkgs, lib, ... }:
{
  imports =
    [
      ./hardware-configuration.nix
    ];

  # --- essential options ---

  # configure your firewall here if you need to
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # networking.firewall.enable = true;

  networking.hostName = "nixos";

  time.timeZone = "Europe/Moscow";
  i18n.defaultLocale = "en_US.UTF-8";

  # user setup, change "forkd" to your name
  users.users.forkd = {
    isNormalUser = true;
    description = "fork";
    shell = pkgs.fish;
    extraGroups = [ "networkmanager" "wheel" ];
  };

  # --- opinionated configs ---
  # these are options or programs that are useful for myself but may not be for others,
  # feel free to remove or reconfigure these

  services.tailscale.enable = true;

  # rebinds capslock to hyper (as an extra modifier, not used on modern keyboards) if held and escape if tapped
  services.keyd = {
    enable = true;
    keyboards.default.settings = {
      main.capslock = "overload(capslock_layer, esc)";
      "capslock_layer:C-S-A-M" = {};
    };
  };

  # regreet (greetd) config, swap with your preferred display manager if you want to
  programs.regreet = {
    enable = true;
    theme.name = "adw-gtk3-dark";
    cursorTheme.name = "Bibata";
    settings = {
      background.path = "/etc/greetd/Wallpapers/Ultrakill/strays_and_v1.png";
      appearance.greeting_msg = "hello dawg. touch grass sometime";
      GTK.css_path = "/home/forkd/.config/gtk-4.0/gtk.css";
    };
    font = {
      name = "Poppins";
      size = 16;
    };
  };

  # navidrome, a music server. you'll probably not need this at all
  services.navidrome = {
    enable = true;
    settings = {
      MusicFolder = "/opt/navidrome/music";
      PlaylistsPath = "/opt/navidrome/playlists";
    };
  };

  # enable zram, adjust the memory percentage to your liking. i use 100 because i'm constantly low on memory
  zramSwap = {
    enable = true;
    algorithm = "lz4";
    memoryPercent = 100;
  };

  # pretty self explanatory
  programs.steam = { enable = true; remotePlay.openFirewall = true; };
  programs.amnezia-vpn.enable = true;

  # --- nix specific options ---

  # enable flakes
  nix.settings.experimental-features = ["nix-command" "flakes"];

  # allow proprietary apps to be installed
  nixpkgs.config.allowUnfree = true;

  # enable NH the nix cli helper
  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep 3";
    flake = "/home/forkd/dotfiles";
  };
  
  # automatically run garbage collector weekly
  # uncomment if you don't want to use NH
  #  nix.gc = {
  #    automatic = true;
  #    dates = "weekly";
  #    options = "--delete-older-than 3d";
  #  };

  # --- packages ---
  # almost all of these are pretty much needed or outright essential,
  # but still feel free to delete or swap some ones (like neovim with your preferred editor) out
  programs.fish.enable = true;
  programs.niri.enable = true;
  programs.hyprland.enable = true;
  services.flatpak.enable = true;
  programs.firefox.enable = true;

  fonts = {
    packages = with pkgs; [
      pkgs.nerd-fonts.jetbrains-mono
      pkgs.nerd-fonts.symbols-only
      pkgs.poppins
    ];
  };

  environment.systemPackages = with pkgs; [
    adwaita-icon-theme
    brightnessctl
    playerctl
    xwayland-satellite
    polkit_gnome
    cage
    dex
    python3
    neovim
    tree
    wget
    git
    bluetui
    gnumake
    cmake
    swaynotificationcenter
    p7zip
    btop
    ddcutil
    fd
    flatpak
    fzf
    gnupg
    htop
    lsof
    pavucontrol
    pick
    ripgrep
    socat
    traceroute
    jdk21
    jdk25
    docker
    docker-compose

    libsForQt5.qt5ct
    qt6Packages.qt6ct
    kdePackages.breeze
    kdePackages.breeze-icons
    kdePackages.kde-cli-tools

    pulseaudio # provides pactl
    libnotify
  ];

  # --- all the mostly static stuff i change once in a blue moon ---

  boot.loader.grub = {
    enable = true;
    useOSProber = true;
    device = "nodev";
    efiSupport = true;
    extraConfig = ''
      GRUB_TERMINAL_OUTPUT="gfxterm"
    '';
  };
  boot.loader.efi.canTouchEfiVariables = true;

  boot.initrd.luks.devices."luks-c42416f3-d1ce-4a19-853e-9751e5792d69".device = "/dev/disk/by-uuid/c42416f3-d1ce-4a19-853e-9751e5792d69";

  networking.networkmanager.enable = true;
  networking.enableIPv6 = false;

  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  services.gnome.gnome-keyring.enable = true;
  security.pam.services.login.enableGnomeKeyring = true;

  services.udisks2.enable = true;
  services.gvfs.enable = true;

  xdg.portal = {
    enable = true;
    wlr.enable = true;
  };

  qt = {
    enable = true;
    platformTheme = "qt5ct";
    style = "breeze";
  };

  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = [ pkgs.intel-media-driver pkgs.intel-vaapi-driver ];
  };

  services.libinput.enable = true;

#  services.minecraft-server = {
#    enable = true;
#    eula = true;
#    openFirewall = true;
#    package = pkgs.papermcServers.papermc-1_21_11;
#    serverProperties = {
#      difficulty = 2;
#      gamemode = 0;
#      max-players = 3;
#      enable-rcon = true;
#      "rcon.password" = "fuckinghell";
#      white-list = true;
#      motd = "super cool local server";
#    };
#    whitelist = {
#      forkd_owo = "9993ba3a-9b23-4029-bcd5-7d15a978ec71";
#    };
#  };


  # --- state version ---

  system.stateVersion = "25.11";
}
