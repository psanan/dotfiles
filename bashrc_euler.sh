PDSRC_ROOT=~/pdsrc
source $PDSRC_ROOT/bashrc_common.sh
################################################################################

# Watch your jobs in the queue
alias ww='watch -n 0.5 bjobs'

# PETSc (overrides the usual)
alias setpmaintopt="export PETSC_DIR=/cluster/home/pasanan/petsc-maint; export PETSC_ARCH=arch-euler; whichp; echo \"  module purge; module load python/2.7.6; module load openblas; module load gcc; module load open_mpi; module load hdf5\""
alias setpmaintoptextra="export PETSC_DIR=/cluster/home/pasanan/petsc-maint; export PETSC_ARCH=arch-euler-extra; whichp; echo \"  module purge; module load python/2.7.6; module load openblas; module load gcc; module load open_mpi; module load hdf5\""
alias setpmaintextraopt=setpmaintoptextra
alias setpmaintintelopt="export PETSC_DIR=/cluster/home/pasanan/petsc-maint; export PETSC_ARCH=arch-euler-intel; whichp; echo \"  module purge; module load python/2.7.6;  module load intel; module load open_mpi; module load hdf5\""
alias setpmaintoptintel=setpmaintintelopt
alias setp="echo \"Not defined. Maybe you wanted\";echo \"  setpmaintopt\""
alias setpopt="echo \"Not defined. Maybe you wanted\";echo \"  setpmaintopt\""
alias setpmaint="echo \"Not defined. Maybe you wanted\";echo \"  setpmaintopt\""
alias setppardiso="export PETSC_DIR=/cluster/home/pasanan/petsc-pardiso; export PETSC_ARCH=arch-euler-pardiso;  whichp; echo \"  module purge; module load python/2.7.6; module load openblas; module load gcc; module load open_mpi\""

alias cds="cd $SCRATCH"

export ILDL_PLATFORM=GNU64
