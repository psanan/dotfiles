# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

### Location for additional scripts ############################################
PDSRC_ROOT=${PDSRC_ROOT:-$HOME/util/pdsrc}

### Terminal ###################################################################
export CLICOLOR=1;                  # colorize the terminal
export HISTCONTROL=ignoredups       # include commands starting with a space

### Aliases ####################################################################
alias   ll="ls -l"
alias   sb="source $HOME/.bash_profile"
alias vimr="vim -R"                 # read-only with vim
alias   mj="make -j8"               # -j causes forking problems sometimes
alias   gg="git grep"
alias  dus="du -sh * | sort -hr"    # sorted local file/directory sizes

### Git ########################################################################
git config --global user.name "Patrick Sanan"
git config --global user.email "patrick.sanan@gmail.com"
git config --global color.status auto
git config --global color.branch auto
git config --global push.default tracking
git config --global core.editor vim

source $PDSRC_ROOT/git-completion.bash

alias gitlog="git log --graph --pretty=format:\"%h - %an, %ar : %s %d\""
alias   gits="git status --short"
alias  gitst="git status --short --untracked-files=no"

source $PDSRC_ROOT/git-prompt.sh
GIT_PS1_SHOWUPSTREAM=true
GIT_PS1_SHOWDIRTYSTATE=true
GIT_PS1_SHOWSTASHSTATE=true
GIT_PS1_SHOWUNTRACKEDFILES=true
PS1='\[\e[1;31m\][\[\e[0;33m\]\H \[\e[0;34m\]$STY\[\e[0;0m\] \[\e[1;31m\]\W\[\e[0;36m\]$(__git_ps1 " (%s)")\[\e[1;31m\]]\$\[\e[0m\] '
PS1_LOCAL='\[\e[1;31m\][\[\e[1;31m\]\W\[\e[0;36m\]$(__git_ps1 " (%s)")\[\e[1;31m\]]\$\[\e[0m\] '
# Note: Don't forget the \[ \], or you'll have line-wrapping issues
# Note: $STY is for use with GNU Screen (screen -S sessionName)

### PETSc ######################################################################
alias cdp='cd $PETSC_DIR'                                   # note single quotes
alias cdk='cd $PETSC_DIR/src/ksp/ksp/examples/tutorials'

function whichp {
                                echo -n 'PETSC_ARCH = '; echo $PETSC_ARCH
                                echo -n 'PETSC_DIR  = '; echo $PETSC_DIR
                                echo -n 'PMPI       = '; echo $PMPI
  if [ -n "$SLEPC_DIR"  ]; then echo -n 'SLEPC_DIR  = '; echo $SLEPC_DIR;  fi
  if [ -n "$PTATIN_DIR" ]; then echo -n 'PTATIN_DIR = '; echo $PTATIN_DIR; fi
  if [ -n "$LAMEM_DIR"  ]; then echo -n 'LAMEM_DIR  = '; echo $LAMEM_DIR;  fi
  if [ -n "$PETSC_DEB"  ]; then echo -n 'PETSC_DEB  = '; echo $PETSC_DEB;  fi #for LaMEM
  if [ -n "$PETSC_OPT"  ]; then echo -n 'PETSC_OPT  = '; echo $PETSC_OPT;  fi #for LaMEM
}

alias unsetp='unset PETSC_ARCH; unset PETSC_DIR; unset PMPI;'

# Print out the configure options for the current PETSC_ARCH and PETSC_DIR (won't work for PETSc <3.6)
alias confp='grep CONFIGURE_OPTIONS $PETSC_DIR/$PETSC_ARCH/lib/petsc/conf/petscvariables'

# Aliases to set common PETSc configurations. We always include the branch name,
# to allow for multiple variants in a given directory (see petsc_configure*.sh in the
# petsc_configure_helpers repo).
# Example: "setp 3.7 extra-opt" -->
#          PETSC_ARCH=arch-3.7-extra-opt, PETSC_DIR=$HOME/code/petsc-3.7
function setp {
# Usage: setp <archmod> <precision-extra-opt-etc>
  local ARCHMOD=$1
  local MOREMODS=$2
  export PETSC_DIR=$HOME/code/petsc-$ARCHMOD
  export PETSC_ARCH=arch-$ARCHMOD-$MOREMODS
  export PMPI=$PETSC_DIR/$PETSC_ARCH/bin/mpiexec
}
function setpprefix {
  # Usage: setp <archmod> <precision-extra-opt-etc>
  local ARCHMOD=$1
  local MOREMODS=$2
  export PETSC_DIR=$HOME/code/petsc-$ARCHMOD/arch-$ARCHMOD-$MOREMODS-install
  unset PETSC_ARCH
  export PMPI=$PETSC_DIR/bin/mpiexec
}

# LaMEM
function lamemhelper {
  # Usage: lamemhelper <archmod>
  local ARCHMOD=${1:-maint}
  export PETSC_DEB=$HOME/code/petsc-$ARCHMOD/install-$ARCHMOD-extra-debug-prefix
  export PETSC_OPT=$HOME/code/petsc-$ARCHMOD/install-$ARCHMOD-extra-opt-prefix
  export PETSC_DIR=$PETSC_OPT
  export PMPI=$PETSC_OPT/bin/mpiexec
  unset PETSC_ARCH
  export LAMEM_DIR=$HOME/lamem-$ARCHMOD
  whichp
}
alias cdl='cd $LAMEM_DIR'
alias lamemtest='cd $LAMEM_DIR/input_models/BuildInSetups; ../../bin/opt/LaMEM -ParamFile FallingBlock_DirectSolver.dat'
alias lamemtest2='cd $LAMEM_DIR/input_models/BuildInSetups; $PMPI -np 2 ../../bin/opt/LaMEM -ParamFile FallingBlock_DirectSolver.dat'

# A default PTATIN_DIR (mostly for YCM)
export PTATIN_DIR=$HOME/code/ptatin3d

# A default STAGBL_DIR (mostly for YCM)
export STAGBL_DIR=$HOME/code/stagbl
alias cds='cd $STAGBL_DIR'

### Linux-specific commands ####################################################
if [[ "$OSTYPE" == "linux-gnu" ]]; then

# For SPIDER (corresponds to install hints there)
alias setpdirectopt="export PETSC_DIR=$HOME/code/petsc-double-direct;export PETSC_ARCH=arch-linux2-c-opt;export PMPI=$HOME/code/petsc-double-direct/arch-linux2-c-opt/bin/mpiexec; whichp;"
alias setpdirect="export PETSC_DIR=$HOME/code/petsc-double-direct;export PETSC_ARCH=arch-linux2-c-debug;export PMPI=$HOME/code/petsc-double-direct/arch-linux2-c-debug/bin/mpiexec; whichp;"
alias setpdirectopt128="export PETSC_DIR=$HOME/code/petsc-quad-direct;export PETSC_ARCH=arch-linux2-c-opt;export PMPI=$HOME/code/petsc-quad-direct/arch-linux2-c-opt/bin/mpiexec; whichp;"
alias setpdirect128opt=setpdirectopt128
alias setpdirect128="export PETSC_DIR=$HOME/code/petsc-quad-direct;export PETSC_ARCH=arch-linux2-c-debug;export PMPI=$HOME/code/petsc-quad-direct/arch-linux2-c-debug/bin/mpiexec; whichp;"

# Paraview
alias paraview44="~/ParaView-4.4.0-Qt4-OpenGL2-Linux-64bit/bin/paraview"
alias paraview54="~/ParaView-5.4.1-Qt5-OpenGL2-MPI-Linux-64bit/bin/paraview"
alias paraview56="~/ParaView-5.6.0-MPI-Linux-64bit/bin/paraview"
#alias paraview=paraview56
fi

### OS X-specific commands ####################################################
if [[ "$OSTYPE" == "darwin"* ]]; then

# To use MacVim. This is a kludge
export VIMRUNTIME=/Applications/MacVim.app/Contents/Resources/vim/runtime

# Use prompt without hostname
PS1=$PS1_LOCAL

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

fi
