# Initialization for all Bourne-compatible shells.

PATH=/usr/local/bin:/usr/local/sbin:/bin:/sbin:/usr/bin:/usr/sbin

# Add pkgsrc directories to PATH on macOS.
if [ "$(uname)" = "Darwin" ]; then
	PATH="/opt/pkg/bin:/opt/pkg/sbin:$PATH"
fi

export PATH="$HOME/bin:$PATH"

if [ "$SHELL" == /bin/ksh ]; then
    export ENV=$HOME/.kshrc
elif [ "$SHELL" == /bin/bash ]; then
    . "$HOME/.bashrc"
fi

export LC_CTYPE=en_US.UTF-8

# UTF-8 on FreeBSD (requires the vt console driver; see vt(4)).
if [ "$(uname)" = "FreeBSD" ]; then
    export CHARSET="UTF-8"
    export LANG="en_US.UTF-8"
fi

# Set editor. Use vim if available, or vi otherwise.
if type vim >/dev/null 2>&1; then
    export VISUAL='vim -u $HOME/.vimrc'
else
    export VISUAL=vi
fi

export PAGER=less
export MANPAGER=$PAGER

# Don't kill shell due to inactivity.
unset TMOUT

export NO_COLOR=1

export LESSHISTFILE=-

# Windows Subsystem for Linux
if [ -f /proc/version ] && grep -qi microsoft /proc/version; then
	# Run keychain to enable ssh-agent sharing across shells.
	/usr/bin/keychain -q --nogui $HOME/.ssh/id_rsa
	. $HOME/.keychain/$(hostname -s)-sh

	# Add Windows OpenSSH directory to PATH to enable 1Password integration.
	export PATH="${PATH}:/mnt/c/Windows/System32/OpenSSH"
fi
