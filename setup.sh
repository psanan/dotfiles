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
$link $psanan_rc_root/tmux.conf    $HOME/.tmux.conf

mkdir -p $HOME/.vim/after/indent
mkdir -p $HOME/.vim/spell
$link $psanan_rc_root/vimrc                       $HOME/.vimrc
$link $psanan_rc_root/vim/after/indent/python.vim $HOME/.vim/after/indent/python.vim
$link $psanan_rc_root/vim/spell/en.utf-8.add      $HOME/.vim/spell/en.utf-8.add

yapf_dir=$psanan_rc_root/config/yapf
yapf_target_dir="$HOME/.config/yapf"
mkdir -p "$yapf_target_dir"
$link "$yapf_dir/style"             "$yapf_target_dir/style"

lazygit_dir="$psanan_rc_root/config/jesseduffield/lazygit"
if [[ "$OSTYPE" == "darwin"* ]]; then
  lazygit_target_dir="$HOME/Library/Application Support/jesseduffield/lazygit"
else
  lazygit_target_dir="$HOME/.config/jesseduffield/lazygit"
fi
mkdir -p "$lazygit_target_dir"
$link "$lazygit_dir/config.yml"     "$lazygit_target_dir/config.yml"

echo $link "$lazygit_dir/config.yml"     "$lazygit_target_dir/config.yml"

echo "$lazygit_dir" "$lazygit_target_dir"
