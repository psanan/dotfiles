# MacPorts
if [[ "$OSTYPE" == "darwin"* ]]; then
export PATH="/opt/local/bin:/opt/local/sbin:$PATH"
fi

# Julia
export JULIA_DIR=$HOME/code/julia  # symlink this to a specific version
export PATH="$JULIA_DIR/bin:$PATH"


# SciATH
export PYTHONPATH=$PYTHONPATH:$HOME/code/sciath

# PETSc Python utilities
export PYTHONPATH=$PYTHONPATH:$HOME/code/petsc/lib/petsc/bin
export PYTHONPATH=$PYTHONPATH:$HOME/code/petsc_python_helpers

# Rift-o-mat DMStag/Python utilities (note that this overrides PetscBinaryIO.py!)
export PYTHONPATH=$HOME/code/rift-o-mat/utils:$PYTHONPATH

# Paraview
if [[ "$OSTYPE" == "darwin"* ]]; then
export PATH="/Applications/ParaView-5.8.0.app/Contents/MacOS/:$PATH"
fi
if [[ "$OSTYPE" == "linux-gnu" ]]; then
export PATH="~/ParaView-5.6.0-MPI-Linux-64bit/bin/paraview:$PATH"
fi
