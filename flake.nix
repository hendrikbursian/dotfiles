{
  description = "Home Manager configuration";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-unstable";
    };
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};

      username = "hendrik";
      homeDirectory = "/home/${username}/";
    in
    {
      devShells.${system}.default = pkgs.mkShell {
        NIX_CONFIG = "extra-experimental-features = nix-command flakes";

        packages = [
          pkgs.home-manager
          pkgs.git
        ];
      };

      homeConfigurations."hendrik" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        modules = [
          ./home.nix
        ];

        extraSpecialArgs = {
          homeDirectory = homeDirectory;
          username = username;
          dotfilesPath = "${homeDirectory}/.dotfiles/";
        };
      };

      programs.zsh.enable = true;
      environment.shells = with pkgs; [ zsh ];
      users.defaultUserShell = pkgs.zsh;
    };
}
