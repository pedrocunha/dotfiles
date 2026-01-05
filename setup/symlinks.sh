#!/usr/bin/env bash
#
# symlinks.sh - Links *.symlink files to your home directory as dotfiles
#
# Example: symlinks/gitconfig.symlink → ~/.gitconfig
#

# Exit immediately if any command fails
set -e

# Resolve DOTFILES_ROOT from this script's location (setup/../ = dotfiles root)
DOTFILES_ROOT="$(cd "$(dirname "$0")/.." && pwd)"

# Helper functions for pretty output
info()    { printf "  [ \033[00;34m..\033[0m ] %s\n" "$1"; }
success() { printf "  [ \033[00;32mOK\033[0m ] %s\n" "$1"; }

info "setting up dotfiles"

# Loop through all .symlink files in the symlinks directory
for source in "$DOTFILES_ROOT"/symlinks/*.symlink; do
  # Build destination path: strip .symlink extension, add dot prefix, put in $HOME
  # e.g., /path/to/gitconfig.symlink → ~/.gitconfig
  dest="$HOME/.$(basename "${source%.*}")"

  # Check if destination already exists (file, directory, or symlink)
  if [ -e "$dest" ] || [ -L "$dest" ]; then
    # Prompt user for action (-r: raw input, -n 1: single character)
    read -rp "  File exists: $(basename "$dest"). [s]kip, [o]verwrite, [b]ackup? " -n 1 action
    echo  # Add newline after single-char input

    case "$action" in
      o) rm -rf "$dest" ;;                                      # Overwrite: remove existing
      b) mv "$dest" "$dest.backup"; success "backed up $dest";; # Backup: rename with .backup suffix
      *) success "skipped $dest"; continue ;;                   # Skip (or invalid): move to next file
    esac
  fi

  # Create the symlink
  ln -s "$source" "$dest"
  success "linked $(basename "$source") → $dest"
done
