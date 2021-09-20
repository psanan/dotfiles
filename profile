# Reattach to or create a tmux session if not already running and not superuser
if command -v tmux &> /dev/null && [ -z "$TMUX" ] && [ ${UID} != 0 ]
  then
    # Use being on OS X as a (poor) proxy for being on a local machine
    if [[ "$OSTYPE" == "darwin"* ]]; then
      tmux attach -t base || exec tmux new -s base && exit;
    else
      # Just print a hint, since a mistake might leave a remote machine unaccessible
      printf "Consider reattaching to tmux! Run\n  a\n"
    fi
fi

if [[ "$OSTYPE" == "darwin"* ]]; then
  # Homebrew sbin
  export PATH="/usr/local/sbin:$PATH"

  # Python from Homebrew
  export PATH="/usr/local/opt/python/libexec/bin:$PATH"
fi

# Julia
# Download Julia from the web and symlink, e.g.
#     ln -sf /Applications/Julia-1.6.app/Contents/Resources/julia $HOME/code/julia
export JULIA_DIR=$HOME/code/julia
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
export PATH="/Applications/ParaView-5.9.0.app/Contents/MacOS:$PATH"
export PATH="/Applications/ParaView-5.9.0.app/Contents/bin:$PATH"
fi
#if [[ "$OSTYPE" == "linux-gnu" ]]; then
# # add path for Paraview executables here
#fi

# Python env helper
export PATH="$HOME/code/req2env:$PATH"

# cargo
export PATH="$PATH:$HOME/.cargo/bin"
