from pygments.styles import get_style_by_name
from pygments.util import ClassNotFound

c = get_config()
c.InteractiveShell.confirm_exit = False
c.InteractiveShell.separate_in = ''
c.TerminalIPythonApp.display_banner = False
try:
    c.TerminalInteractiveShell.highlighting_style = get_style_by_name("catppuccin-mocha")
except ClassNotFound as ex:
    print(f"Failed to set theme: {ex}")
