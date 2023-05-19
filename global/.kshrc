# .kshrc -- ksh configuration file
#
# To use this file, specify its location in the  ENV paramater in ~/.profile:
#
# 	export ENV=$HOME/.kshrc

HISTFILE=

if [ "$(uname)" = OpenBSD ]; then
    PS1="\h:\W\\$ "
else
    ps1dir() {
        if [ "$PWD" = "$HOME" ]; then
            echo "~"
        else
            echo "$(basename "$PWD")"
        fi
    }
    PS1='"$(hostname -s)":"$(ps1dir)"\$ '
fi

if [ -f "$HOME/.aliases" ]; then
    . "$HOME/.aliases"
fi
