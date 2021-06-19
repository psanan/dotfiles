#!/usr/bin/env sh

psanan_rc_root=$HOME/util/rc
link="ln -sf"  # WARNING: will clobber

# Local files, which don't have the initial "."
for dot_file in \
  "bash_profile" \
  "bashrc" \
  "config/alacritty/alacritty.yml" \
  "config/yapf/style" \
  "gdbinit" \
  "latexmkrc" \
  "profile" \
  "screenrc" \
  "tmux.conf" \
  "vim/after/indent/python.vim" \
  "vim/spell/en.utf-8.add" \
  "vimrc" \
  ; \
do
  mkdir -p $(dirname $dot_file)
  $link "$psanan_rc_root/$dot_file" "$HOME/.$dot_file"
done

if [[ "$OSTYPE" == "darwin"* ]]; then
  lazygit_target_dir="$HOME/Library/Application Support/jesseduffield/lazygit"
else
  lazygit_target_dir="$HOME/.config/jesseduffield/lazygit"
fi
mkdir -p "$lazygit_target_dir"
$link "$psanan_rc_root/config/jesseduffield/lazygit/config.yml" "$lazygit_target_dir/config.yml"
