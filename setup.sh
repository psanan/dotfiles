#!/usr/bin/env sh

root=$PWD
link="ln -sf"  # WARNING: will clobber

# Local files, which don't have the initial "."
for dot_file in \
  "bash_profile" \
  "bashrc" \
  "config/alacritty/alacritty.yml" \
  "config/lazygit/config.yml" \
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
  mkdir -p $(dirname "$dest")
  $link "$root/$dot_file" "$dest"
done

# Lazygit uses a different default configuration directory on OS X
if [ "$OSTYPE" = "darwin"* ]; then
  lazygit_config_dir="$HOME/Library/Application Support/lazygit"
  mkdir -p "$lazygit_config_dir"
  $link "$root/config/lazygit/config.yml" "$lazygit_config_dir/config.yml"
fi
