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

alias knife='nocorrect knife'

alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'
alias -g G='| egrep'
alias -g H='| head'

function hdv() { hg diff $* | vim -R - }

function hdg() { hg diff $* | gvim -R - }

function mhg() {
  local mhgrepo
  for d in `find . -mindepth 2 -depth -name .hg | sort` `pwd`/.hg; do 
    mhgrepo=`dirname "$d"`
    echo "$fg[red]$mhgrepo$fg[default]"
    (cd $mhgrepo && hg $*)
  done
}

function chuck() {
  ps aux | grep $1 | tr -s '\t' ' ' | cut -f2 -d' ' | xargs kill $2 
}

trash() {
  for file in "$@"; do # Cycle through each argument for deletion
    if [ -e "$file" ]; then
      if [ ! -d ~/.Trash/"${file:t}" ]; then # Target exists and can be moved to Trash safely
        mv "$file" ~/.Trash
      else # Target exists and conflicts with target in Trash
        i=1
        while [ -e ~/.Trash/"${file:t}.$i" ]; do
          i=$(($i + 1)) # Increment target name until there is no longer a conflict
        done
        mv "$file" ~/.Trash/"${file:t}.$i" # Move to the Trash with non-conflicting name
      fi
    else # Target doesn't exist, return error
      echo "trash: $file: No such file or directory";
    fi
  done
}

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
if [[ -x /home/rkj ]]; then 
  echo_free /home 
  echo_free /var
fi
upgrades
echo -ne "Today is "; date
echo -ne "Uptime: "; uptime


