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
      lldb
      rustc

      # formatters
      alejandra

      # language servers
      lua-language-server
      nil
      nodePackages.eslint
      nodePackages.pyright
      nodePackages.typescript-language-server
      rust-analyzer
    ];

    plugins = with pkgs.vimPlugins; [
      catppuccin-nvim
      copilot-lua
      gitsigns-nvim
      lsp_lines-nvim
      lspkind-nvim
      lualine-nvim
      lush-nvim
      mini-nvim
      nvim-dap
      nvim-dap-python
      nvim-dap-ui
      nvim-dap-virtual-text
      nvim-lspconfig
      nvim-treesitter-context
      nvim-treesitter-endwise
      nvim-treesitter-textobjects
      nvim-treesitter.withAllGrammars
      nvim-web-devicons
      octo-nvim
      oil-nvim
      rust-tools-nvim
      telescope-fzf-native-nvim
      telescope-nvim
      telescope-ui-select-nvim
      telescope-undo-nvim
      vim-fugitive
      vim-rhubarb
      which-key-nvim
      zenbones-nvim
      (buildVimPluginFromGithub {
        owner = "linrongbin16";
        repo = "lsp-progress.nvim";
        rev = "HEAD";
        sha256 = "sha256-o51SgcX/VsZy6IN7hVoSWAlJO41/sZksx2C4FvPYhR0=";
      })
      (buildVimPluginFromGithub {
        owner = "HallerPatrick";
        repo = "py_lsp.nvim";
        rev = "HEAD";
        sha256 = "sha256-YOYrumIYlWcZBL1LSeBWseb/0G4n8obcll6wPwaXqpM=";
      })
      (buildVimPluginFromGithub {
        owner = "folke";
        repo = "flash.nvim";
        rev = "HEAD";
        sha256 = "sha256-kUvuys85luCkRAmkgmJicAHEWq6S53pUgGHoB1nX05A=";
      })
    ];
  };

  xdg.configFile."nvim" = {
    source = config.lib.file.mkOutOfStoreSymlink "${flakePath}/ext/neovim";
    recursive = true;
  };
}
