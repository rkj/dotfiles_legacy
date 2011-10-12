#!/bin/sh

# find proper path
root=`dirname "$PWD"/"$0"`/
cd $root
root=`pwd`

# init all modules
git submodule init
git submodule update

# make symlinks
for i in gitconfig gitignore hgignore irbrc tmux.conf vim vimrc; do
  ln -nfs $root/$i $HOME/.$i
done;

if [[ ! -e $HOME/.zshrc ]]; then
  echo '[[ -e $HOME/.profile ]] && source $HOME/.profile' > $HOME/.zshrc
  echo "[[ -e $root/.profile ]] && source $root/.profile" >> $HOME/.zshrc
  echo "export ZSH=$root/oh-my-zsh"                       >> $HOME/.zshrc
  echo 'export ZSH_THEME="rkj-repos"'                     >> $HOME/.zshrc
  echo 'source $ZSH/oh-my-zsh.sh'                         >> $HOME/.zshrc
  echo "source $root/zshrc"                               >> $HOME/.zshrc
fi
if [[ ! -e $HOME/.hgrc ]]; then
  echo "echo [ui]"                            >$HOME/.hgrc
  echo "username = Please fill me"            >> $HOME/.hgrc
  echo "%include /home/rkj/misc/scripts/hgrc" >> $HOME/.hgrc
fi


