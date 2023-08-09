{pkgs, ...}: let
  python-packages = ps:
    with ps; [
      catppuccin
      # debugpy
      ipython
      requests
      rich
      ruff-lsp
    ];
in {
  home.packages = [
    (pkgs.python311.withPackages python-packages)
    pkgs.poetry
    pkgs.pipenv
  ];

  home.file.".ipython/profile_default/ipython_config.py".text = ''
    from pygments.styles import get_style_by_name
    c = get_config()
    c.TerminalInteractiveShell.highlighting_style = get_style_by_name("catppuccin-mocha")
  '';

  home.sessionVariables = {
    PYTHONUSERBASE = "$HOME/.local";
  };
}
