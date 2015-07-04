My vim config and plugins
=========================

Clone repo
----------
```shell
git clone git@github.com:stuartmemo/vimto.git ~/.vim
```

Create symlinks
---------------
```shell
ln -s ~/.vim/vimrc ~/.vimrc
ln -s ~/.vim/viminfo ~/.viminfo
ln -s ~/.vim/tmux.conf ~/.tmux.conf
```

Install submodules
------------------
```shell
cd ~/.vim
git submodule init
git submodule update
```

Open vim, then run
```shell
:BundleInstall
```
