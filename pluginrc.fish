#!/usr/bin/env fish
# Next line for testing.
#set fish_trace true

set_color blue

# Set the location of this plugin's build directory on the remote host.
set CURRENT_DIR (dirname (realpath (status current-filename)))

cd $CURRENT_DIR

# Set where we want to place the Fish configuration files then copy them.
set XXH_FISH_CONFIG_HOME $XDG_CONFIG_HOME
find "fish" -depth -print | cpio --quiet -pd "$XXH_FISH_CONFIG_HOME" &>/dev/null

set_color normal
# For testing, ends trace.
#set -e fish_trace
