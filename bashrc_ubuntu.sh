PDSRC_ROOT=$HOME/util/pdsrc
source $PDSRC_ROOT/bashrc_common.sh
################################################################################

# PETSc
export PDS_PETSC_ARCHNAME=ubuntu

# For SPIDER (corresponds to install hints there)
alias setpdirectopt="export PETSC_DIR=$HOME/code/petsc-double-direct;export PETSC_ARCH=arch-linux2-c-opt;export PMPI=$HOME/code/petsc-double-direct/arch-linux2-c-opt/bin/mpiexec; whichp;"
alias setpdirect="export PETSC_DIR=$HOME/code/petsc-double-direct;export PETSC_ARCH=arch-linux2-c-debug;export PMPI=$HOME/code/petsc-double-direct/arch-linux2-c-debug/bin/mpiexec; whichp;"
alias setpdirectopt128="export PETSC_DIR=$HOME/code/petsc-quad-direct;export PETSC_ARCH=arch-linux2-c-opt;export PMPI=$HOME/code/petsc-quad-direct/arch-linux2-c-opt/bin/mpiexec; whichp;"
alias setpdirect128opt=setpdirectopt128
alias setpdirect128="export PETSC_DIR=$HOME/code/petsc-quad-direct;export PETSC_ARCH=arch-linux2-c-debug;export PMPI=$HOME/code/petsc-quad-direct/arch-linux2-c-debug/bin/mpiexec; whichp;"

# Paraview
alias paraview44="~/ParaView-4.4.0-Qt4-OpenGL2-Linux-64bit/bin/paraview"
alias paraview54="~/ParaView-5.4.1-Qt5-OpenGL2-MPI-Linux-64bit/bin/paraview"
alias paraview56="~/ParaView-5.6.0-MPI-Linux-64bit/bin/paraview"
alias paraview=paraview56

# added by Anaconda3 installer
export PATH="$HOME/anaconda3/bin:$PATH"
