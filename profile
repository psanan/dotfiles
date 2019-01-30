# MacPorts
if [[ "$OSTYPE" == "darwin"* ]]; then
export PATH="/opt/local/bin:/opt/local/sbin:$PATH"
fi

# Python Test Harness
export PYTHONPATH=$PYTHONPATH:$HOME/code/pythontestharness/lib

# stice-gg
export PATH="$HOME/code/stice-gg:$PATH"
