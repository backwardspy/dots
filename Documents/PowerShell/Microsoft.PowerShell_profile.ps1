$PSReadLineOptions = @{
  EditMode = 'Emacs'
  PredictionSource = 'HistoryAndPlugin'
}
Set-PSReadLineOption @PSReadLineOptions

Import-Module Catppuccin
$Flavor = $Catppuccin['Latte']
function prompt {
    $(if (Test-Path variable:/PSDebugContext) { "$($Flavor.Red.Foreground())[DBG]: " }
      else { '' }) + "$($Flavor.Teal.Foreground())PS $($Flavor.Yellow.Foreground())" + $(Get-Location) +
        "$($Flavor.Green.Foreground())" + $(if ($NestedPromptLevel -ge 1) { '>>' }) + '> ' + $($PSStyle.Reset)
}

$Colors = @{
	ContinuationPrompt     = $Flavor.Teal.Foreground()
	Emphasis               = $Flavor.Red.Foreground()
	Selection              = $Flavor.Surface0.Background()
	InlinePrediction       = $Flavor.Overlay0.Foreground()
	ListPrediction         = $Flavor.Mauve.Foreground()
	ListPredictionSelected = $Flavor.Surface0.Background()
	Command                = $Flavor.Blue.Foreground()
	Comment                = $Flavor.Overlay0.Foreground()
	Default                = $Flavor.Text.Foreground()
	Error                  = $Flavor.Red.Foreground()
	Keyword                = $Flavor.Mauve.Foreground()
	Member                 = $Flavor.Rosewater.Foreground()
	Number                 = $Flavor.Peach.Foreground()
	Operator               = $Flavor.Sky.Foreground()
	Parameter              = $Flavor.Pink.Foreground()
	String                 = $Flavor.Green.Foreground()
	Type                   = $Flavor.Yellow.Foreground()
	Variable               = $Flavor.Lavender.Foreground()
}
Set-PSReadLineOption -Colors $Colors

if (Get-Command eza -errorAction SilentlyContinue)
{
  Set-Alias ls eza
  Set-Alias l eza
  function la { eza -a $args }
  function ll { eza -l $args }
  function lla { eza -la $args }
  function lt { eza --tree $args }
}

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
