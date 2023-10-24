fish_add_path -g /opt/homebrew/bin
fish_add_path -g /opt/homebrew/opt/python@3.11/libexec/bin
fish_add_path -g ~/.local/bin

if string match -qr 'Darwin|Linux' (uname)
    ### recommendations from xdg-ninja
    set -gx XDG_CACHE_HOME $HOME/.cache
    set -gx XDG_CONFIG_HOME $HOME/.config
    set -gx XDG_DATA_HOME $HOME/.local/share
    set -gx XDG_STATE_HOME $HOME/.local/state
    set -gx XDG_RUNTIME_DIR $HOME/.run

    set -gx AZURE_CONFIG_DIR $XDG_DATA_HOME/azure

    set -gx CARGO_HOME $XDG_DATA_HOME/cargo

    set -gx DOCKER_CONFIG $XDG_CONFIG_HOME/docker

    set -gx GEM_HOME $XDG_DATA_HOME/gem
    set -gx GEM_SPEC_CACHE $XDG_CACHE_HOME/gem

    set -gx GOPATH $XDG_DATA_HOME/go

    set -gx LESSHISTFILE $XDG_STATE_HOME/less/history

    set -gx MYPY_CACHE_DIR $XDG_CACHE_HOME/mypy

    set -gx PSQL_HISTORY $XDG_DATA_HOME/psql_history

    set -gx TERMINFO $XDG_DATA_HOME/terminfo
    set -gx TERMINFO_DIRS $XDG_DATA_HOME/terminfo:/usr/share/terminfo

    set -gx NPM_CONFIG_USERCONFIG $XDG_CONFIG_HOME/npm/npmrc

    set -gx RUSTUP_HOME $XDG_DATA_HOME/rustup
    ###
end

set -gx EDITOR nvim
set -gx MANPAGER 'nvim +Man!'
set -gx TERM wezterm

fish_add_path -g $CARGO_HOME/bin
fish_add_path -g $GOPATH/bin

if type -q vivid
    set -gx LS_COLORS (vivid generate catppuccin-mocha)
end

if type -q eza
    function eza --wraps eza
        command eza --icons --git --group-directories-first --hyperlink $argv
    end
    abbr ls eza
    abbr la eza -a
    abbr ll eza -l
    abbr lla eza -la
    abbr lt eza -T
end

abbr ga git add
abbr gb git branch
abbr gc git commit
abbr gcm git checkout main
abbr gco git checkout
abbr gd git diff
abbr gdt git difftool
abbr gl git pull
abbr gp git push
abbr gr git rebase
abbr gra git rebase --abort
abbr grc git rebase --continue
abbr gs git switch
abbr gst git status

abbr kctx kubectx
abbr ke kubectl exec -it
abbr kgd kubectl get deployments
abbr kgp kubectl get pods
abbr kl kubectl logs -f
abbr kns kubens

abbr pa poetry add
abbr pad poetry add --group dev
abbr pi poetry install
abbr pr poetry run
abbr psh poetry shell

abbr vi nvim
abbr vim nvim
abbr neogit nvim +Neogit

abbr dc docker-compose
abbr dcb docker-compose build
abbr dcd docker-compose down
abbr dcu docker-compose up -d
abbr dcdu 'docker-compose down && docker-compose build && docker-compose up -d'

abbr vn python -m venv .venv
abbr va . .venv/bin/activate.fish
abbr vd deactivate

if type -q zoxide
    zoxide init fish | source
end

if type -q direnv
    direnv hook fish | source
end

if type -q starship
    function starship_transient_prompt_func
        starship module character
    end
    starship init fish | source
    enable_transience
end
