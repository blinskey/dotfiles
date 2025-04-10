#!/bin/sh

set -eu

# Delete any pre-installed ~/.bash_profile.
rm -f $HOME/.bash_profile

# Load Gnome Terminal settings.
if [ -x "$(command -v dconf)" ]; then
    dconf load /org/gnome/terminal/legacy/ < win/gnome-terminal.dconf
fi

# Load WSL settings and WSL-specific files.
if [ -f /proc/version ] && grep -qi microsoft /proc/version; then
	# Create a link to Windows home directory in WSL home directory.
	rm -f $HOME/win
	ln -s '/mnt/c/Users/Benjamin Linskey' $HOME/win

	# Install terminal in regular Windows filesystem, then link it to WSL home
	# directory.
	win_term_prof=$HOME/win/AppData/Local/Packages/Microsoft.WindowsTerminal_8wekyb3d8bbwe/LocalState/settings.json
	cp win/windows-terminal-settings.json $win_term_prof
	ln -sf $win_term_prof $HOME/.windows-terminal-settings.json

	# Install WSL-specific container config files.
	mkdir -p $HOME/.config
	ln -sf $PWD/win/containers $HOME/.config/containers
fi

cd global
for f in .*; do
    if [ $f != . ] \
            && [ $f != .. ] \
            && [ $f != .git ] \
            && [ $f != .gitignore ]; then
        ln -sf $PWD/$f $HOME
    fi
done

# Install Vim plugins.
.vim/install-plugins.sh
