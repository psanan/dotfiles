################################################################################
# Common .bashrc                                                               #
#                                                                              #
# You must define PDSRC_ROOT before sourcing this                              #
################################################################################

export CLICOLOR=1;                  # colorize the terminal
export HISTCONTROL=ignoredups       # include commands starting with a space

alias   ll="ls -l"
alias   sb="source $HOME/.bash_profile"
alias vimr="vim -R"                 # read-only with vim
alias   mj="make -j8"               # -j causes forking problems sometimes

export PYTHONPATH=$PYTHONPATH:$HOME/pythontestharness/lib

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
PS1='\[\e[1;31m\][\[\e[0;33m\]\H: \[\e[1;31m\]\W\[\e[0;36m\]$(__git_ps1 " (%s)")\[\e[1;31m\]]\$\[\e[0m\] '
# Note: Don't forget the \[ \], or you'll have line-wrapping issues

### PETSc ######################################################################

alias cdp='cd $PETSC_DIR'
alias cdk='cd $PETSC_DIR/src/ksp/ksp/examples/tutorials'
alias cdt='cd $PETSC_DIR/src/ts/examples/tutorials'

function whichp {
                                echo -n 'PETSC_ARCH = '; echo $PETSC_ARCH
                                echo -n 'PETSC_DIR  = '; echo $PETSC_DIR
                                echo -n 'PMPI       = '; echo $PMPI
  if [ -n "$SLEPC_DIR"  ]; then echo -n 'SLEPC_DIR  = '; echo $SLEPC_DIR;  fi
  if [ -n "$PTATIN_DIR" ]; then echo -n 'PTATIN_DIR = '; echo $PTATIN_DIR; fi
}

alias unsetp='unset PETSC_ARCH; unset PETSC_DIR; unset PMPI;'

# Print out the configure options for the current PETSC_ARCH and PETSC_DIR (won't work for PETSc <3.6)
alias confp='grep CONFIGURE_OPTIONS $PETSC_DIR/$PETSC_ARCH/lib/petsc/conf/petscvariables'

#Aliases to set common PETSc configurations
# We always include the branch name, to allow for auxiliary branches in
#  a given directory, and to allow the arch alone to identify the build
# (see petsc_configure*.sh in the petsc_configure_helpers repo)
# These require PDS_PETSC_ARCHNAME to be set
export PDS_PETSC_ARCHNAME=${PDS_PETSC_ARCHNAME:-unknown}
# Usage: setp <archmod> <precision-extra-opt-etc>
function setp {
  local ARCHMOD=$1
  local MOREMODS=$2
  export PETSC_DIR=$HOME/petsc-$ARCHMOD
  export PETSC_ARCH=arch-$PDS_PETSC_ARCHNAME-$ARCHMOD-$MOREMODS
  export PMPI=$PETSC_DIR/$PETSC_ARCH/bin/mpiexec
  whichp
}
alias setpmaster="setp master double-debug"
alias setpmasteropt="setp master double-opt"
alias setpmaster128="setp master float128-debug"
alias setpmaster128opt="setp master float128-opt"
alias setpmasteropt128="setpmaster128opt"
alias setpmasterextra="setp master double-extra-debug"
alias setpmasterextraopt="setp master double-extra-opt"
alias setpmasteroptextra="setpmasterextraopt"
alias setpmaint="setp maint double-debug"
alias setpmaintopt="setp maint double-opt"
alias setpmaint128="setp maint float128-debug"
alias setpmaint128opt="setp maint float128-opt"
alias setpmaintopt128="setpmaint128opt"
alias setpmaintextra="setp maint double-extra-debug"
alias setpmaintsingleextra="setp maint single-extra-debug"
alias setpmaintextrasingle="setpmaintsingleextra"
alias setpmaintsingleextraopt="setp maint single-extra-opt"
alias setpmaintsingleoptextra="setpmaintsingleextraopt"
alias setpmaintextrasingleopt="setpmaintsingleextraopt"
alias setpmaintoptextrasingle="setpmaintsingleextraopt"
alias setpmaintextraopt="setp maint double-extra-opt"
alias setpmaintoptextra="setpmaintextraopt"
alias setp3.7="setp 3.7 double-debug"
alias setp3.7opt="setp 3.7 double-opt"
alias setp3.7128="setp 3.7 float128-debug"
alias setp3.7128opt="setp 3.7 float128-opt"
alias setp3.7opt128="setp3.7128opt"
alias setp3.7extra="setp 3.7 double-extra-debug"
alias setp3.7extraopt="setp 3.7 double-extra-opt"
alias setp3.7optextra="setp3.7extraopt"
alias setpdoc="setp docproject double-debug"
alias setpstagblextra="setp stagbl double-extra-debug"
alias setpstagblextraopt="setp stagbl double-extra-opt"

# A default PTATIN_DIR
export PTATIN_DIR=$HOME/ptatin3d
