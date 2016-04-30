# dotspacemacs-travis-build

[![Build Status](https://travis-ci.org/juntaki/dotspacemacs-travis-build.svg?branch=master)](https://travis-ci.org/juntaki/dotspacemacs-travis-build)

.emacs.d and emacs built by travis-ci.org with spacemacs.

Build result: https://github.com/juntaki/dotemacs

## How to use

~~~
git clone https://github.com/juntaki/dotemacs.git ~/.dotfiles/dotemacs
sudo ln -sf ~/.dotfiles/dotemacs/emacs /opt/ 
ln -sf ~/.dotfiles/dotemacs/.emacs.d ~/
ln -sf ~/.dotfiles/dotemacs/.spacemacs ~/
~~~

Add the PATH into your .*shrc

~~~
export PATH=/opt/emacs/bin:$PATH
~~~
