# use vi to navigate the command line
set -o vi

#set vim as default editor
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

# HIST* are bash-only variables, not environmental variables, so do not 'export'
# ignoredups only ignores _consecutive_ duplicates.
HISTCONTROL=erasedups:ignoreboth
# Undocumented feature which sets the size to "unlimited".
# http://stackoverflow.com/questions/9457233/unlimited-bash-history
HISTSIZE=
HISTFILESIZE=
HISTIGNORE='logout:exit:cd:ls:bg:fg:history:clear'
# Change the file location because certain bash sessions truncate .bash_history file upon close.
# http://superuser.com/questions/575479/bash-history-truncated-to-500-lines-on-each-login
HISTFILE=~/.bash_eternal_history
# append to the history file, don't overwrite it
shopt -s histappend

# truncate long paths to ".../foo/bar/baz"
export PROMPT_DIRTRIM=4

# Display matches for ambiguous patterns at first tab press
bind "set show-all-if-ambiguous on"

if [[ "$(uname)" == "Darwin" ]]; then

    alias ls='exa -ahl'
fi

[ -f ~/.bashrc.local ] && source ~/.bashrc.local

# brew install bash-completion@2
[[ -r "/opt/homebrew/etc/profile.d/bash_completion.sh" ]] && . "/opt/homebrew/etc/profile.d/bash_completion.sh"
# brew install fzf
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# brew install starship
eval "$(starship init bash)"
[ -f ~/g.sh ] && source ~/g.sh


function cleanup() {
    echo "Saving history and deduplicating entries"
    ~/bin/bash-history-cleaner $HISTFILE
}

trap cleanup EXIT

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH=$BUN_INSTALL/bin:$PATH

