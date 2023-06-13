{lib, ...}:
with import ../../lib/numbers.nix {inherit lib;}; let
  catppuccin = import ../../lib/catppuccin.nix;
in {
  programs.starship = {
    enable = true;
    settings = let
      lang-segment = {
        symbol = " ";
        style = "base bg:#A4B8F5";
        format = "[ $symbol($version) ]($style)";
      };
    in {
      add_newline = true;
      format = lib.concatStrings [
        "[](base bg:pink)"
        "$directory"
        "[](pink bg:#DABFEC)"
        "$git_branch"
        "[](#DABFEC bg:#BFBBF1)"
        "$git_status"
        "[](#BFBBF1 bg:#A4B8F5)"
        "$golang"
        "$nodejs"
        "$nim"
        "$rust"
        "$python"
        "$lua"
        "[](#A4B8F5 bg:blue)"
        "$time"
        "[](blue bg:none)"
        "$line_break"
        "$character"
      ];
      character = {
        format = "$symbol ";
        success_symbol = "[\\$](bold green)";
        error_symbol = "[\\$](bold red)";
        vimcmd_symbol = "[\\$](bold blue)";
        vimcmd_replace_one_symbol = "[\\$](bold maroon)";
        vimcmd_replace_symbol = "[\\$](bold maroon)";
        vimcmd_visual_symbol = "[\\$](bold flamingo)";
      };
      directory = {
        style = "base bg:pink";
        format = "[ $path ]($style)";
        truncation_length = 0;
      };
      git_branch = {
        symbol = " ";
        style = "base bg:#DABFEC";
        format = "[ $symbol$branch ]($style)";
      };
      git_status = {
        style = "base bg:#BFBBF1";
        format = "[ $all_status$ahead_behind ]($style)";
      };
      time = {
        disabled = false;
        style = "base bg:blue";
        time_format = "%H:%M";
        format = "[ $time ♥ ]($style)";
      };
      golang = lang-segment;
      nodejs = lang-segment;
      nim = lang-segment;
      rust = lang-segment;
      python = lang-segment;
      lua = lang-segment;

      palettes = {
        catppuccin-mocha =
          builtins.mapAttrs
          (name: c: colorToHex c)
          catppuccin.mocha;
        catppuccin-latte =
          builtins.mapAttrs
          (name: c: colorToHex c)
          catppuccin.latte;
      };
      palette = "catppuccin-mocha";
    };
  };
}
