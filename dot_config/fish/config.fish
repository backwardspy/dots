set -gx EDITOR nvim

fish_add_path -g ~/.cargo/bin
fish_add_path -g ~/.local/bin
fish_vi_key_bindings
fish_vi_cursor

abbr ls lsd
abbr la lsd -a
abbr ll lsd -l
abbr lla lsd -la
abbr lt lsd --tree

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
