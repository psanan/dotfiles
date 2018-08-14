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

alias cdp='cd $PETSC_DIR'
alias cdk='cd $PETSC_DIR/src/ksp/ksp/examples/tutorials'
alias cdd='cd $PETSC_DIR/src/dm/examples/tutorials'

function whichp {
                                echo -n 'PETSC_ARCH = '; echo $PETSC_ARCH
                                echo -n 'PETSC_DIR  = '; echo $PETSC_DIR
                                echo -n 'PMPI       = '; echo $PMPI
  if [ -n "$SLEPC_DIR"  ]; then echo -n 'SLEPC_DIR  = '; echo $SLEPC_DIR;  fi
  if [ -n "$PTATIN_DIR" ]; then echo -n 'PTATIN_DIR = '; echo $PTATIN_DIR; fi
  if [ -n "$PETSC_DEB"  ]; then echo -n 'PETSC_DEB  = '; echo $PETSC_DEB;  fi #for LaMEM
  if [ -n "$PETSC_OPT" ];  then echo -n 'PETSC_OPT  = '; echo $PETSC_OPT;  fi #for LaMEM
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
  setp $1 $2
  export PETSC_DIR=$PETSC_DIR/$PETSC_ARCH-install
  unset PETSC_ARCH
  export PMPI=$PETSC_DIR/bin/mpiexec
}
alias setpmaster="setp master double-debug"
alias setpmasteropt="setp master double-opt"
alias setpmasterextra="setp master double-extra-debug"
alias setpmasterextraopt="setp master double-extra-opt"
alias setpmasteroptextra="setpmasterextraopt"
alias setpmaint="setp maint double-debug"
alias setpmaintopt="setp maint double-opt"
alias setpmaintextra="setp maint double-extra-debug"
alias setpmaintextraopt="setp maint double-extra-opt"
alias setpmaintoptextra="setpmaintextraopt"
alias setpmaintextraoptprefix="setpprefix maint double-extra-opt-prefix"
alias setp3.7="setp 3.7 double-debug"
alias setp3.7opt="setp 3.7 double-opt"
alias setp3.7extra="setp 3.7 double-extra-debug"
alias setp3.7extraopt="setp 3.7 double-extra-opt"
alias setp3.7optextra="setp3.7extraopt"
alias setpdoc="setp docproject double-debug"
alias setpstagbl="setp stagbl double-debug"
alias setpstagblopt="setp stagbl double-opt"
alias setpstagblextra="setp stagbl double-extra-debug"
alias setpstagblextraopt="setp stagbl double-extra-opt"
alias setpmb="setp mb double-debug"
alias setpmbextraopt="setp mb double-extra-opt"

# LaMEM helper (change once PETSc 3.10 comes out, probably to use 3.9)
function lamemhelper {
  export PETSC_DEB=$HOME/petsc-maint/arch-$PDS_PETSC_ARCHNAME-maint-double-extra-debug-prefix-install
  export PETSC_OPT=$HOME/petsc-maint/arch-$PDS_PETSC_ARCHNAME-maint-double-extra-opt-prefix-install
  setpmaintextraoptprefix
  unset PETSC_ARCH
  whichp
}

# A default PTATIN_DIR (mostly for YCM)
export PTATIN_DIR=$HOME/ptatin3d

# A default STAGBL_DIR (mostly for YCM)
export STAGBL_DIR=$HOME/stagbl
alias cds='cd $STAGBL_DIR'
