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
alias   gg="git grep"

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
PS1='\[\e[1;31m\][\[\e[0;33m\]\H \[\e[0;34m\]$STY\[\e[0;0m\] \[\e[1;31m\]\W\[\e[0;36m\]$(__git_ps1 " (%s)")\[\e[1;31m\]]\$\[\e[0m\] '
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

# What currently works to rebuild after a pull
alias remakep='make deletefortranstubs && make allclean && make reconfigure && make && make test'

# Aliases to set common PETSc configurations. We always include the branch name,
# to allow for auxiliary branches in a given directory, and to allow the arch
# alone to identify the build (see petsc_configure*.sh in the
# petsc_configure_helpers repo). These require PDS_PETSC_ARCHNAME to be set
export PDS_PETSC_ARCHNAME=${PDS_PETSC_ARCHNAME:-unknown}
function setp {
# Usage: setp <archmod> <precision-extra-opt-etc>
  local ARCHMOD=$1
  local MOREMODS=$2
  export PETSC_DIR=$HOME/petsc-$ARCHMOD
  export PETSC_ARCH=arch-$PDS_PETSC_ARCHNAME-$ARCHMOD-$MOREMODS
  export PMPI=$PETSC_DIR/$PETSC_ARCH/bin/mpiexec
}
function setpprefix {
  # Usage: setp <archmod> <precision-extra-opt-etc>
  local ARCHMOD=$1
  local MOREMODS=$2
  export PETSC_DIR=$HOME/petsc-$ARCHMOD/arch-$PDS_PETSC_ARCHNAME-$ARCHMOD-$MOREMODS-install
  unset PETSC_ARCH
  export PMPI=$PETSC_DIR/bin/mpiexec
}
alias setpmaster="setp master debug"
alias setpmasteropt="setp master opt"
alias setpmasterextra="setp master extra-debug"
alias setpmasterextraopt="setp master extra-opt"
alias setpmasteroptextra="setpmasterextraopt"
alias setpmaint="setp maint debug"
alias setpmaintopt="setp maint opt"
alias setpmaintextra="setp maint extra-debug"
alias setpmaintextraopt="setp maint extra-opt"
alias setpmaintoptextra="setpmaintextraopt"
alias setpmaintextraoptprefix="setpprefix maint extra-opt-prefix"
alias setp3.7="setp 3.7 debug"
alias setp3.7opt="setp 3.7 opt"
alias setp3.7extra="setp 3.7 extra-debug"
alias setp3.7extraopt="setp 3.7 extra-opt"
alias setp3.7optextra="setp3.7extraopt"
alias setpdoc="setp docproject debug"
alias setpstagbl="setp stagbl debug"
alias setpstagblopt="setp stagbl opt"
alias setpstagblextra="setp stagbl extra-debug"
alias setpstagblextraopt="setp stagbl extra-opt"
alias setpmb="setp mb debug"
alias setpmbextraopt="setp mb extra-opt"

# LaMEM
function lamemhelper {
  # Usage: lamemhelper <archmod>
  local ARCHMOD=${1:-maint}
  export PETSC_DEB=$HOME/petsc-$ARCHMOD/install-$PDS_PETSC_ARCHNAME-$ARCHMOD-extra-debug-prefix
  export PETSC_OPT=$HOME/petsc-$ARCHMOD/install-$PDS_PETSC_ARCHNAME-$ARCHMOD-extra-opt-prefix
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
export PTATIN_DIR=$HOME/ptatin3d

# A default STAGBL_DIR (mostly for YCM)
export STAGBL_DIR=$HOME/stagbl
alias cds='cd $STAGBL_DIR'
