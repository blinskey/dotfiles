#!/bin/sh

# Installs plugins from Git repositories using Vim's package system.
# See ":h add-package" in Vim for details.

set -e

PLUGDIR="$HOME/.vim/pack/plugins/start"

git_install() {
	name="$(basename -s .git "$1")"
	dest="$PLUGDIR/$name"

	if [ -d "$dest" ]; then
		printf "%s\n" "$name already exists."
	else
		git clone --depth 1 "$1" "$dest"
	fi

	docs=$dest/doc
	if [ -d "$docs" ]; then
		vim -u NONE -e -s -c "helptags $docs" -c q
	fi
}

mkdir -p $PLUGDIR

git_install https://github.com/blinskey/btl.vim.git
git_install https://github.com/blinskey/iceberg.vim.git
git_install https://github.com/ctrlpvim/ctrlp.vim.git
git_install https://github.com/dense-analysis/ale.git
