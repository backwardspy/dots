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
      configs/python.nix
      configs/rust.nix
      configs/starship.nix
      configs/wezterm.nix
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
    pkgs.docker-client
    pkgs.entr
    pkgs.gh
    pkgs.just
    pkgs.mdcat
    pkgs.nil
    pkgs.postgresql
    pkgs.ripgrep
    pkgs.scc

    (import ./scripts/is-lightmode)
  ];

  programs.home-manager.enable = true;
  targets.genericLinux.enable = isLinux;

  inherit imports;
}
