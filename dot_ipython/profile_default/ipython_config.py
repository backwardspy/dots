from pygments.styles import get_style_by_name
c = get_config()
c.TerminalInteractiveShell.highlighting_style = get_style_by_name("catppuccin-mocha")
