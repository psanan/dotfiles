# MacPorts
export PATH="/opt/local/bin:/opt/local/sbin:$PATH"

# Python Test Harness
export PYTHONPATH=$PYTHONPATH:$HOME/pythontestharness/lib

# stice-gg
export PATH="$HOME/code/stice-gg:$PATH"

# If GNU screen exists, run screen -ls
if command -v screen > /dev/null; then
  printf "\033[34mGNU Screen:\033[0m "
  screen -ls
fi;
