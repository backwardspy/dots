{
  pkgs,
  lib,
  ...
}: {
  programs.fish = {
    enable = true;
    functions =
      {
        fish_greeting = "";
        lsd = "lsd --color-theme first";
      }
      // (let
        functions = [
          {
            "light" = "yes | fish_config theme save 'Catppuccin Latte'";
            "dark" = "yes | fish_config theme save 'Catppuccin Mocha'";
          }
          {
            "light" = "set -gx LS_COLORS (vivid generate catppuccin-latte)";
            "dark" = "set -gx LS_COLORS (vivid generate catppuccin-mocha)";
          }
        ];
      in {
        autotheme_light = lib.concatStrings (map (f: "${f.light}\n") functions);
        autotheme_dark = lib.concatStrings (map (f: "${f.dark}\n") functions);

        autotheme = ''
          if is-lightmode
            autotheme_light
          else
            autotheme_dark
          end
        '';
      });
    shellAbbrs = {
      ga = "git add";
      gb = "git branch";
      gc = "git commit";
      gcm = "git checkout main";
      gco = "git checkout";
      gd = "git diff";
      gl = "git pull";
      gp = "git push";
      gr = "git rebase";
      gra = "git rebase --abort";
      grc = "git rebase --continue";
      gs = "git switch";
      gst = "git status";

      dcdu = "docker-compose down && docker-compose up -d";

      kctx = "kubectx";
      ke = "kubectl exec -it";
      kgd = "kubectl get deployments";
      kgp = "kubectl get pods";
      kl = "kubectl logs -f";
      kns = "kubens";

      pa = "poetry add";
      pad = "poetry add --group dev";
      pi = "poetry install";
      pr = "poetry run";
      psh = "poetry shell";
    };
    interactiveShellInit = ''
      # set vi bindings
      fish_vi_key_bindings

      # set vi cursor
      # wezterm isn't supported out of the box, but we can safely force-enable it.
      set fish_vi_force_cursor 1
      fish_vi_cursor

      # cursor modes
      set fish_cursor_default block
      set fish_cursor_insert line
      set fish_cursor_replace_one underscore
      set fish_cursor_visual block

      # yum
      autotheme
    '';
    plugins = [
      {
        "name" = "nix-env";
        src = pkgs.fetchFromGitHub {
          owner = "lilyball";
          repo = "nix-env.fish";
          rev = "7b65bd228429e852c8fdfa07601159130a818cfa";
          sha256 = "sha256-RG/0rfhgq6aEKNZ0XwIqOaZ6K5S4+/Y5EEMnIdtfPhk=";
        };
      }
    ];
  };

  xdg.configFile."fish/themes/Catppuccin Mocha.theme".text = builtins.readFile (pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/catppuccin/fish/main/themes/Catppuccin%20Mocha.theme";
    sha256 = "sha256-MlI9Bg4z6uGWnuKQcZoSxPEsat9vfi5O1NkeYFaEb2I=";
  });

  xdg.configFile."fish/themes/Catppuccin Latte.theme".text = builtins.readFile (pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/catppuccin/fish/main/themes/Catppuccin%20Latte.theme";
    sha256 = "sha256-SL19zcXf+Df1BeH+nfI63t3qpDmRISHGRtaEP36mojE=";
  });

  home.packages = [
    pkgs.vivid
  ];
}
