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
export HISTCONTROL=erasedups:ignoreboth
# Undocumented feature which sets the size to "unlimited".
# http://stackoverflow.com/questions/9457233/unlimited-bash-history
export HISTSIZE=
export HISTFILESIZE=
export HISTIGNORE='exit:cd:ls:bg:fg:history:f:fd:clear'
export HISTTIMEFORMAT="[%F %T]"
# Change the file location because certain bash sessions truncate .bash_history file upon close.
# http://superuser.com/questions/575479/bash-history-truncated-to-500-lines-on-each-login
export HISTFILE=~/.bash_eternal_history
# append to the history file, don't overwrite it
shopt -s histappend

# truncate long paths to ".../foo/bar/baz"
export PROMPT_DIRTRIM=4

# Display matches for ambiguous patterns at first tab press
bind "set show-all-if-ambiguous on"

PS1='\[\033[0;32m\]\u@\h [\t] \[\033[33m\]\w\[\033[0m\]'

if [ -f ~/.git-prompt.sh ]; then
    GIT_PS1_STATESEPARATOR=""
    GIT_PS1_SHOWUPSTREAM="verbose"
    GIT_PS1_SHOWDIRTYSTATE=true
    GIT_PS1_SHOWUNTRACKEDFILES=true
    source ~/.git-prompt.sh
    PS1=$PS1'\[\033[1;36m$(__git_ps1)\033[0m\]'
fi

PS1=$PS1'
$ '

if [[ "$(uname)" == "Darwin" ]]; then

    alias ls='ls -ahl'
fi


[ -f /usr/local/etc/bash_completion ] && source /usr/local/etc/bash_completion
# from https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash
[ -f ~/git-completion.bash ] && source ~/git-completion.bash
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
[ -f ~/.bashrc.local ] && source ~/.bashrc.local

