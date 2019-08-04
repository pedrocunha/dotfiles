# dotfiles

This repository contains all the custom configuration files for the software that I use for development (including zsh) and some added binaries. This was originally a fork from [holman/dotfiles](https://github.com/holman/dotfiles) but decided to steal some of its ideas and simplify the setup as I am not a big fan of having lots of folders and files, as I prefer to have an holistic view of everything. Also, the more complexity added will just make the shell load even slower.

## Symlinks

It is common to override/add functionality through files, like `rgignore` or `vimrc` etc.. this repository provides with the ability to create version controlled files and symlink them from `$HOME/<file>`. Files (or even folders) must be created under this project's `symlinks` folder and have `.symlink` suffix. To setup all symlinks run `./setup/symlinks` on the root of this project

## Environment

All files within `zsh` folder control the system this include paths, completion, etc..

## Binaries

Anything within `bin` folder is executable from anywhere. Probably most interesting and recurring command is `dot` to make sure all software is running at latest.