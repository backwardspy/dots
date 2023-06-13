{
  pkgs,
  machine,
  ...
}: let
  homeRoot =
    if pkgs.stdenv.isDarwin
    then "/Users"
    else "/home";
in {
  home.username = machine.username;
  home.homeDirectory = "${homeRoot}/${machine.username}";

  home.stateVersion = "23.11";

  home.sessionPath = [
    "$HOME/.local/bin"
  ];

  home.packages = [
    pkgs.alejandra
    pkgs.azure-cli
    pkgs.docker-client
    pkgs.entr
    pkgs.fd
    pkgs.gh
    pkgs.is-lightmode
    pkgs.jq
    pkgs.just
    pkgs.kubectx
    pkgs.kubelogin
    pkgs.mdcat
    pkgs.nil
    pkgs.openssh
    pkgs.postgresql
    pkgs.ripgrep
    pkgs.scc
    pkgs.unzip
    pkgs.wget
  ];

  programs.home-manager.enable = true;
  targets.genericLinux.enable = pkgs.stdenv.isLinux;

  xdg.configFile."nix/nix.conf".text = "experimental-features = nix-command flakes";

  imports = import machine.configs;
}
