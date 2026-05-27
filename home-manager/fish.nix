{ pkgs, ... }: {
  programs.fish = {
    enable = true;
    package = pkgs.fish;
    interactiveShellInit = ''
    fastfetch
    set fish_greeting ""
    set -gx TERM xterm-256color 
    set EDITOR nvim
     '';
    shellAbbrs = {
      nt = "nmtui";
      bt = "bluetui";
      b = "bat -l conf -p";
      nv = "nvim";
      cfg = "sudo nvim /etc/nixos/nixos/configuration.nix";
      hcfg = "sudo nvim /etc/nixos/home-manager/";
      rebuild = "sudo nixos-rebuild switch";
      ff = "fastfetch";
    };
    shellAliases = {
      ls = "eza --icons always";
      faker = "~/.venv/bin/faker";
    };
    functions = {
      mkcd = "mkdir -p $argv && cd $argv";
      icat = "kitten icat $argv";
    };
      plugins = [
    {
      name = "z";
      src = pkgs.fishPlugins.z.src;
    }
    {
      name = "fzf-fish";
      src = pkgs.fishPlugins.fzf-fish.src;
    }
    {
      name = "tide";
      src = pkgs.fishPlugins.tide.src;
    }
  ];
  };
}
