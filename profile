
alias pg="ps aux | grep "
alias 7z='7z -t7z -m0=lzma -mx=9 -mfb=64 -md=32m -ms=on'
alias lzma='lzma -vk'
alias git=hub

function mhg() {
	for d in `find . -mindepth 2 -depth -name .hg` `pwd`/.hg; do 
		repo=`dirname "$d"`
		echo -e "\033[31m$repo\033[0m"
		(cd $repo && hg $*)
	done
}

function chuck() {
	ps aux | grep $1 | tr -s '\t' ' ' | cut -f2 -d' ' | xargs kill $2 
}

