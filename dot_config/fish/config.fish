if status --is-login
    # this cannot be set universally when fish isn't the login shell. it is
    # shadowed by the global SHELL variable which is inherited from the real
    # login shell's environment.
    set --export SHELL fish

    if type -q brew
        # let brew set up its own environment
        brew shellenv | source
    end

    fish_add_path ~/.local/bin
    fish_add_path ~/.local/go/bin
    fish_add_path ~/.cargo/bin
    fish_add_path ~/.spicetify

    if type -q brew
        fish_add_path $HOMEBREW_PREFIX/opt/llvm/bin
        fish_add_path $HOMEBREW_PREFIX/opt/python@3.11/libexec/bin
        fish_add_path $HOMEBREW_PREFIX/opt/openssl@3/bin
        fish_add_path $HOMEBREW_PREFIX/sbin
    end
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

if test "$TERM" = "xterm-kitty"
    # ssh over kitty is a bit broken if we don't copy its terminfo over. this
    # abbr is added globally rather than universally so it doesn't persist.
    abbr -g ssh kitty +kitten ssh
end

if type -q starship
  starship init fish | source
end
