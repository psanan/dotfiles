# rc Files
Files defining settings for bash, vim, and other unix-style tools.

`setup.sh` is a simple script to symlink these files into place on a new system.

## Startup Files

`.bashrc`       

* commands for all interactive bash shells
* shouldn't output anything

`.profile`      

* commands for login shells

`.bash_profile`

* bash-specific commands for login shells
* should source `~/.profile` and `~/.bashrc`.
