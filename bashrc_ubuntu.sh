#Common
PDSRC_ROOT=$HOME/pdsrc
source $PDSRC_ROOT/bashrc_common.sh

# PETSc
export PDS_PETSC_ARCHNAME=ubuntu

# For SPIDER (corresponds to install hints there)
alias cdm="cd $HOME/magma-ocean/code/evolution/c/src_mpi"
alias setpdirectopt="export PETSC_DIR=$HOME/petsc-double-direct;export PETSC_ARCH=arch-linux2-c-opt;export PMPI=$HOME/petsc-double-direct/arch-linux2-c-opt/bin/mpiexec; whichp;"
alias setpdirect="export PETSC_DIR=$HOME/petsc-double-direct;export PETSC_ARCH=arch-linux2-c-debug;export PMPI=$HOME/petsc-double-direct/arch-linux2-c-debug/bin/mpiexec; whichp;"
alias setpdirectopt128="export PETSC_DIR=$HOME/petsc-quad-direct;export PETSC_ARCH=arch-linux2-c-opt;export PMPI=$HOME/petsc-quad-direct/arch-linux2-c-opt/bin/mpiexec; whichp;"
alias setpdirect128opt=setpdirectopt128
alias setpdirect128="export PETSC_DIR=$HOME/petsc-quad-direct;export PETSC_ARCH=arch-linux2-c-debug;export PMPI=$HOME/petsc-quad-direct/arch-linux2-c-debug/bin/mpiexec; whichp;"

# Paraview
alias paraview44="~/ParaView-4.4.0-Qt4-OpenGL2-Linux-64bit/bin/paraview"
alias paraview54="~/ParaView-5.4.1-Qt5-OpenGL2-MPI-Linux-64bit/bin/paraview"

# added by Anaconda3 installer
export PATH="/home/patrick/anaconda3/bin:$PATH"
