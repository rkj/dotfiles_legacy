
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
