{pkgs, ...}: {
  home.packages = [pkgs.rustup pkgs.sccache];
  home.sessionVariables = {
    RUSTC_WRAPPER = "sccache";
  };
  home.sessionPath = [
    "$HOME/.cargo/bin"
  ];
}
