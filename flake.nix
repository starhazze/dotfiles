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

    # --- flake-parts for otter --- 
    systems.url = "github:nix-systems/default-linux";
    flake-parts.url = "github:hercules-ci/flake-parts";

    # --- otter-launcher --- 
    otter-launcher = {
      url = "github:kuokuo123/otter-launcher";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
      inputs.systems.follows = "systems";
      inputs.flake-parts.follows = "flake-parts";
    };

    # --- caelestia shell/cli ---
    caelestia-shell = {
      url = "github:caelestia-dots/shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    caelestia-cli = {
      url = "github:caelestia-dots/cli";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # --- matugen ---
    matugen = {
      url = "github:/InioX/Matugen";
    };
  };

  outputs = inputs@{ self, nixpkgs, home-manager, nixvim, otter-launcher, ... }: {

    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };
      modules = [
        { nixpkgs.hostPlatform = "x86_64-linux"; }
        ./nixos/configuration.nix
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs    = true;
          home-manager.useUserPackages  = true;
          home-manager.sharedModules    = [
            nixvim.homeModules.nixvim
            otter-launcher.homeModules.default
          ];
          home-manager.users.forkd = import ./home-manager;
	  home-manager.extraSpecialArgs = { inherit inputs; };
        }
      ];
    };

  };
}
