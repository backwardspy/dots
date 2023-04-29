set -gx EDITOR nvim
set -gx TERM wezterm
set -gx npm_config_prefix ~/.local

# paths are only added if they exist
fish_add_path -g /usr/local/sbin
fish_add_path -g ~/.local/bin
fish_add_path -g ~/.cargo/bin
fish_add_path -g ~/.spicetify
fish_add_path -g ~/go/bin
fish_add_path -g /opt/homebrew/bin
fish_add_path -g /opt/homebrew/opt/python@3.11/libexec/bin

# source machine-specific config if it's present
set machineconf "$HOME/.config/fish/.profile."(uname -s)
if test -f $machineconf
    source $machineconf
end

set -q APPEARANCE; or set -gx APPEARANCE dark

if test "$APPEARANCE" = light
    yes | fish_config theme save 'Catppuccin Latte'
else
    yes | fish_config theme save 'Catppuccin Mocha'
end

if type -q vivid
    if test "$APPEARANCE" = light
        set -gx LS_COLORS (vivid generate catppuccin-latte)
    else
        set -gx LS_COLORS (vivid generate catppuccin-mocha)
    end
end

if type -q direnv
    # use direnv to autoload project .env files
    direnv hook fish | source
end

# use lsd for ls
function ls
    lsd --config-file="$HOME/.config/lsd/$APPEARANCE.yaml" $argv
end

# automatically ls on cd
if ! type -q _standard_cd
    functions --copy cd _standard_cd
    function cd
        _standard_cd $argv && ls
    end
end

# setup kubernetes-tools completions
if ! type -q _maybe_source
    function _maybe_source -a file
        if test -e $file
            source $file
        end
    end
    _maybe_source $HOME/.config/fish/completions/kubernetes-tools.fish
end

if type -q starship
    starship init fish | source
end

if string match -q "$TERM_PROGRAM" vscode
    source (code --locate-shell-integration-path fish)
end
