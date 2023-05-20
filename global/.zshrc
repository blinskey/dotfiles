# vi mode
bindkey -v

PS1='%m:%1~$ '

HISTFILE=

if [ -f "$HOME/.aliases" ]; then
	. "$HOME/.aliases"
fi
