#!/usr/bin/env sh
# Symlink settings files into the appropriate place.
#
# WARNING: this uses ln -sf by default, which will clobber

PSANAN_RC_ROOT=$HOME/util/rc
LINK="ln -sf"

$LINK $PSANAN_RC_ROOT/profile           $HOME/.profile
$LINK $PSANAN_RC_ROOT/bash_profile      $HOME/.bash_profile
$LINK $PSANAN_RC_ROOT/bashrc            $HOME/.bashrc
$LINK $PSANAN_RC_ROOT/vimrc             $HOME/.vimrc
mkdir -p $HOME/.vim/after/indent
$LINK $PSANAN_RC_ROOT/.vim/after/indent/python.vim $HOME/.vimrc/after/indent/python.vim
$LINK $PSANAN_RC_ROOT/latexmkrc         $HOME/.latexmkrc
$LINK $PSANAN_RC_ROOT/gdbinit           $HOME/.gdbinit
$LINK $PSANAN_RC_ROOT/octaverc          $HOME/.octaverc
