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

# For the new daint, load this (since this is the only part I even have an allocation on)
# should add a check for if we are actually on daint...
module load daint-gpu

# A default PTATIN_DIR
export PTATIN_DIR=$SCRATCH/ptatin3d

# Load stuff we're using (not the best practice, but whatever)
module load cudatoolkit
#setpmaintopt
