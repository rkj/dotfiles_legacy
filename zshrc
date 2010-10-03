HISTSIZE=100000
SAVEHIST=100000
HISTFILE=~/.history

bindkey '^X^E' edit-command-line
bindkey -e
setopt notify
setopt autopushd pushdminus pushdsilent pushdtohome
setopt cdablevars
setopt nobanghist
setopt noclobber
setopt HIST_REDUCE_BLANKS
setopt HISTIGNOREDUPS
setopt HIST_IGNORE_SPACE
setopt SH_WORD_SPLIT
setopt EXTENDED_HISTORY
setopt nohup

cdpath=(. ~/Projects ~/Desktop ~/DropBox ~/misc)
echo -ne "Today is "; date
echo -ne "Uptime: "; uptime

