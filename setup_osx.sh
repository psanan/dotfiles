#!/usr/bin/env bash
# Symlink settings files into the appropriate place.
#
# WARNING: this is not tested
# WARNING: this is not portable; the settings below are for my OS X machine
# WARNING: this uses ln -sf, which will clobber things!

PDSRC_ROOT=$HOME/util/pdsrc
LINK="ln -sf"

$LINK $PDSRC_ROOT/profile_osx.sh    $HOME/.profile
$LINK $PDSRC_ROOT/bash_profile.sh   $HOME/.bash_profile
$LINK $PDSRC_ROOT/bashrc_osx.sh     $HOME/.bashrc
$LINK $PDSRC_ROOT/vimrc             $HOME/.vimrc
$LINK $PDSRC_ROOT/latexmkrc         $HOME/.latexmkrc
$LINK $PDSRC_ROOT/gdbinit           $HOME/.gdbinit
$LINK $PDSRC_ROOT/octaverc          $HOME/.octaverc
$LINK $PDSRC_ROOT/ycm_extra_conf.py $HOME/.ycm_extra_conf.py
