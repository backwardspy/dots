if set -q WAYLAND_DISPLAY
    set -gx QT_QPA_PLATFORM WAYLAND
    set -gx QT_WAYLAND_DISABLE_WINDOWDECORATION 1
    set -gx _JAVA_AWT_WM_NONREPARENTING 1
end


fish_add_path ~/.local/bin
fish_add_path ~/.cargo/bin
fish_add_path ~/.gchup/bin
fish_add_path ~/.cabal/bin
fish_add_path ~/.spicetify

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
