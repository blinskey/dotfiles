set +o history

# Check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# globstar: Available starting in Bash 4.0.
# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
if [ ${BASH_VERSION:0:1} -gt 3 ]; then
    shopt -s globstar
fi

# Use vi keybindings.
set -o vi

PS1="\h:\W\\$ "

if [ -f "$HOME/.aliases" ]; then
    . "$HOME/.aliases"
fi
