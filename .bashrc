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


PS1='\[\033[0;32m\]\u@Rome \[\033[33m\]\w\[\033[0m\]'
PS1=$PS1"\n$ "

# brew install bash-git-prompt
if [ -f "/opt/homebrew/opt/bash-git-prompt/share/gitprompt.sh" ]; then
    GIT_PROMPT_SHOW_UPSTREAM=0
    GIT_PROMPT_ONLY_IN_REPO=1
    GIT_PROMPT_START="_LAST_COMMAND_INDICATOR_ \[\033[0;32m\]\u@Rome \[\033[33m\]\w\[\033[0m\]"
    GIT_PROMPT_END="\n$ "
    source /opt/homebrew/opt/bash-git-prompt/share/gitprompt.sh
fi

if [[ "$(uname)" == "Darwin" ]]; then

    alias ls='ls -ahl'
fi

[ -f /usr/local/etc/bash_completion ] && source /usr/local/etc/bash_completion
# from https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash
[ -f ~/git-completion.bash ] && source ~/git-completion.bash
# brew install fzf
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
# brew install z
[ -f /opt/homebrew/etc/profile.d/z.sh ] && source /opt/homebrew/etc/profile.d/z.sh
[ -f ~/.bashrc.local ] && source ~/.bashrc.local

trap "~/history-dedup $HISTFILE" EXIT
