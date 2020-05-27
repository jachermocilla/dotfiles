#!/bin/bash
#jachermocilla@gmail.com

#pass any parameter to copy the vimrc only
if [ "$#" -eq 1 ]; then
   cp vimrc ~/.vimrc
   exit 0
fi


sudo apt-get install exuberant-ctags curl

#install plugins using pathogen
mkdir -p ~/.vim/autoload ~/.vim/bundle && \
curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

mkdir ~/.vim
unzip -o plugins/taglist_46.zip -d ~/.vim/
unzip -o plugins/bufexplorer-7.4.21.zip -d ~/.vim/
unzip -o plugins/winmanager.zip -d ~/.vim/

cp srg-license.txt ~/.vim/
cp vimrc ~/.vimrc

rm -fr ~/.vim/bundle/vim-airline
rm -fr ~/.vim/bundle/vim-gitgutter
rm -fr ~/.vim/bundle/echofunc

git clone --depth 1 https://github.com/vim-airline/vim-airline ~/.vim/bundle/vim-airline
git clone --depth 1 https://github.com/airblade/vim-gitgutter ~/.vim/bundle/vim-gitgutter
git clone --depth 1 https://github.com/mbbill/echofunc.git ~/.vim/bundle/echofunc
git clone --depth 1 https://github.com/moll/vim-node.git ~/.vim/bundle/node
git clone --depth 1 https://github.com/MaxMEllon/vim-jsx-pretty.git ~/.vim/bundle/vim-jsx-pretty
