# For remote machines, we may have another bashrc which sources this

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

### Location for additional scripts ############################################
dotfiles_root=$HOME/util/dotfiles

### Terminal ###################################################################
export CLICOLOR=1;
export HISTCONTROL=ignoredups
set +o histexpand                      # Turn off history expansion (allows "!")
set -o vi

### Aliases and helper functions ###############################################
alias a="tmux attach -t base || exec tmux new -s base"
alias iii="$HOME/code/ideatron/run.py -d $HOME/docs/ideatron_local"
alias jn="jupyter notebook"
alias ll="ls -l"
alias mj="make -j8"
alias sb="source $HOME/.bashrc"
alias vimr="vim -R"
alias cdn="cd $HOME/notes/"
alias cds="cd $HOME/Downloads"        # Scratch directory. Override on clusters.
alias cdw="cd $HOME/mzk/current_projects/prism/installation"
alias dus="du -sh * | sort -h"
alias news="newsboat"
alias plab="ipython --no-confirm-exit --matplotlib -i $HOME/code/petsc_python_helpers/ipython_setup.py"
alias tunes="mpd --kill; mpd && ncmpcpp"
alias week="vim +$ ~/notes/goals/$(date +%Y).md"
if [[ "$OSTYPE" == "linux-gnu" ]]; then
  alias gsed="sed"
  alias pbcopy="xsel -ib"
  alias pbpaste="xsel --clipboard"
fi
alias wn="~/notes/lists/whatnext.py"

function j {
  vim $($HOME/notes/j_today.py)
}

function l {
  vim "$HOME/notes/lists/$1.md"
}

function t {
  d=`date +%Y.%m.%d`
  note_path_stem="$HOME/notes/tech/$d"
  note_path=$(printf '%s.md' "$note_path_stem")
  i=0
  while [ -f "$note_path" ]
  do
    ((i++))
    note_path=$(printf '%s_%d.md' "$note_path_stem" $i)
  done
  printf '# Untitled Tech Note\n' >> $note_path
  printf '  #tag1 #tag2\n'        >> $note_path
  vim $note_path
}

function sshf {
  target=${1:-pdsbox}
  port_remote=${2:-8888}
  port_local=$port_remote
  ssh -L $port_remote:localhost:$port_local $target
}

# It might also be convenient to define an ssh alias which
# automatically starts or reattachs to a default-named tmux session
function ssht {
  target=${1:-pdsbox}
  ssh $target
}

function last() {
  # print out last command [matching arg], useful to save to file
  # e.g "last vim" prints the last command including "vim"
  fc -ln "$1" "$1"
}

### ccache #####################################################################
export CCACHE_MAXSIZE=15G

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

source $dotfiles_root/git-completion.bash
source $dotfiles_root/git-prompt.sh
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
if [[ "$OSTYPE" == "darwin"* ]]; then
  PS1=$PS1_LOCAL
else
  PS1=$PS1_REMOTE
fi

### fzf ########################################################################
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

### PETSc and related software #################################################
alias cdp='cd $PETSC_DIR'                                   # note single quotes
alias cdk='cd $PETSC_DIR/src/ksp/ksp/tutorials'
alias cdd='cd $PETSC_DIR/src/dm/impls/stag/tutorials'

export CLEAN_MPICH=$HOME/code/petsc/arch-mpich-only/bin/mpiexec

alias confp='grep CONFIGURE_OPTIONS $PETSC_DIR/$PETSC_ARCH/lib/petsc/conf/petscvariables'

function setp {
  export PETSC_DIR=${1:-$HOME/code/petsc}
  export PETSC_ARCH=${2:-arch-extra-debug}
  export PETSC_MPIEXEC=$PETSC_DIR/lib/petsc/bin/petscmpiexec
}

function setphere {
  # Example: cd /some/petsc/dir && setphere arch-foo
  setp $PWD ${1%/} # strip any trailing slash, so you can tab-complete
}

alias unsetp='unset PETSC_ARCH PETSC_DIR PETSC_MPIEXEC'

function whichp {
  printf 'PETSC_ARCH    = %s\n' '$PETSC_ARCH'
  printf 'PETSC_DIR     = %s\n' '$PETSC_DIR'
  printf 'PETSC_MPIEXEC = %s\n' '$PETSC_MPIEXEC'
}

################################################################################
if [[ "$OSTYPE" == "darwin"* ]]; then

# Use "local prompt"
PS1=$PS1_LOCAL

fi # OS X
