# Prompt
export PS1="\e[1;33m\u\e[0m@\e[1;34m\h\e[0m :: \e[1;31m\W\e[0m > "

# Aliases file
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# History Control
export HISTCONTROL=ignoredups:erasedups

# LS colors
export CLICOLOR=1;
export LSCOLORS=exfxcxdxbxegedabagacad;

#pyenv
eval "$(pyenv init -)"


if [[ $(uname -s) == Darwin ]]
then
	# GIT Tab completion
	if [ -f `brew --prefix`/etc/bash_completion.d/git-completion.bash ]; then
	  . `brew --prefix`/etc/bash_completion.d/git-completion.bash
	fi
fi

export FZF_TMUX=0
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

#--------------------Persistent History-----------------
# Add this code to your .bashrc to save persistent history
#
# See http://eli.thegreenplace.net/2013/06/11/keeping-persistent-history-in-bash
# for details.
#
# Note, HISTTIMEFORMAT has to be set and end with at least one space; for
# example:
#
#   export HISTTIMEFORMAT="%F %T  "
#
# If your format is set differently, you'll need to change the regex that
# matches history lines below.
#
# Eli Bendersky (http://eli.thegreenplace.net)
# This code is in the public domain

export HISTTIMEFORMAT="%F %T  "
log_bash_persistent_history()
{
  local rc=$?
  [[ $(history 1) =~ ^\ *[0-9]+\ +([^\ ]+\ [^\ ]+)\ +(.*)$ ]]
  local date_part="${BASH_REMATCH[1]}"
  local command_part="${BASH_REMATCH[2]}"
  if [ "$command_part" != "$PERSISTENT_HISTORY_LAST" ]
  then
    echo $date_part "|" "$command_part" >> ~/.persistent_history
    export PERSISTENT_HISTORY_LAST="$command_part"
  fi
}

 # Stuff to do on PROMPT_COMMAND
run_on_prompt_command()
{
    log_bash_persistent_history
}
if [ "$PROMPT_COMMAND" = "" ]
then
    PROMPT_COMMAND="run_on_prompt_command"
else
    PROMPT_COMMAND="run_on_prompt_command; ""$PROMPT_COMMAND"
fi

# enable FZF, the bash.rc location doesn't seem to work
# note added this the fzf completion to make ctrl r use persistent history
# this is in ~/.fzf/shell/key-bindings.bash
#
__fzf_history__() (
 local line
 shopt -u nocaseglob nocasematch
 line=$(
   cat ~/.persistent_history |
   $(__fzfcmd) +s --tac +m -n2..,.. --tiebreak=index --toggle-sort=ctrl-r |
  \grep '^ *[0-9]') && sed 's/^ *\([^|]*| \)\(.*\)/\2/' <<< "$line"
)

# use ripgrep in fzf's interface
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!.git/*"'

# Ctrl-p select a file through fzf and open in vim
bind -x '"\C-p": vim $(fzf);'

