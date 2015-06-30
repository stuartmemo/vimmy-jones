My vim config and plugins
=========================

Clone repo
----------
```shell
git clone git@github.com:stuartmemo/vimmy-jones.git ~/.vim
```

Create symlinks
---------------
```shell
ln -s ~/.vim/vimrc ~/.vimrc
ln -s ~/.vim/viminfo ~/.viminfo
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
