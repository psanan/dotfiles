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
alias setpmaintopt="export PETSC_DIR=/users/psanan/petsc-maint; export PETSC_ARCH=arch-cray-xc50-daint;  whichp; module load PrgEnv-cray; echo Note: modules changed!"
alias setpmaintoptgnu="export PETSC_DIR=/users/psanan/petsc-maint; export PETSC_ARCH=arch-gnu-xc50-daint; whichp; module unload PrgEnv-cray; module load PrgEnv-gnu; module load cudatoolkit; echo \"Note: modules changed!\""
alias setp3.7opt="export PETSC_DIR=/users/psanan/petsc-3.7; export PETSC_ARCH=arch-cray-xc50-daint;  whichp; module load PrgEnv-cray; echo Note: modules changed!"
alias setpsalvus="export PETSC_DIR=/users/psanan/petsc-maint; export PETSC_ARCH=arch-gnu-xc50-daint-double-extra; whichp; module unload PrgEnv-cray; module load PrgEnv-gnu cray-trilinos cray-netcdf-hdf5parallel cray-hdf5-parallel; echo \"Note: modules changed!\""

# Shortcut to watch my jobs
alias ww="watch -n 0.5 squeue -u psanan"
alias wwi="watch -n 0.5 squeue -u psanan --sort=i" #order by job id

# cd to scratch dir
alias cds="cd $SCRATCH"

# color ls always
alias ls="ls --color='always'"

# A default PTATIN_DIR
export PTATIN_DIR=$SCRATCH/ptatin3d
export PTATIN_DIR_PERF=$SCRATCH/ptatin3d-perf
export PTATIN_DIR_LAETI=$SCRATCH/ptatin3d-laeti

# A default HPGMG_DIR
export HPGMG_DIR=$SCRATCH/hpgmg
export HPGMG_CUDA_DIR=$SCRATCH/hpgmg-cuda

# Hints on things we often do
printf "You may want to doit\n"
doit () {
  module load daint-gpu cudatoolkit
  setp3.7opt
}
type doit
