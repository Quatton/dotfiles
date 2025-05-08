if status is-interactive
    # Commands to run in interactive sessions can go here
end
fish_add_path $HOME/Documents/GitHub/vcpkg $HOME/Library/Caches/fnm_multishells/10903_1726801343410/bin /opt/homebrew/opt/ccache/libexec ~/mybin /opt/homebrew/lib/ruby/gems/3.3.0/bin /opt/homebrew/opt/ruby/bin ~/go/bin ~/.sst/bin /opt/homebrew/bin ~/.bun/bin ~/.deno/bin /opt/homebrew/opt/libpq/bin ~/Library/Application\ Support/edgedb/binse /opt/homebrew/opt/ccache/libexec $HOME/Library/Android/sdk/platform-tools ~/flutter/bin $HOME/.local/bin
alias blender="/Applications/Blender.app/Contents/MacOS/Blender"

alias ll="eza -l -g --icons --git"
alias llt="eza -1 --icons --tree -L 2 --git-ignore"
alias rl=". $fish_config"
alias cfg="nvim $fish_config"
alias act="source .venv/bin/activate.fish"
alias cd="z"


alias g="git"
alias gc="git commit -m"
alias gall="git add ."
alias gch="git checkout"
# Git aliases
git config --global alias.c "commit -m"
git config --global alias.all "add ."
git config --global alias.ch "checkout"
git config --global alias.lg "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"

alias search="fzf --preview 'bat --color=always --style=numbers --line-range=:500 {}' | xargs nvim"

set -gx VCPKG_ROOT "$HOME/Documents/GitHub/vcpkg";
set -g theme_nerd_fonts yes
set -x GPG_TTY (tty)

set -g videos ~/Documents/Drive/Videos
set -g recordings "$video/Raw Recording"

# cargo
. "$HOME/.cargo/env.fish"

# opam configuration
source $HOME/.opam/opam-init/init.fish > /dev/null 2> /dev/null; or true

if command -v ngrok &>/dev/null
    eval "$(ngrok completion)"
end

pyenv init - | source
starship init fish | source
zoxide init fish | source
eval $(fnm env) | source

# Added by OrbStack: command-line tools and integration
# This won't be added again if you remove it.
source ~/.orbstack/shell/init2.fish 2>/dev/null || :
