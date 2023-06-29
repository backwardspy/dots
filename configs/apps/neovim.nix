{
  pkgs,
  lib,
  config,
  flakePath,
  ...
}: let
  buildVimPluginFromGithub = {
    owner,
    repo,
    rev,
    sha256,
  }: (pkgs.vimUtils.buildVimPluginFrom2Nix {
    pname = lib.strings.sanitizeDerivationName "${owner}-${repo}";
    version = rev;
    src = pkgs.fetchFromGitHub {inherit owner repo rev sha256;};
  });
in {
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    extraPackages = with pkgs; [
      # generic
      gcc
      git
      rustc

      # formatters
      alejandra

      # language servers
      lua-language-server
      nodePackages.pyright
      python3Packages.ruff-lsp
      rust-analyzer
      nil
    ];

    plugins = with pkgs.vimPlugins; [
      copilot-lua
      lsp_lines-nvim
      lspkind-nvim
      lualine-nvim
      mini-nvim
      nvim-lspconfig
      nvim-treesitter-context
      nvim-treesitter-endwise
      nvim-treesitter-textobjects
      nvim-treesitter.withAllGrammars
      nvim-web-devicons
      rust-tools-nvim
      telescope-fzf-native-nvim
      telescope-nvim
      telescope-ui-select-nvim
      telescope-undo-nvim
      vim-fugitive
      which-key-nvim
      (buildVimPluginFromGithub {
        owner = "m4xshen";
        repo = "hardtime.nvim";
        rev = "HEAD";
        sha256 = "sha256-AVHXVXUGTpxieqeURnTv8mN+SQAhjyro9WwwnhF5dI4=";
      })
      (buildVimPluginFromGithub {
        owner = "linrongbin16";
        repo = "lsp-progress.nvim";
        rev = "HEAD";
        sha256 = "sha256-eEcEm9vd0o1cCBKlBENP3noQbzyBVzxDZlWfAMKbV1g=";
      })
    ];
  };

  xdg.configFile."nvim" = {
    source = config.lib.file.mkOutOfStoreSymlink "${flakePath}/ext/neovim";
    recursive = true;
  };
}
