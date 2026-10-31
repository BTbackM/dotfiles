#!/bin/bash

set -e

dotfiles_dir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)
bin_dir="$HOME/.local/bin"

source "$dotfiles_dir/config/bin/colors"

mkdir -p -- "$bin_dir"

echo -e "Creating binary symlinks: ${BGREEN}binaries.sh${NC}"

for binary in "$dotfiles_dir"/config/bin/*; do
    [[ -e "$binary" || -L "$binary" ]] || continue
    "$dotfiles_dir/config/bin/create_symlink" "$binary" "$bin_dir/"
    echo -e "Linked ${BLUE}$(basename -- "$binary")${NC}"
done
