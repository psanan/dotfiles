#!/usr/bin/env bash
# Symlink settings files into the appropriate place.
#
# WARNING: this uses ln -sf by default, which will clobber

PDSRC_ROOT=$HOME/util/pdsrc
LINK="ln -sf"

$LINK $PDSRC_ROOT/profile.sh        $HOME/.profile
$LINK $PDSRC_ROOT/bash_profile.sh   $HOME/.bash_profile
$LINK $PDSRC_ROOT/bashrc.sh         $HOME/.bashrc
$LINK $PDSRC_ROOT/vimrc             $HOME/.vimrc
$LINK $PDSRC_ROOT/latexmkrc         $HOME/.latexmkrc
$LINK $PDSRC_ROOT/gdbinit           $HOME/.gdbinit
$LINK $PDSRC_ROOT/octaverc          $HOME/.octaverc
$LINK $PDSRC_ROOT/ycm_extra_conf.py $HOME/.ycm_extra_conf.py
$LINK $PDSRC_ROOT/screenrc          $HOME/.screenrc
