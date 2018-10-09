source $HOME/.profile
source $HOME/.bashrc

# Display paths after manipulations by the other startup files
printf "\033[34mPATH=\033[0m$PATH\n"
printf "\033[34mPYTHONPATH=\033[0m$PYTHONPATH\n"

# If GNU screen exists, run screen -ls
if command -v screen > /dev/null; then
  printf "\033[34mGNU Screen:\033[0m "
  screen -ls
fi;

# added by Anaconda3 5.2.0 installer
export PATH="/Users/patrick/anaconda3/bin:$PATH"
