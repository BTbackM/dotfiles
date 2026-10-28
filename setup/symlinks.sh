#!/bin/bash

set -e

dotfiles_dir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)

source "$dotfiles_dir/config/bin/colors"

echo -e "Creating config symlinks: ${BGREEN}symlinks.sh${NC}"

"$dotfiles_dir/config/bin/create_symlink" \
    "$dotfiles_dir/config/git/.gitconfig" \
    "$HOME/.gitconfig"

echo -e "${GREEN}Linked Git config to ~/.gitconfig${NC}"
