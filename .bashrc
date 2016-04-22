# use vi to navigate the command line
set -o vi

#set vim as default editor
export EDITOR=vim

# HIST* are bash-only variables, not environmental variables, so do not 'export'
# ignoredups only ignores _consecutive_ duplicates.
HISTCONTROL=erasedups:ignoreboth
HISTSIZE=20000
HISTFILESIZE=20000
HISTIGNORE='exit:cd:ls:bg:fg:history:f:fd'
HISTTIMEFORMAT='%F %T '
# append to the history file, don't overwrite it
shopt -s histappend
PROMPT_COMMAND='history -a' # append history file after each command
# truncate long paths to ".../foo/bar/baz"
PROMPT_DIRTRIM=4

# Display matches for ambiguous patterns at first tab press
bind "set show-all-if-ambiguous on"

#try to find git-prompt.sh if __git_ps1 was not automatically provided.
if ! type -t __git_ps1 > /dev/null 2>&1 ; then
    #cygwin (non-msysgit): try to find git-prompt.sh
    gitprompt_home="~/.git-prompt.sh" 
    [ -f "$gitprompt_home" ] && source "$gitprompt_home"
fi

PS1='\[\033[0;32m\]\u@\h \[\033[33m\]\w\[\033[0m\]'

# set git prompt iff function exists.
if type -t __git_ps1 &> /dev/null ; then
    PS1=$PS1'\[\033[1;36m$(__git_ps1)\033[0m\]'
    GIT_PS1_STATESEPARATOR=""
    GIT_PS1_SHOWUPSTREAM="verbose"
    GIT_PS1_SHOWCOLORHINTS=1
fi

PS1=$PS1'
$ '

if [[ "$(uname)" == Darwin ]]; then

    alias ls=ls -GC
    export PATH="/usr/local/Cellar/git/2.7.3/bin:$PATH"
fi


[ -f ~/.bashrc.local ] && source ~/.bashrc.local
