#!/bin/sh

# Installs plugins from Git repositories using Vim's package system.
# See ":h add-package" in Vim for details.

set -e

PLUGDIR="$HOME/.vim/pack/plugins/start"

git_install() {
	name="$(basename -s .git "$1")"
	dest="$PLUGDIR/$name"

	if [ -d "$dest" ]; then
		printf "%s\n" "Skipping $name: Directory not empty."
		return
	fi

	git clone --depth 1 "$1" "$dest"
}

mkdir -p $PLUGDIR

git_install https://github.com/blinskey/btl.vim.git
git_install https://github.com/cocopon/iceberg.vim
git_install https://github.com/ctrlpvim/ctrlp.vim.git
git_install https://github.com/dense-analysis/ale.git
