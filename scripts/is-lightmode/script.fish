#!/usr/bin/env fish
#
# checks if light mode is enabled
#
# sets $status zero if in light mode
# sets $status nonzero if in dark mode
#
# currently supports macOS and windows (via WSL)
#
# appearance_* functions return 0 if light mode is enabled

function appearance_darwin
    defaults read -g AppleInterfaceStyle 2>/dev/null
end

function appearance_wsl
    reg.exe query HKCU\\Software\\Microsoft\\Windows\\CurrentVersion\\Themes\\Personalize /v AppsUseLightTheme | grep -q 1
end

if test (uname) = Darwin
    appearance_darwin
else if string match -q "*-WSL2" (uname -r)
    appearance_wsl
end
