{
  lib,
  pkgs,
  ...
}: let
  version = "0.4.0";

  src = builtins.fetchGit {
    url = "https://git.mills.io/prologic/zs.git";
    name = "zs-${version}";
    ref = "refs/tags/${version}";
  };

  package = pkgs.buildGoModule {
    pname = "zs";
    inherit version src;
    vendorSha256 = "sha256-y2DK6jg3Wpq8ah2CFhxeHBlj9OdCnlUUL2IjDqmIQKM=";
    meta = with lib; {
      description = "⚡️ an extremely minimal static site generator written in Go.";
      homepage = "https://zs.mills.io/";
      license = licenses.mit;
    };
  };
in {
  home.packages = [
    package
  ];
}
