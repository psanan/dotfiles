################################################################################
# Common .bashrc
#
# You must define PDSRC_ROOT before sourcing this
################################################################################

export HISTIGNORE="&:ls:pwd"        # Ignore duplicates and others in history
export CLICOLOR=1;                  # colorize the terminal

alias ll="ls -l"
alias sb="source ~/.bashrc"
alias grep="grep --color='always'"
alias vimr="vim -R"                 # Read-only with vim

export PYTHONPATH=$PYTHONPATH:$HOME/pythontestharness/lib

### Git #######################################################################

git config --global user.name "Patrick Sanan"
git config --global user.email "patrick.sanan@gmail.com"
git config --global color.status auto
git config --global color.branch auto 
git config --global push.default tracking
git config --global core.editor vim

source $PDSRC_ROOT/git-completion.bash # git tab completion

alias gitlog="git log --graph --pretty=format:\"%h - %an, %ar : %s %d\""
alias   gits="git status --short"
alias  gitst="git status --short --untracked-files=no"

# git prompt
source $PDSRC_ROOT/git-prompt.sh
GIT_PS1_SHOWUPSTREAM=true
GIT_PS1_SHOWDIRTYSTATE=true
GIT_PS1_SHOWSTASHSTATE=true
PS1='\[\e[1;31m\][\[\e[0;33m\]\H: \[\e[1;31m\]\W\[\e[0;36m\]$(__git_ps1 " (%s)")\[\e[1;31m\]]\$\[\e[0m\] '
# Note: Don't forget the \[ \], or you'll have line-wrapping issues

### PETSc #####################################################################

# Quickly jump to PETSC_DIR and various commonly-used subdirectories
alias cdp='cd $PETSC_DIR'
alias cdk='cd $PETSC_DIR/src/ksp/ksp/examples/tutorials'
alias cdt='cd $PETSC_DIR/src/ts/examples/tutorials'
alias cdm='cd $PETSC_DIR/src/docs/tex/manual'

#Alias to print out current values of PETSC_DIR and PETSC_ARCH (note single quotes to prevent immediate expansion)
alias whichp='echo PETSC_ARCH = $PETSC_ARCH; echo PETSC_DIR = $PETSC_DIR; echo PMPI = $PMPI'
alias unsetp='unset PETSC_ARCH; unset PETSC_DIR; unset PMPI;'

#Alias to print out the configure options for the current PETSC_ARCH and PETSC_DIR (won't work for PETSc <3.6)
alias confp='grep CONFIGURE_OPTIONS $PETSC_DIR/$PETSC_ARCH/lib/petsc/conf/petscvariables'

#Aliases to set common PETSc configurations
# We always include the branch name, to allow for auxiliary branches in
#  a given directory, and to allow the arch alone to identify the build
# (see petsc_configure*.sh in the petsc_configure_helpers repo)
# These require PDS_PETSC_ARCHNAME to be set
export PDS_PETSC_ARCHNAME="unknown"
alias              setp='setpmaster'
alias        setpmaster='export PETSC_DIR=$HOME/petsc-master;     export PETSC_ARCH=arch-$PDS_PETSC_ARCHNAME-master-double-debug;      export PMPI=$HOME/petsc-master/bin/petscmpiexec;                              whichp'
alias           setpopt='export PETSC_DIR=$HOME/petsc-master;     export PETSC_ARCH=arch-$PDS_PETSC_ARCHNAME-master-double-opt;        export PMPI=$HOME/petsc/bin/petscmpiexec;                                     whichp'
alias         setpmaint='export PETSC_DIR=$HOME/petsc-maint;      export PETSC_ARCH=arch-$PDS_PETSC_ARCHNAME-maint-double-debug;       export PMPI=$HOME/petsc-maint/bin/petscmpiexec;                               whichp'
alias      setpmaintopt='export PETSC_DIR=$HOME/petsc-maint;      export PETSC_ARCH=arch-$PDS_PETSC_ARCHNAME-maint-double-opt;         export PMPI=$HOME/petsc-maint/bin/petscmpiexec;                               whichp'
alias    setpmaintextra='export PETSC_DIR=$HOME/petsc-maint;      export PETSC_ARCH=arch-$PDS_PETSC_ARCHNAME-maint-double-extra-debug; export PMPI=$HOME/petsc-maint/bin/petscmpiexec;                               whichp'
alias setpmaintextraopt='export PETSC_DIR=$HOME/petsc-maint;      export PETSC_ARCH=arch-$PDS_PETSC_ARCHNAME-maint-double-extra-opt;   export PMPI=$HOME/petsc-maint/bin/petscmpiexec;                               whichp'
alias setpmaintoptextra='setpmaintextraopt'
alias           setpdoc='export PETSC_DIR=$HOME/petsc-docproject; export PETSC_ARCH=arch-$PDS_PETSC_ARCHNAME-docproject-double-debug;  export PMPI=$HOME/petsc-docproject/bin/petscmpiexec;                          whichp'
alias      setpmaint128='export PETSC_DIR=$HOME/petsc-maint;      export PETSC_ARCH=$PDS_PETSC_ARCHNAME-float128-debug;                export PMPI=$HOME/petsc-maint/$PDS_PETSC_ARCHNAME-float128-debug/bin/mpiexec; whichp'
alias   setpmaintopt128='export PETSC_DIR=$HOME/petsc-maint;      export PETSC_ARCH=$PDS_PETSC_ARCHNAME-float128-opt;                  export PMPI=$HOME/petsc-maint/$PDS_PETSC_ARCHNAME-float128-opt/bin/mpiexec;   whichp'
alias   setpmaint128opt='setpmaintopt128'

# A default PTATIN_DIR
export PTATIN_DIR=$HOME/ptatin3d
