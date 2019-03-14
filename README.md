# rc Files
Files defining settings for bash, vim, and other unix-style tools.

`setup.sh` is a simple script to symlink these files into place on a new system.

## Startup Files

* Maintain
    * `.bashrc`       (commands for all interactive shells)
    * `.profile`      (commands for login shells)
    * `.bash_profile` (bash-specific commands for login shells)
* `.bash_profile` should source `~/.profile` and `~/.bashrc`.
* `.bashrc` shouldn't output anything.
