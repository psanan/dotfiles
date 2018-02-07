source ~/.profile
source ~/.bashrc

# Display the shell and the paths after manipulations by the other startup files
printf "\033[34mSHELL=\033[0m$SHELL\n"
printf "\033[34mPATH=\033[0m$PATH\n"
printf "\033[34mPYTHONPATH=\033[0m$PYTHONPATH\n"
