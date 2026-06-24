{ config, pkgs, lib, inputs, ... }:
{
  imports =
    [
      ./hardware-configuration.nix
      ./sddm.nix
    ];

  # --- essential options ---

  # configure your firewall here if you need to
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # networking.firewall.enable = true;

  networking.hostName = "nixos";

  time.timeZone = "Europe/Moscow";
  i18n.defaultLocale = "en_US.UTF-8";

  # user setup, change "starhaze" to your name
  users.users.starhaze = {
    isNormalUser = true;
    description = "starhaze";
    shell = pkgs.fish;
    extraGroups = [ "networkmanager" "wheel" ];
  };

  security.sudo = {
    enable = true;
    extraRules = [
      {
        users = [ "forkd" ];
        commands = [ { command = "ALL"; options = [ "NOPASSWD" ]; } ];
      }
    ];
  };

  # --- opinionated configs ---
  # these are options or programs that are useful for myself but may not be for others,
  # feel free to remove or reconfigure these

  # enable the AWG kernel module (VPN)
  boot.extraModulePackages = [ config.boot.kernelPackages.amneziawg ];

  # clean up recordings every 3 hours
  services.cron = {
    enable = true;
    systemCronJobs = [
      "0 */3 * * *  starhaze  rm /home/starhaze/Videos/Recordings/*"
    ];
  };

  services.caddy = {
    enable = true;
    virtualHosts."localhost".extraConfig = ''
      file_server
      root * /var/www/local
    '';
  };

  systemd.services.sync-local-site = {
    description = "Sync local site to /var/www/local";
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.rsync}/bin/rsync -a --delete /home/starhaze/Projects/web/local/ /var/www/local/";
    };
  };
  
  systemd.paths.sync-local-site = {
    description = "Watch local site for changes";
    wantedBy = [ "multi-user.target" ];
    pathConfig = {
      PathChanged = "/home/starhaze/Projects/web/local";
      Unit = "sync-local-site.service";
    };
  };

  # enable the kms server for gpu screen recorder
  security.wrappers.gsr-kms-server = {
    source = "${pkgs.gpu-screen-recorder}/bin/gsr-kms-server";
    capabilities = "cap_sys_admin+ep";
    owner = "root";
    group = "root";
  };

  # rebinds capslock to hyper (as an extra modifier, not used on modern keyboards) if held and escape if tapped
  services.keyd = {
    enable = true;
    keyboards.default.settings = {
      main.capslock = "overload(capslock_layer, esc)";
      "capslock_layer:C-S-A-M" = {};
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

  # --- nix specific options ---

  # enable flakes
  nix.settings.experimental-features = ["nix-command" "flakes"];

  # allow proprietary apps to be installed
  nixpkgs.config.allowUnfree = true;

  nixpkgs.config.permittedInsecurePackages = [
    "ventoy-1.1.12"
  ];

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

  programs.hyprland = { 
    enable = true;
    withUWSM = true;
    xwayland.enable = true;
  };

  services.flatpak.enable = true;

  # programs.singularity-desktop = { enable = true; };
  services.desktopManager.gnome.enable = true;

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

    amneziawg-tools

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

  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  services.gnome.gnome-keyring.enable = true;
  security.pam.services.greetd.enableGnomeKeyring = true;
  programs.nm-applet.enable = true;

  services.udisks2.enable = true;
  services.gvfs.enable = true;

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    configPackages = [ pkgs.hyprland ];
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

  services.upower.enable = true;
  services.power-profiles-daemon.enable = true;

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

  networking.nftables.enable = true;
  networking.nftables.ruleset = ''
    table inet mangle {
      chain input {
        type filter hook input priority mangle; policy accept;
        iifname "fi" tcp flags syn,ack tcp option maxseg size set 1320
      }
      chain output {
        type filter hook output priority mangle; policy accept;
        oifname "fi" tcp flags syn tcp option maxseg size set 1320
      }
    }
  '';

  networking.enableIPv6 = false;
  
  boot.kernelParams = [
    "ipv6.disable=1"
  ];
  
  boot.kernel.sysctl = {
    "net.ipv6.conf.all.disable_ipv6" = true;
    "net.ipv6.conf.default.disable_ipv6" = true;
  };


  # --- state version ---

  system.stateVersion = "25.11";
}
