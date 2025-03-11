set -gx XDG_CACHE_HOME $HOME/.cache
set -gx XDG_CONFIG_HOME $HOME/.config
set -gx XDG_DATA_HOME $HOME/.local/share
set -gx XDG_STATE_HOME $HOME/.local/state
set -gx XDG_RUNTIME_DIR $HOME/.run

set -gx CARGO_HOME $XDG_DATA_HOME/cargo
set -gx DOCKER_CONFIG $XDG_CONFIG_HOME/docker
set -gx GOPATH $XDG_DATA_HOME/go
set -gx LESSHISTFILE $XDG_STATE_HOME/less/history
set -gx MYPY_CACHE_DIR $XDG_CACHE_HOME/mypy
set -gx PSQL_HISTORY $XDG_DATA_HOME/psql_history
set -gx NPM_CONFIG_USERCONFIG $XDG_CONFIG_HOME/npm/npmrc
set -gx RUSTUP_HOME $XDG_DATA_HOME/rustup

set -gx EDITOR nvim
set -gx VISUAL "code --wait"

fish_add_path -g ~/.local/bin
fish_add_path -g /opt/neovim/bin
fish_add_path -g $CARGO_HOME/bin
fish_add_path -g $GOPATH/bin
fish_add_path -g $XDG_DATA_HOME/npm/bin

if type -q vivid
    set -gx LS_COLORS (vivid generate catppuccin-latte)
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

    if string match -q "$TERM_PROGRAM" "vscode"
        set -e VSCODE_SHELL_INTEGRATION
        . (code --locate-shell-integration-path fish)
    end
end
