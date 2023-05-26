{
  lib,
  pkgs,
  ...
}: let
  isMacos = (builtins.match ".*darwin" builtins.currentSystem) != null;
  isLinux = (builtins.match ".*linux" builtins.currentSystem) != null;
  imports =
    [
      ./machine.nix
      configs/bat.nix
      configs/direnv.nix
      configs/fish.nix
      configs/fzf.nix
      configs/git.nix
      configs/go.nix
      configs/lsd.nix
      configs/neovim.nix
      configs/nix-index.nix
      configs/node.nix
      configs/python.nix
      configs/rust.nix
      configs/starship.nix
      configs/viddy.nix
      configs/wezterm.nix
      configs/zs.nix
    ]
    ++ lib.optionals isMacos [
      configs/brew.nix
    ]
    ++ lib.optionals isLinux [
      configs/gdb.nix
    ];
in {
  home.stateVersion = "22.11";

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
    pkgs.jq
    pkgs.just
    pkgs.kubectx
    pkgs.kubelogin
    pkgs.mdcat
    pkgs.nil
    pkgs.postgresql
    pkgs.ripgrep
    pkgs.scc
    pkgs.unzip
    pkgs.wget

    (import ./scripts/is-lightmode)
  ];

  programs.home-manager.enable = true;
  targets.genericLinux.enable = isLinux;

  xdg.configFile."nix/nix.conf".text = "experimental-features = nix-command flakes";

  inherit imports;
}
