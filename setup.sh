#!/usr/bin/env sh

root=$PWD
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
  "tmux.conf" \
  "vim/after/indent/python.vim" \
  "vimrc" \
  ; \
do
  dest="$HOME/.$dot_file"
  mkdir -p $(dirname $dest)
  $link "$root/$dot_file" "$dest"
done

if [ "$OSTYPE" = "darwin"* ]; then
  lazygit_target_dir="$HOME/Library/Application Support/jesseduffield/lazygit"
else
  lazygit_target_dir="$HOME/.config/jesseduffield/lazygit"
fi
mkdir -p "$lazygit_target_dir"
$link "$root/config/jesseduffield/lazygit/config.yml" "$lazygit_target_dir/config.yml"
