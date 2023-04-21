# Encourage to reattach to or create a tmux session if not already running and not superuser
if command -v tmux &> /dev/null && [ -z "$TMUX" ] && [ ${UID} != 0 ]; then
  printf "If not ssh-ing elsewhere, consider reattaching to tmux! Run\n  a\n"
fi

# Language (English for more searchable error messages)
export LC_ALL=en_US.UTF-8

# A common install location
export PATH="$PATH:$HOME/.local/bin"

# Homebrew
case $OSTYPE in
  "darwin"*)
    # Homebrew sbin
    export PATH="/usr/local/sbin:$PATH"

    # Python from Homebrew
    export PATH="/usr/local/opt/python/libexec/bin:$PATH"
    ;;
esac

# Julia
# Download Julia from the web and symlink, e.g.
#     ln -sf /Applications/Julia-1.8.app/Contents/Resources/julia $HOME/code/julia
export JULIA_DIR=$HOME/code/julia
export PATH="$JULIA_DIR/bin:$PATH"

# SciATH
export PYTHONPATH=$PYTHONPATH:$HOME/code/sciath

# PETSc Python utilities
export PYTHONPATH=$PYTHONPATH:$HOME/code/petsc/lib/petsc/bin
export PYTHONPATH=$PYTHONPATH:$HOME/code/petsc_python_helpers

# Paraview
case $OSTYPE in
  "darwin"*)
    export PATH="/Applications/ParaView-5.9.0.app/Contents/MacOS:$PATH"
    export PATH="/Applications/ParaView-5.9.0.app/Contents/bin:$PATH"
    ;;
  "linux-gnu")
    export PATH="$HOME/ParaView-5.10.1-MPI-Linux-Python3.9-x86_64/bin:$PATH"
    ;;
esac

# req2env
export PATH="$HOME/code/req2env:$PATH"

# Cargo (for Alacritty on Linux)
export PATH="$HOME/.cargo/bin:$PATH"

# Delta (Git diffs, for use with Lazygit)
export PATH="$HOME/code/delta:$PATH"

# Location for lazygit executable (Ubuntu package deprecated)
case $OSTYPE in
  "linux-gnu"*)
    export PATH="$HOME/code/lazygit:$PATH"
    ;;
esac

# Music root
case $OSTYPE in
  "darwin"*)
  export MROOT="/Volumes/Stiva/mzk/tunes/music"
  ;;
esac
