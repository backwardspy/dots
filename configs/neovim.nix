{pkgs, ...}: {
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    extraPackages = with pkgs; [
      tree-sitter
      nodejs
      git
      gcc
    ];

    plugins = with pkgs.vimPlugins; [
      nvim-treesitter.withAllGrammars
      catppuccin-nvim
    ];

    extraLuaConfig = ''
      vim.opt.number = true
      vim.opt.relativenumber = true

      if vim.fn.has("wsl") ~= 0 then
        vim.g.clipboard = {
          name = "WslClipboard",
          copy = {
            ["+"] = "clip.exe",
            ["*"] = "clip.exe",
          },
          paste = {
            ["+"] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
            ["*"] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
          },
          cache_enabled = 0,
        }
      end

      require("catppuccin").setup({
        color_overrides = {
          mocha = {
            base = "#1D0D2D",
            mantle = "#210F32",
            crust = "#241138",
          }
        }
      })
      vim.cmd.colorscheme("catppuccin")
    '';
  };
}
