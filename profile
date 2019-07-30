# MacPorts
if [[ "$OSTYPE" == "darwin"* ]]; then
export PATH="/opt/local/bin:/opt/local/sbin:$PATH"
fi

# PETSc Python utilities (from master)
export PYTHONPATH=$PYTHONPATH:$HOME/code/petsc/lib/petsc/bin
export PYTHONPATH=$PYTHONPATH:$HOME/code/petsc_python_helpers

# Python Test Harness
export PYTHONPATH=$PYTHONPATH:$HOME/code/sciath/
export PYTHONPATH=$PYTHONPATH:$HOME/code/pythonTestHarness/lib # remove once SciATH public, and update all projects

# stice-gg
export PATH="$HOME/code/stice-gg:$PATH"

# hack to find things that pip installs from Macports
export PATH=$PATH:/opt/local/Library/Frameworks/Python.framework/Versions/3.7/bin/

# Conda
export PATH="$HOME/miniconda3/bin:$PATH"
export CONDA_CHANGEPS1=false
