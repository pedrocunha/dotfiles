#!/usr/bin/env bash
#
# symlinks connects .symlink files to your home directory
DOTFILES_ROOT="`pwd`"

set -e

echo ''

info () {
  printf "  [ \033[00;34m..\033[0m ] $1\n"
}

user () {
  printf "\r  [ \033[0;33m?\033[0m ] $1 "
}

success () {
  printf "\r\033[2K  [ \033[00;32mOK\033[0m ] $1\n"
}

link_files () {
  ln -s $1 $2
  success "linked $1 to $2"
}

info "setting up dotfiles"

for source in `find $DOTFILES_ROOT/symlinks -maxdepth 1 -name \*.symlink`
do
  dest="$HOME/.`basename \"${source%.*}\"`"

  if [ -f $dest ] || [ -d $dest ]
  then
    user "file already exists: `basename $source`, what do you want to do? [s]kip, [o]verwrite, [b]ackup?"
    read -n 1 action

    skip=false
    overwrite=false
    backup=false

    case "$action" in
      s )
        skip=true;;
      o )
        overwrite=true;;
      b )
        backup=true;;
      * )
        ;;
    esac

    if [ "$overwrite" == "true" ]
    then
      rm -rf $dest
      link_files $source $dest
      continue
    fi

    if [ "$backup" == "true" ]
    then
      mv $dest $dest\.backup
      success "moved $dest to $dest.backup"
      link_files $source $dest
      continue
    fi

    if [ "$skip" == "true" ]
    then
      success "skipped $source"
    fi
  else
    link_files $source $dest
  fi
done

