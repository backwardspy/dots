{
  lib,
  pkgs,
  ...
}: let
  version = "0.3.6";

  src = pkgs.fetchFromGitHub {
    owner = "sachaos";
    repo = "viddy";
    rev = "v${version}";
    sha256 = "sha256-AcRfKu6P7b/HsuC6DTezbYLI9rQZwjklH/bs7mKITUk=";
  };

  package = pkgs.buildGoModule {
    pname = "viddy";
    inherit version src;
    vendorSha256 = "sha256-QxYM4N3E/BqmeNaofLR1crwFLVaF3IigDXKlKA2Bkuw=";
    meta = with lib; {
      description = "A modern watch command. Time machine and pager etc.";
      homepage = "https://github.com/sachaos/viddy";
      license = licenses.mit;
    };
  };
in {
  home.packages = [
    package
  ];
}
