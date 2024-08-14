{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfreePredicate = pkg: builtins.elem (nixpkgs.lib.getName pkg) [
          "nvidia-x11"
          "nvidia-settings"
          "nvidia-persistenced"

          "intelephense"
        ];

        # make unstable packages accessable via pkgs.unstable
        overlays = [
          (final: prev: {
            unstable = import nixpkgs-unstable {
              system = final.system;
              config.allowUnfreePredicate = final.config.allowUnfreePredicate;
            };
          })
        ];
      };
    in
    {
      nixosConfigurations.tuxedo = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./hosts/tuxedo/configuration.nix
        ];
        specialArgs = { inherit pkgs; };
      };


      homeConfigurations."hendrik" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        # Specify your home configuration modules here, for example,
        # the path to your home.nix.
        modules = [ ./home/hendrik ];

        # Optionally use extraSpecialArgs
        # to pass through arguments to home.nix
      };
    };
}
