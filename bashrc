# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# Note: for some remote machines, we may have another bashrc, which sources this

### Location for additional scripts ############################################
PSANAN_RC_ROOT=${PSANAN_RC_ROOT:-$HOME/util/rc}

### Terminal ###################################################################
export CLICOLOR=1;                  # colorize the terminal
export HISTCONTROL=ignoredups       # include commands starting with a space
set +o histexpand                   # Turn off history expansion (allows "!"):

### Aliases and helper functions ###############################################
alias jn="jupyter notebook"
alias ll="ls -l"
alias mj="make -j8"
alias sb="source $HOME/.bashrc"
alias vi="echo use vim"
alias vimr="vim -R"
alias cdn="cd $HOME/work/notes/notes"
alias cds="cd $HOME/Downloads"  # a scratch directory. Override on clusters.
alias cdt="cd $HOME/work/notes/tech"
alias dus="du -sh * | sort -hr"
alias news="newsboat"
alias plab="ipython --no-confirm-exit --matplotlib -i $HOME/code/petsc_python_helpers/ipython_setup.py"
alias split="tmux split -h"

# Experiment: use these instead of OS X specific link clicking
# (if useful, change things to have one file per year, probably, and just get the year automatically0
alias week="vim +$ ~/docs/goals/2021/Q3.md"
alias year="vim ~/docs/goals/2021/yearly.md"
alias vokab="vim ~/docs/languages/deutsch/Vokabular.txt"
alias mzk="vim ~/mzk/tunes/lists/music_to_find.txt"
function pn {
  vim ~/work/projects/$1/README.md
}

function t {
  d=`date +%Y.%m.%d`
  note_path_stem="$HOME/work/notes/tech/$d"
  note_path=$(printf '%s.md' "$note_path_stem")
  i=0
  while [ -f "$note_path" ]
  do
    ((i++))
    note_path=$(printf '%s_%d.md' "$note_path_stem" $i)
  done
  printf '# Untitled Tech Note\n' >> $note_path
  printf '{tag1} {tag2}\n'        >> $note_path
  vim $note_path
}

### ccache #####################################################################
export CCACHE_MAXSIZE=15G
# f90cache doesn't have this so you'd have to supply e.g -M 15G

### Git ########################################################################
git config --global user.name "Patrick Sanan"
git config --global user.email "patrick.sanan@gmail.com"
git config --global color.status auto
git config --global color.branch auto
git config --global push.default tracking
git config --global core.editor vim
git config --global pull.ff only
git config --global init.defaultBranch main

alias gitl="git log --graph --pretty=format:\"%h - %an, %ar : %s %d\""
alias gits="git status --short"
alias gitst="git status --short --untracked-files=no"
alias gitbu='name=$(git rev-parse --abbrev-ref HEAD)-backup-$(date -u +"%Y%m%dT%H%M%SZ") && echo "$name" && git branch $name'
alias gitf="git commit --amend --no-edit"
alias gg="git grep -i"
alias lg="lazygit"

source $PSANAN_RC_ROOT/git-completion.bash
source $PSANAN_RC_ROOT/git-prompt.sh
GIT_PS1_SHOWUPSTREAM=true
GIT_PS1_SHOWDIRTYSTATE=true
GIT_PS1_SHOWSTASHSTATE=true
GIT_PS1_SHOWUNTRACKEDFILES=true

# Use e.g. git clone $GITHUB:user/repo
export GITHUB="git@github.com"
export GITLAB="git@gitlab.com"
export BITBUCKET="git@bitbucket.org"

### Prompt #####################################################################
# addsp adds a space and (optional) brackets to non-empty strings
# Don't forget the \[ \], or you'll have line-wrapping issues
function addsp { if [[ -z "$1" ]]; then echo ""; else echo "$2$1$3 "; fi; }
PS1_OPEN="\[\e[1;31m\]["
PS1_CLOSE="\[\e[1;31m\]]$\[\e[0m\] "
PS1_BODY='\[\e[0;95m\]$(addsp "$PETSC_ARCH" "(" ")")\[\e[1;31m\]\W\[\e[0;36m\]$(__git_ps1 " (%s)")'
PS1_HOST="\[\e[0;33m\]\H "
PS1_LOCAL="$PS1_OPEN$PS1_BODY$PS1_CLOSE"
PS1_REMOTE="$PS1_OPEN$PS1_HOST$PS1_BODY$PS1_CLOSE"
PS1=$PS1_REMOTE

### fzf ########################################################################
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

### PETSc and related software #################################################
alias cdp='cd $PETSC_DIR'                                   # note single quotes
alias cdk='cd $PETSC_DIR/src/ksp/ksp/tutorials'
alias cdd='cd $PETSC_DIR/src/dm/impls/stag/tutorials'

export CLEAN_MPICH=$HOME/code/petsc/arch-mpich-only/bin/mpiexec

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

alias unsetp='unset PETSC_ARCH PETSC_DIR PMPI PETSC_DEB PETSC_OPT'
alias confp='grep CONFIGURE_OPTIONS $PETSC_DIR/$PETSC_ARCH/lib/petsc/conf/petscvariables'

function setphere {
  # Usage: setphere <petsc-arch>
  # Example: cd /some/petsc/dir && setphere arch-foo-bar
  export PETSC_DIR=$PWD
  export PETSC_ARCH=${1%/} # strip any trailing slash, so you can tab-complete
  export PMPI=$PETSC_DIR/lib/petsc/bin/petscmpiexec
}

# LaMEM
function lamemhelper {
  # Usage: lamemhelper <archmod>
  local ARCHMOD=${1:-maint}
  export PETSC_DEB=$HOME/code/petsc-$ARCHMOD/arch-$ARCHMOD-extra-debug-install
  export PETSC_OPT=$HOME/code/petsc-$ARCHMOD/arch-$ARCHMOD-extra-opt-install
  export PETSC_DIR=$PETSC_OPT
  export PMPI=$PETSC_OPT/bin/mpiexec
  unset PETSC_ARCH
  export LAMEM_DIR=$HOME/code/lamem-$ARCHMOD
  whichp
}
alias lamemtest='cd $LAMEM_DIR/input_models/BuildInSetups; ../../bin/opt/LaMEM -ParamFile FallingBlock_DirectSolver.dat'
alias lamemtest2='cd $LAMEM_DIR/input_models/BuildInSetups; $PMPI -np 2 ../../bin/opt/LaMEM -ParamFile FallingBlock_DirectSolver.dat'

### Linux-specific commands ####################################################
if [[ "$OSTYPE" == "linux-gnu" ]]; then

alias gsed="sed"

# MATLAB
alias matlab="/usr/local/MATLAB/R2019a/bin/matlab"

fi # Linux

### OS X-specific commands ####################################################
if [[ "$OSTYPE" == "darwin"* ]]; then

# HAAAACK
export MACOSX_DEPLOYMENT_TARGET=11.3

# Use "local prompt"
PS1=$PS1_LOCAL

# Ideatron
alias iii="$HOME/code/ideatron/run.py -d $HOME/docs/ideatron_local"

# No Homebrew telemetry
export HOMEBREW_NO_ANALYTICS=1

# Helpers
source $HOME/.helpers.sh

fi # OS X
