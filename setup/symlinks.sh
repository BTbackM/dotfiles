#!/bin/bash

set -e

dotfiles_dir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)

source "$dotfiles_dir/config/bin/colors"

echo -e "Creating config symlinks: ${BGREEN}symlinks.sh${NC}"

"$dotfiles_dir/config/bin/copy" \
    "$dotfiles_dir/config/git/.gitconfig" \
    "$HOME/.gitconfig"

echo -e "Copied Git config to ${BRED}~/.gitconfig${NC}"

"$dotfiles_dir/config/bin/create_symlink" \
    "$dotfiles_dir/config/hypr/" \
    "$HOME/.config/hypr/"

echo -e "Linked Hypr config to ${BRED}~/.config/hypr${NC}"

"$dotfiles_dir/config/bin/create_symlink" \
    "$dotfiles_dir/config/zsh/zshrc" \
    "$HOME/.zshrc/"

echo -e "Linked ZSH config to ${BRED}~/.zshrc${NC}"
