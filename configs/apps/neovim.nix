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
      rust-tools-nvim
      telescope-fzf-native-nvim
      telescope-nvim
      telescope-ui-select-nvim
      telescope-undo-nvim
      vim-fugitive
      which-key-nvim
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
        sha256 = "sha256-kDxU5G6Z9JBZjn3CaYQ8tZ9UTgfQVP5veDFOTr3O1es=";
      })
    ];
  };

  xdg.configFile."nvim" = {
    source = config.lib.file.mkOutOfStoreSymlink "${flakePath}/ext/neovim";
    recursive = true;
  };

  xdg.dataFile."nvim/codelldb".source = "${pkgs.vscode-extensions.vadimcn.vscode-lldb}/share/vscode/extensions/vadimcn.vscode-lldb";
}
