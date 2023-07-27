{
  pkgs,
  username,
  homeDirectory,
  configs,
  ...
}: {
  home.username = username;
  home.homeDirectory = homeDirectory;

  home.stateVersion = "23.11";

  home.sessionPath = [
    "$HOME/.local/bin"
  ];

  home.sessionVariables = {
    BROWSER = "$BROWSER:wsl-open";
  };

  home.packages = [
    pkgs.alejandra
    pkgs.azure-cli
    pkgs.docker-client
    pkgs.entr
    pkgs.fd
    pkgs.file
    pkgs.gh
    pkgs.hyperfine
    pkgs.is-lightmode
    pkgs.jq
    pkgs.just
    pkgs.kubectx
    pkgs.kubelogin
    pkgs.mdcat
    pkgs.mosh
    pkgs.nil
    pkgs.openssh
    pkgs.postgresql
    pkgs.ripgrep
    pkgs.scc
    pkgs.terraform
    pkgs.unzip
    pkgs.wget
    pkgs.wsl-open
    pkgs.xdg-utils
  ];

  programs.home-manager.enable = true;
  targets.genericLinux.enable = pkgs.stdenv.isLinux;

  nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  imports = import configs;
}
