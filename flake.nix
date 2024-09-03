{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Add base16.nix, base16 schemes and
    # zathura and vim templates to the flake inputs.
    base16.url = "github:SenchoPens/base16.nix";
    tt-schemes = {
      url = "github:tinted-theming/schemes";
      flake = false;
    };
    base16-zathura = {
      url = "github:haozeke/base16-zathura";
      flake = false;
    };
    base16-mako = {
      url = "github:stacyharper/base16-mako";
      flake = false;
    };
    base16-foot = {
      url = "github:tinted-theming/base16-foot";
      flake = false;
    };
    base16-fzf = {
      url = "github:tinted-theming/tinted-fzf";
      flake = false;
    };
    base16-tmux = {
      url = "github:tinted-theming/tinted-tmux";
      flake = false;
    };
    base16-shell = {
      url = "github:tinted-theming/tinted-shell";
      flake = false;
    };
    base16-vim = {
      url = "github:tinted-theming/base16-vim";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, ... } @inputs:
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
        modules = [
          ./home/hendrik
        ];

        # Optionally use extraSpecialArgs
        # to pass through arguments to home.nix
        extraSpecialArgs = { inherit inputs; };
      };
    };
}
