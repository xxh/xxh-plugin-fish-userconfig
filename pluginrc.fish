#!/usr/bin/env fish
# Next line for testing.
#set fish_trace true

set_color blue

# Set the location of this plugin's build directory on the remote host.
set CURRENT_DIR (dirname (realpath (status current-filename)))
cd $CURRENT_DIR

# Set the base directory that we want directories and files copied into on the remote server.
# Normally this will be into $XDG_CONFIG_HOME which is set by default by xxh to:
# $HOME/.xxh/.config
set basedirectorytocopyfilesto $XDG_CONFIG_HOME

# Makes a directory if it is not found.
function mkdirifnotfound
    mkdir -p "$basedirectorytocopyfilesto/$founddirectory"
end

# Set files then copy them. By default is this the files in the "fish" directory,
# that would normally be found in ~/.config/fish
set filestocopy "fish"
for found in (find "$filestocopy" -depth -print)
    if test -f "$found"
      set founddirectory (dirname "$found")
      mkdirifnotfound
      cp "$found" "$basedirectorytocopyfilesto/$founddirectory/"
    else
      mkdirifnotfound
    end
end

set_color normal
# For testing, ends trace.
#set -e fish_trace
