use starship.nu

use catppuccin.nu [catppuccin catppuccin-theme]

$env.config = {
  show_banner: false,
  color_config: (catppuccin-theme latte),
}

# vivid generate THEME | str trim | save -f ($nu.default-config-dir | path join vivid)
$env.LS_COLORS = (cat ($nu.default-config-dir | path join vivid))

alias ga = git add
alias gb = git branch
alias gc = git commit
alias gcm = git checkout main
alias gco = git checkout
alias gd = git diff
alias gdt = git difftool
alias gl = git pull
alias gp = git push
alias gr = git rebase
alias gra = git rebase --abort
alias grc = git rebase --continue
alias gs = git switch
alias gst = git status

alias kctx = kubectx
alias ke = kubectl exec -it
alias kgd = kubectl get deployments
alias kgp = kubectl get pods
alias kl = kubectl logs -f
alias kns = kubens

alias pa = poetry add
alias pad = poetry add --group dev
alias pi = poetry install
alias pr = poetry run
alias psh = poetry shell

alias dc = docker-compose
alias dcb = docker-compose build
alias dcd = docker-compose down
alias dcu = docker-compose up -d
def dcdu [] { docker-compose down ; docker-compose build ; docker-compose up -d }

alias vn = python -m venv .venv
# alias va = . .venv/bin/activate.fish
alias vd = deactivate
