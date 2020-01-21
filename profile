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

