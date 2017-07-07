################################################################################
# Common .bashrc                                                               #
#                                                                              #
# You must define PDSRC_ROOT before sourcing this                              #
################################################################################

export CLICOLOR=1;                  # colorize the terminal
export HISTCONTROL=ignoredups       # do not ignore commands starting with space

alias   ll="ls -l"
alias   sb="source ~/.bashrc"
alias grep="grep --color='always'"
alias vimr="vim -R"                 # read-only with vim
alias   mj="make -j"

export PYTHONPATH=$PYTHONPATH:$HOME/pythontestharness/lib

### Git #######################################################################

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

### PETSc #####################################################################

alias cdp='cd $PETSC_DIR'
alias cdk='cd $PETSC_DIR/src/ksp/ksp/examples/tutorials'
alias cdt='cd $PETSC_DIR/src/ts/examples/tutorials'
alias cdm='cd $PETSC_DIR/src/docs/tex/manual'

whichp () {
                                echo -n 'PETSC_ARCH = '; echo $PETSC_ARCH
                                echo -n 'PETSC_DIR  = '; echo $PETSC_DIR
                                echo -n 'PMPI       = '; echo $PMPI
  if [ -n "$SLEPC_DIR" ];  then echo -n 'SLEPC_DIR  = '; echo $SLEPC_DIR;  fi
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
export PDS_PETSC_ARCHNAME="unknown"
alias              setp='setpmaster'
alias        setpmaster='export PETSC_DIR=$HOME/petsc-master;     export PETSC_ARCH=arch-$PDS_PETSC_ARCHNAME-master-double-debug;      export PMPI=$HOME/petsc-master/arch-$PDS_PETSC_ARCHNAME-master-double-debug/bin/mpiexec;         whichp'
alias           setpopt='setpmasteropt'
alias     setpmasteropt='export PETSC_DIR=$HOME/petsc-master;     export PETSC_ARCH=arch-$PDS_PETSC_ARCHNAME-master-double-opt;        export PMPI=$HOME/petsc-master/arch-$PDS_PETSC_ARCHNAME-master-double-opt/bin/mpiexec;           whichp'
alias         setpmaint='export PETSC_DIR=$HOME/petsc-maint;      export PETSC_ARCH=arch-$PDS_PETSC_ARCHNAME-maint-double-debug;       export PMPI=$HOME/petsc-maint/arch-$PDS_PETSC_ARCHNAME-maint-double-debug/bin/mpiexec;           whichp'
alias      setpmaintopt='export PETSC_DIR=$HOME/petsc-maint;      export PETSC_ARCH=arch-$PDS_PETSC_ARCHNAME-maint-double-opt;         export PMPI=$HOME/petsc-maint/arch-$PDS_PETSC_ARCHNAME-maint-double-opt/bin/mpiexec;             whichp'
alias    setpmaintextra='export PETSC_DIR=$HOME/petsc-maint;      export PETSC_ARCH=arch-$PDS_PETSC_ARCHNAME-maint-double-extra-debug; export PMPI=$HOME/petsc-maint/arch-$PDS_PETSC_ARCHNAME-maint-double-extra-debug/bin/mpiexec;     whichp'
alias setpmaintextraopt='export PETSC_DIR=$HOME/petsc-maint;      export PETSC_ARCH=arch-$PDS_PETSC_ARCHNAME-maint-double-extra-opt;   export PMPI=$HOME/petsc-maint/arch-$PDS_PETSC_ARCHNAME-maint-double-extra-opt/bin/mpiexec;       whichp'
alias setpmaintoptextra='setpmaintextraopt'
alias           setpdoc='export PETSC_DIR=$HOME/petsc-docproject; export PETSC_ARCH=arch-$PDS_PETSC_ARCHNAME-docproject-double-debug;  export PMPI=$HOME/petsc-docproject/arch-$PDS_PETSC_ARCHNAME-docproject-double-debug/bin/mpiexec; whichp'
alias      setpmaint128='export PETSC_DIR=$HOME/petsc-maint;      export PETSC_ARCH=arch-$PDS_PETSC_ARCHNAME-float128-debug;           export PMPI=$HOME/petsc-maint/arch-$PDS_PETSC_ARCHNAME-float128-debug/bin/mpiexec;               whichp'
alias   setpmaintopt128='export PETSC_DIR=$HOME/petsc-maint;      export PETSC_ARCH=arch-$PDS_PETSC_ARCHNAME-float128-opt;             export PMPI=$HOME/petsc-maint/arch-$PDS_PETSC_ARCHNAME-float128-opt/bin/mpiexec;                 whichp'
alias   setpmaint128opt='setpmaintopt128'

# A default PTATIN_DIR
export PTATIN_DIR=$HOME/ptatin3d
