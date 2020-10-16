#!/usr/bin/env sh
# Symlink settings files into the appropriate place.

psanan_rc_root=$HOME/util/rc
link="ln -sf"  # WARNING: will clobber

$link $psanan_rc_root/profile      $HOME/.profile
$link $psanan_rc_root/bash_profile $HOME/.bash_profile
$link $psanan_rc_root/bashrc       $HOME/.bashrc

$link $psanan_rc_root/gdbinit      $HOME/.gdbinit
$link $psanan_rc_root/latexmkrc    $HOME/.latexmkrc
$link $psanan_rc_root/octaverc     $HOME/.octaverc
$link $psanan_rc_root/screenrc     $HOME/.screenrc

mkdir -p $HOME/.vim/after/indent
mkdir -p $HOME/.vim/spell
$link $psanan_rc_root/vimrc                       $HOME/.vimrc
$link $psanan_rc_root/vim/after/indent/python.vim $HOME/.vim/after/indent/python.vim
$link $psanan_rc_root/vim/spell/en.utf-8.add      $HOME/.vim/spell/en.utf-8.add

yapf_dir=config/yapf
mkdir -p $HOME/.$yapf_dir
$link $psanan_rc_root/config/yapf/style           $HOME/.$yapf_dir/style

lazygit_dir=config/jesseduffield/lazygit
mkdir -p $HOME/.$lazygit_dir
$link $psanan_rc_root/$lazygit_dir/config.yml     $HOME/.$lazygit_dir/config.yml
