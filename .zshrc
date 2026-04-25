set -o vi

# set vim as default editor
export EDITOR=vim

# prefer ripgrep if it exists because it honors .ignore entries and it's faster
if type rg > /dev/null 2>&1; then
    export FZF_DEFAULT_COMMAND="rg --files"
fi

# give me nice colors
export TERM=xterm-256color

# do not pollute my directories with undo files
[ -d ~/.vim/undodir ] || mkdir -p ~/.vim/undodir

# for signing git commits
export GPG_TTY=$(tty)

# History behavior
HISTFILE=~/.zsh_eternal_history
HISTSIZE=1000000000
SAVEHIST=1000000000

setopt EXTENDED_GLOB
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_SAVE_NO_DUPS
setopt APPEND_HISTORY
setopt SHARE_HISTORY

HISTORY_IGNORE="(logout|exit|cd|ls|bg|fg|history|clear)"

# edit current command line in vim (press v in normal mode)
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey -M vicmd 'v' edit-command-line

if [[ "$(uname)" == "Darwin" ]]; then
    alias ls='ls -ahl'
fi

[ -f ~/.zshrc.local ] && source ~/.zshrc.local

if type brew &>/dev/null; then
    FPATH=$(brew --prefix)/share/zsh-completions:$FPATH
    autoload -Uz compinit
    compinit
fi

# brew install fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# brew install starship
eval "$(starship init zsh)"

# fuzzy cd
g() {
    local output
    if output=$(~/bin/fuzzy-cd ~/.ffzdb "$*"); then
        cd "$output"
    fi
}

# execute this when changing directories
chpwd() {
    ~/bin/fuzzy-cd --add ~/.ffzdb "$(command pwd -P)" &!
}

# This might not be needed with zsh when using setopt HIST_SAVE_NO_DUPS
# function cleanup() {
#     ~/bin/bash-history-cleaner $HISTFILE
# }
#
# trap cleanup EXIT

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH=$BUN_INSTALL/bin:$PATH

