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


function free_space() {
  df -h $1 | tail -1 | tr -s '\t ' '  ' | cut -f 4 -d' '
}
function echo_free() {
  echo Free $1 space: $fg[yellow]$(free_space $1)$fg[default]
}

function upgrades() {
  if [[ -n `which pacman` ]]; then return; fi
  if [[ `pacman -Sup | grep "nothing to do" | wc -l` > 0 ]]; then
    return
  fi
  local package_no
  package_no=`pacman -Sup | wc -l`
  echo There are $fg[red]$((package_no-1))$fg[default] packages to upgrade
}

cdpath=(. ~/Projects ~/Desktop ~/DropBox ~/misc)

echo_free /
echo_free /home
echo_free /var
upgrades
echo -ne "Today is "; date
echo -ne "Uptime: "; uptime

