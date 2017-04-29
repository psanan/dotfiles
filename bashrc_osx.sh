PDSRC_ROOT=/Users/patrick/pdsrc
source $PDSRC_ROOT/bashrc_common.sh
################################################################################

# To use MacVim. This is a kludge
export VIMRUNTIME=/Applications/MacVim.app/Contents/Resources/vim/runtime

# For python test harness
export PYTHONPATH=$PYTHONPATH:/Users/patrick/pythontestharness/lib

# PETSc
export PDS_PETSC_ARCHNAME=darwin

# Prompt, without hostname
# ( Don't forget the \[ \], or you'll have line-wrapping issues )
PS1='\[\e[1;31m\][\[\e[1;31m\]\W\[\e[0;36m\]$(__git_ps1 " (%s)")\[\e[1;31m\]]\$\[\e[0m\] '

# Set up ssh drive for pdsbox
# See http://osxfuse.github.io/
# (can unmount with umount)
alias pdsboxmount="mkdir -p /Volumes/ssh_pdsbox; sshfs patrick@pdsbox:/home/patrick /Volumes/ssh_pdsbox"

#Define a function which can title iTerm2 tabs
function title {
  echo -ne "\033]0;"$*"\007"
}

# iTerm2 tomfoolery to set the color of the tab for mutt
#  and to cd to the Downloads directory so attachments will end up there
alias mutt="cd ~/Downloads;echo -e \"\\033]6;1;bg;blue;brightness;155\\a\";echo -e \"\\033]6;1;bg;red;brightness;55\\a\";echo -e \"\\033]6;1;bg;green;brightness;55\\a\";mutt;echo -e \"\\033]6;1;bg;*;default\\a\";cd -"

# Set the tab title 
function title {
    echo -e "\033]6;1;bg;red;brightness;155\a";
    echo -e "\033]6;1;bg;green;brightness;55\a";
    echo -e "\033]6;1;bg;blue;brightness;155\a";
    echo -ne "\033]0;"$*"\007"
}

# Ideatron
alias iii="cd ~/Ideatron;python3 runme.py;cd -"
export IDEATRON_DATA_DIR=/Users/patrick/Google\ Drive/Ideatron_data

source ~/.helpers.sh

