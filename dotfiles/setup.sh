#!/bin/sh

cd `dirname $0`
HERE=`pwd`
cd

if [ ! -d ~/bin ] ; then
  cd && ln -sf $HERE/bin .
fi

if [ ! -d ~/.oh-my-zsh ] ; then
  cd && git clone --recursive https://github.com/robbyrussell/oh-my-zsh.git ".oh-my-zsh"
  cd && ln -sf $HERE/yann.zsh-theme .oh-my-zsh/themes/
fi


cd && find $HERE -maxdepth 1 -name '_*' | while read f ; do
  fd=`basename $f | sed 's/^_/./'`
  if [ ! -h $fd ] ; then
    ln -sf $f $fd
  fi
done

#echo '### vim'
#curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
      #https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
#ln -sf ${HERE}/init.vim ~/.vimrc
#vim -c "PlugInstall"

#echo '### neovim'
#mkdir -p ~/.config/nvim/autoload
#cp ~/.vim/autoload/plug.vim ~/.config/nvim/autoload
#ln -sf ${HERE}/init.vim ~/.config/nvim/

