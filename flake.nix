{
  description = "stuff";

  inputs = {
    # --- nixpkgs ---
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "nixpkgs/nixos-25.11";

    # --- HM --- 
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # --- nixvim ---
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # --- firefox nightly --- 
    firefox.url = "github:nix-community/flake-firefox-nightly";
    firefox.inputs.nixpkgs.follows = "nixpkgs";

    # --- caelestia shell/cli ---
    caelestia-shell = {
      url = "github:caelestia-dots/shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    caelestia-cli = {
      url = "github:caelestia-dots/cli";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # --- singularity (shell) ---
    singularity-desktop.url = "github:mateoalfaro/singularity-flake";

    # --- matugen ---
    matugen.url = "github:/InioX/Matugen";

    # --- commet-chat the matrix client ---
    ckgpkgs.url = "git+https://codeberg.org/ckgxrg/ckgpkgs";
  };

  outputs = inputs@{ self, nixpkgs, home-manager, nixvim, singularity-desktop, ... }: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };
      modules = [
        { nixpkgs.hostPlatform = "x86_64-linux"; }
        ./nixos/configuration.nix
        home-manager.nixosModules.home-manager
        singularity-desktop.nixosModules.default
        {
          home-manager.useGlobalPkgs    = true;
          home-manager.useUserPackages  = true;
          home-manager.sharedModules    = [
            nixvim.homeModules.nixvim
          ];
          home-manager.users.starhaze   = import ./home-manager;
	        home-manager.extraSpecialArgs = { inherit inputs; };
        }
      ];
    };

  };
}
