{
  description = "Home Manager configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
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
        };
      };

      programs.zsh.enable = true;
      environment.shells = with pkgs; [ zsh ];
      users.defaultUserShell = pkgs.zsh;
    };
}
