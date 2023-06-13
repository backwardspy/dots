{
  description = "A fish script to check if the system is in light mode";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };
  outputs = {
    self,
    nixpkgs,
    ...
  }: let
    systems = ["x86_64-linux" "aarch64-darwin"];
    forAllSystems = f: nixpkgs.lib.genAttrs systems (system: f system);
    nixpkgsFor = forAllSystems (system: import nixpkgs {inherit system;});
  in {
    packages = forAllSystems (system: let
      pkgs = nixpkgsFor.${system};
    in {
      default = derivation {
        system = system;
        builder = "${pkgs.bash}/bin/bash";
        args = [./builder.bash];
        name = "is-lightmode";
        source = ./script.fish;
        coreutils = pkgs.coreutils;
      };
    });
  };
}
