#!/usr/bin/env bash
# Symlink settings files into the appropriate place.
#
# WARNING: this is not tested
# WARNING: this is not portable; the settings below are for Ubuntu
# WARNING: this uses ln -sf, which will clobber things!

PDSRCROOT=$HOME/pdsrc
LINK="ln -sf"

$LINK $PDSRCROOT/bash_profile.sh  $HOME/.bash_profile
$LINK $PDSRCROOT/bashrc_ubuntu.sh $HOME/.bashrc
$LINK $PDSRCROOT/vimrc            $HOME/.vimrc
$LINK $PDSRCROOT/latexmkrc        $HOME/.latexmkrc
$LINK $PDSRCROOT/gdbinit          $HOME/.gdbinit
$LINK $PDSRCROOT/octaverc         $HOME/.octaverc
