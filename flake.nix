{
  description = "home-manager flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-index-database = {
      url = "github:Mic92/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    is-lightmode = {
      url = "path:./scripts/is-lightmode";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    nixpkgs,
    home-manager,
    nix-index-database,
    ...
  } @ inputs: let
    machine = import ./machine.nix;
    overlays = final: prev: {
      is-lightmode = inputs.is-lightmode.packages.${machine.system}.default;
    };
    pkgs = import nixpkgs {
      system = machine.system;
      overlays = [overlays];
    };
  in {
    homeConfigurations.${machine.username} = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      modules = [
        ./home.nix
        nix-index-database.hmModules.nix-index
      ];
      extraSpecialArgs = rec {
        username = machine.username;
        email = machine.email;
        homeDirectory = "${
          if pkgs.stdenv.isDarwin
          then "/Users"
          else "/home"
        }/${username}";
        flakePath = "${homeDirectory}/.config/home-manager/";
        configs = machine.configs;
      };
    };
  };
}
