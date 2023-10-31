$PSReadLineOptions = @{
  BellStyle = 'None'
  CompletionQueryItems = 20
  EditMode = 'Emacs'
  PredictionSource = 'HistoryAndPlugin'
  WordDelimiters = ';:,.[]{}()/\|^&*-=+_''---'
}
Set-PSReadLineOption @PSReadLineOptions

if (Get-Command eza -errorAction SilentlyContinue)
{
  Set-Alias ls eza
  Set-Alias l eza
  function la { eza -a $args }
  function ll { eza -l $args }
  function lla { eza -la $args }
  function lt { eza --tree $args }
  function ga { git add $args }
  function gb { git branch $args }
  function gc { git commit $args }
  function gcm { git checkout main $args }
  function gco { git checkout $args }
  function gd { git diff $args }
  function gdt { git difftool $args }
  function gl { git pull $args }
  function gp { git push $args }
  function gr { git rebase $args }
  function gra { git rebase --abort $args }
  function grc { git rebase --continue $args }
  function gs { git switch $args }
  function gst { git status $args }
}

if (Get-Command starship -errorAction SilentlyContinue)
{
  function Invoke-Starship-TransientFunction
  {
    &starship module character
  }
  Invoke-Expression (&starship init powershell)
  Enable-TransientPrompt
}

# important! zoxide must remain the last thing initialised.
# https://github.com/ajeetdsouza/zoxide/issues/586
if (Get-Command zoxide -errorAction SilentlyContinue)
{
  Invoke-Expression (& { (zoxide init powershell | Out-String) })
}
