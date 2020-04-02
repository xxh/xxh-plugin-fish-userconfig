# User configuration plugin for [xxh-shell-fish](https://github.com/xxh/xxh-shell-fish).

## User configuration

xxh plugins are nice but sometimes you just need to add a little personal configuration to your remote shells. Fish package managers have configuration files that list the packages to install. If you have functions and fish configuration that you would like to have present when you xxh into a remote shell then this is the plugin for you.

## Philosophy

This plugin maintains a seperation between your local Fish shell configuration and your remote shell configuration as you may not want them to be exactly the same.

## Fish Shell Remote Host Configuration

Place the configuration files you want transfered to the remote host in `~/.xxh/.xxh/config/xxh-plugin-fish-userconfig/fish` on your local computer. The files in this folder are the same as you would place in the `~/.config/fish/` directory for your local Fish shell installation.

You can create directories for `functions`, `completions`, and program configuration `conf.d`. These directories and their contents will be transfered to the remote host. They will be copied into the xxh Fish shell's configuration directory.

## Install
Install from xxh repository:

```bash
xxh +I xxh-plugin-fish-userconfig
```

Connect and install the User Config plugin:

```bash
xxh yourhost +s fish +if
```
