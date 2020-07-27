#!/usr/bin/env bash
# For testing. First line outputs line numbers.
# Second line says to output what is going on in script
PS4=':${LINENO}+'
#set -x

# Where is our plugin's base directory?
CDIR="$(cd "$(dirname "$0")" && pwd)"

# Move to plugin directory.
cd "$CDIR"

build_dir=$CDIR/build

while getopts A:K:q option
do
  case "${option}"
  in
    q) QUIET=1;;
    A) ARCH=${OPTARG};;
    K) KERNEL=${OPTARG};;
  esac
done

function loadcolor(){
# Colors  http://wiki.bash-hackers.org/snipplets/add_color_to_your_scripts
# More info about colors in bash http://misc.flogisoft.com/bash/tip_colors_and_formatting
esc_seq="\x1b["  #In Bash, the <Esc> character can be obtained with the following syntaxes:  \e  \033  \x1B
NC=$esc_seq"39;49;00m" # NC = Normal Color
# Colors with black background (40;)set for emails.
red=$esc_seq"31;40;01m"
green=$esc_seq"32;40;00m"
yellow=$esc_seq"33;40;01m"
blue=$esc_seq"34;40;01m"
magenta=$esc_seq"35;40;01m"
cyan=$esc_seq"36;40;01m"
}
loadcolor

# Makes a directory if it is not found.
function mkdirifnotfound(){
  mkdir -p "$build_dir/$founddirectory"
}

# Clean build directory before building.
rm -rf $build_dir
mkdir -p "$build_dir/"

# Check if there are any configuration files to copy to the remote host, if not inform the user.
if [ ! -d $HOME/.xxh/.xxh/config/xxh-plugin-fish-userconfig/fish ]; then
  echo -e "${yellow}>>> ${red}Warning: There is not much point to using the xxh-plugin-fish-userconfig plugin if there is no configuration to copy to the remote host.${NC}"
  echo -e "${yellow}>>> ${red}Please add some configuration in ~/.xxh/.xxh/config/xxh-plugin-fish-userconfig/fish to be transfered to the remote hosts.${NC}"
  exit
fi

# Copy files to the build directory that will be uploaded to remote hosts.
for filestocopy in pluginrc.fish
do
  for found in $(find "$filestocopy" -depth -print)
  do
    if [ -f "$found" ]; then
      founddirectory=$(dirname "$found")
      mkdirifnotfound
      cp -r "$found" "$build_dir"
    else
      mkdirifnotfound
    fi
  done
done

# Copy files from the user's remote Fish configuration directory to the
# build directory that will be uploaded to remote hosts.
cd "$HOME/.xxh/.xxh/config/xxh-plugin-fish-userconfig/"
for f in fish
do
     find "$f" -depth -print | cpio --quiet -pd "$build_dir"
done
