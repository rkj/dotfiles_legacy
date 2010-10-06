
export HISTFILESIZE=10000
export HISTCONTROL=ignoredups

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LC_COLLATE=pl_PL.UTF-8
export JAVA_OPTS="-Dfile.encoding=utf8"
export PATH=$HOME/misc/bin:$PATH

alias mv='mv -i'
alias cp='cp -i'
alias duu='du -s * .[^.]* 2>/dev/null | sort -n'
alias bc='bc -l ~/.bc'
alias port='sudo port'
alias git=hub
alias pg="ps aux | grep "
alias ka="killall -vm "
alias sudo='sudo -E'

alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'
alias -g G='| egrep'
alias -g H='| head'

alias pg="ps aux | grep "
alias 7z='7z -t7z -m0=lzma -mx=9 -mfb=64 -md=32m -ms=on'
alias lzma='lzma -vk'
alias git=hub

function mhg() {
  for d in `find . -mindepth 2 -depth -name .hg | sort` `pwd`/.hg; do 
    repo=`dirname "$d"`
    echo -e "\033[31m$repo\033[0m"
    (cd $repo && hg $*)
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
