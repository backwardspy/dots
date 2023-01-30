set -gx EDITOR nvim
set -gx npm_config_prefix ~/.local

# paths are only added if they exist
fish_add_path -g /usr/local/sbin
fish_add_path -g ~/.local/bin
fish_add_path -g ~/.cargo/bin
fish_add_path -g ~/.spicetify
fish_add_path -g ~/go/bin
fish_add_path -g /opt/homebrew/bin
fish_add_path -g /opt/homebrew/opt/python@3.11/libexec/bin

if type -q vivid
    set -gx LS_COLORS (vivid generate catppuccin-mocha)
end

# source machine-specific config if it's present
set machineconf "$HOME/.config/fish/.profile."(uname -s)
if test -f $machineconf
    source $machineconf
end

if type -q direnv
    # use direnv to autoload project .env files
    direnv hook fish | source
end

# automatically ls on cd
if ! type -q _standard_cd
    functions --copy cd _standard_cd
    function cd
        _standard_cd $argv && lsd
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
    echo "✨ vscode shell integration enabled ✨"
end
