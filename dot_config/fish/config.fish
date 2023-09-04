fish_add_path -g /opt/homebrew/bin
fish_add_path -g /opt/homebrew/opt/python@3.11/libexec/bin
fish_add_path -g ~/.local/go/bin
fish_add_path -g ~/.local/bin

### recommendations from xdg-ninja
set -gx XDG_CACHE_HOME $HOME/.cache
set -gx XDG_CONFIG_HOME $HOME/.config
set -gx XDG_DATA_HOME $HOME/.local/share
set -gx XDG_STATE_HOME $HOME/.local/state

set -gx AZURE_CONFIG_DIR $XDG_DATA_HOME/azure

set -gx CARGO_HOME $XDG_DATA_HOME/cargo

set -gx DOCKER_CONFIG $XDG_CONFIG_HOME/docker

set -gx GOPATH $XDG_DATA_HOME/go

set -gx LESSHISTFILE $XDG_STATE_HOME/less/history

set -gx MYPY_CACHE_DIR $XDG_CACHE_HOME/mypy

set -gx TERMINFO $XDG_DATA_HOME/terminfo
set -gx TERMINFO_DIRS $XDG_DATA_HOME/terminfo:/usr/share/terminfo

set -gx NPM_CONFIG_USERCONFIG $XDG_CONFIG_HOME/npm/npmrc

set -gx RUSTUP_HOME $XDG_DATA_HOME/rustup
###

set -gx EDITOR nvim
set -gx TERM wezterm

fish_add_path -g $CARGO_HOME/bin
set -gx LS_COLORS (vivid generate catppuccin-mocha)

fish_vi_key_bindings
fish_vi_cursor

function exa --wraps exa
  command exa --icons --git --group-directories-first $argv
end
abbr ls exa
abbr la exa -a
abbr ll exa -l
abbr lla exa -la
abbr lt exa -T

abbr ga git add
abbr gb git branch
abbr gc git commit
abbr gcm git checkout main
abbr gco git checkout
abbr gd git diff
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
