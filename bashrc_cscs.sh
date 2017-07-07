# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

#Common
PDSRC_ROOT=~/pdsrc
source $PDSRC_ROOT/bashrc_common.sh
################################################################################

# PETSc (overrides the usual!)
alias setpmaintopt="export PETSC_DIR=/users/psanan/petsc-maint; export PETSC_ARCH=arch-cray-xc30-daint;  whichp; module load PrgEnv-cray; echo Note: modules changed!"
alias setpmaintoptgnu="export PETSC_DIR=/users/psanan/petsc-maint; export PETSC_ARCH=arch-gnu-xc30-daint; whichp; module unload PrgEnv-cray; module load PrgEnv-gnu; module load cudatoolkit; echo \"Note: modules changed!\""
alias setp="echo \"Not defined. Maybe you wanted\";echo \"  setpmaintopt\""
alias setpopt="echo \"Not defined. Maybe you wanted\";echo \"  setpmaintopt\""
alias setpmaint="echo \"Not defined. Maybe you wanted\";echo \"  setpmaintopt\""

# Shortcut to watch my jobs
alias ww="watch -n 0.5 squeue -u psanan"
alias wwi="watch -n 0.5 squeue -u psanan --sort=i" #order by job id

# cd to scratch dir
alias cds="cd $SCRATCH"

# color ls always
alias ls="ls --color='always'"

# A default PTATIN_DIR
export PTATIN_DIR=$SCRATCH/ptatin3d
export PTATIN_DIR_OLD=$SCRATCH/ptatin3d-oldavx

# Hints on things we often do
printf "You may want to doit\n"
doit () {
  module load daint-gpu cudatoolkit
  setpmaintopt
}
type doit
