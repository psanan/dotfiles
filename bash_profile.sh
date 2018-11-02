source $HOME/.profile
source $HOME/.bashrc

# If GNU screen exists, run screen -ls
if command -v screen > /dev/null; then
  printf "\033[34mGNU Screen:\033[0m "
  screen -ls
fi;
