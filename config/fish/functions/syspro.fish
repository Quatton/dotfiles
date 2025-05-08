function syspro
    command docker run --name syspro --rm -it -v $argv:/home/vscode -v ~/.local/share/nvim:/root/.local/share/nvim/ syspro:nvim
end
