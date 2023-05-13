{pkgs, ...}: {
  home.packages = [pkgs.rustup pkgs.sccache];
  home.file.".cargo/config".text = ''
    [build]
    rustc-wrapper = "sccache"
  '';
  home.sessionPath = [
    "$HOME/.cargo/bin"
  ];
}
