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

      # formatters
      alejandra
      stylua

      # language servers
      lua-language-server
      nodePackages.pyright
      python3Packages.ruff-lsp
      rust-analyzer
      nil
    ];

    plugins = with pkgs.vimPlugins; [
      copilot-lua
      legendary-nvim
      lsp_lines-nvim
      lspkind-nvim
      lualine-nvim
      mini-nvim
      nvim-lspconfig
      nvim-treesitter-textobjects
      nvim-treesitter.withAllGrammars
      nvim-web-devicons
      telescope-fzf-native-nvim
      telescope-nvim
      telescope-ui-select-nvim
      vim-fugitive
      (buildVimPluginFromGithub {
        owner = "m4xshen";
        repo = "hardtime.nvim";
        rev = "HEAD";
        sha256 = "sha256-8jvHNltq2WS9o0/N3+kyxUAENkj1LT506i3fNLKODAk=";
      })
    ];
  };

  xdg.configFile."nvim" = {
    source = config.lib.file.mkOutOfStoreSymlink "${flakePath}/ext/neovim";
    recursive = true;
  };
}
