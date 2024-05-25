$env.PATH = (
    [
        ~/.local/bin
        ~/.cargo/bin
        /opt/homebrew/bin
        /home/linuxbrew/.linuxbrew/bin
    ]
    | append $env.PATH | split row (char esep)
    | uniq
)

$env.EDITOR = nvim
