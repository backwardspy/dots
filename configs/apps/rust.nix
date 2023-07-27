{pkgs, ...}: {
  home.packages = [
    pkgs.cargo
    pkgs.cargo-nextest
    pkgs.clippy
    pkgs.gcc
    pkgs.rustfmt
    pkgs.sccache
  ];
  home.sessionVariables = {
    RUSTC_WRAPPER = "sccache";
  };
  home.sessionPath = [
    "$HOME/.cargo/bin"
  ];
}
