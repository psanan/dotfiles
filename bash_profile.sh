source $HOME/.profile
source $HOME/.bashrc

# Display paths after manipulations by the other startup files
printf "\033[34mPATH=\033[0m$PATH\n"
printf "\033[34mPYTHONPATH=\033[0m$PYTHONPATH\n"

# If GNU screen exists and there are any screens running, display them
if command -v screen > /dev/null; then
  printf "\033[34mGNU Screen:\033[0m "
  if ! screen -ls; then
    screen -ls
  fi;
fi;
