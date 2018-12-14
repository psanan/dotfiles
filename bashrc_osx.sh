PDSRC_ROOT=$HOME/util/pdsrc
source $PDSRC_ROOT/bashrc_common.sh
################################################################################

# To use MacVim. This is a kludge
export VIMRUNTIME=/Applications/MacVim.app/Contents/Resources/vim/runtime

# Use prompt without hostname
PS1=$PS1_LOCAL

# PETSc
export PDS_PETSC_ARCHNAME=darwin

# PETSc builds for SPIDER (bitbucket.org/djbower/spider-dev)
alias setpdirectopt="export PETSC_DIR=$HOME/code/petsc-double-direct;export PETSC_ARCH=arch-darwin-c-opt;export PMPI=$HOME/code/petsc-double-direct/arch-darwin-c-opt/bin/mpiexec; whichp;"
alias setpdirect="export PETSC_DIR=$HOME/code/petsc-double-direct;export PETSC_ARCH=arch-darwin-c-debug;export PMPI=$HOME/code/petsc-double-direct/arch-darwin-c-debug/bin/mpiexec; whichp;"
alias setpdirectopt128="export PETSC_DIR=$HOME/code/petsc-quad-direct;export PETSC_ARCH=arch-darwin-c-opt;export PMPI=$HOME/code/petsc-quad-direct/arch-darwin-c-opt/bin/mpiexec; whichp;"
alias setpdirect128opt=setpdirectopt128
alias setpdirect128="export PETSC_DIR=$HOME/code/petsc-quad-direct;export PETSC_ARCH=arch-darwin-c-debug;export PMPI=$HOME/code/petsc-quad-direct/arch-darwin-c-debug/bin/mpiexec; whichp;"

# Function which can title iTerm2 tabs
function title {
    echo -e "\033]6;1;bg;red;brightness;155\a";
    echo -e "\033]6;1;bg;green;brightness;55\a";
    echo -e "\033]6;1;bg;blue;brightness;155\a";
    echo -ne "\033]0;"$*"\007"
}

# Ideatron
alias iii="cd $HOME/code/ideatron; ./runme.py; cd -"
export IDEATRON_DATA_DIR=$HOME/life/Ideatron_data

# Notes
source $HOME/academic/pdsnotes/helpers.sh

# Other helpers
source $HOME/.helpers.sh
