$PSReadLineOptions = @{
    BellStyle = 'None'
    CompletionQueryItems = 20
    EditMode = 'Emacs'
    PredictionSource = 'HistoryAndPlugin'
    WordDelimiters = ';:,.[]{}()/\|^&*-=+_''---'
}
Set-PSReadLineOption @PSReadLineOptions

if (Get-Command eza -errorAction SilentlyContinue) {
    Set-Alias ls eza
    Set-Alias l eza
    function la { eza -a }
    function ll { eza -l }
    function lla { eza -la }
    function lt { eza --tree }
}

if (Get-Command zoxide -errorAction SilentlyContinue) {
    Invoke-Expression (& { (zoxide init powershell | Out-String) })
}

if (Get-Command starship -errorAction SilentlyContinue) {
    function Invoke-Starship-TransientFunction {
        &starship module character
    }
    Invoke-Expression (&starship init powershell)
    Enable-TransientPrompt
}
