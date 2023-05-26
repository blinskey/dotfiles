# Initialization for all Bourne-compatible shells.

export PATH=$HOME/bin:/usr/local/bin:/usr/local/sbin:/bin:/sbin:/usr/bin:/usr/sbin

# Add MacPorts directories to PATH on macOS.
if [ "$(uname)" = "Darwin" ]; then
	export PATH="/opt/local/bin:/opt/local/sbin:$PATH"
fi

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

# On Windows, run keychain to enable ssh-agent sharing across shells.
if [ -f /proc/version ] && grep -qi microsoft /proc/version; then
	/usr/bin/keychain -q --nogui $HOME/.ssh/id_rsa
	. $HOME/.keychain/$(hostname -s)-sh
fi
