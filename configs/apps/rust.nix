{pkgs, ...}: {
  home.packages = [
    pkgs.cargo
    pkgs.cargo-nextest
    pkgs.gcc
    # pkgs.rustc
    pkgs.sccache
  ];
  home.sessionVariables = {
    RUSTC_WRAPPER = "sccache";
  };
  home.sessionPath = [
    "$HOME/.cargo/bin"
  ];
}
