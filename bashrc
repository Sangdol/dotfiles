#
# Many things from Mathia's dotfiles
# https://github.com/mathiasbynens/dotfiles/blob/master/.bash_profile
#

##
# Load files
##
source $HOME/dotfiles/aliases
source $HOME/dotfiles/bash_prompt
source $HOME/dotfiles/mvnrc
source $HOME/dotfiles/functions

##
# shopt settings
# Reference: http://www.gnu.org/software/bash/manual/bash.html#The-Shopt-Builtin
##

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob

# Append to the Bash history file, rather than overwriting it
shopt -s histappend

# Autocorrect typos in path names when using `cd`
shopt -s cdspell

# Extended globs http://mywiki.wooledge.org/glob
shopt -s extglob

# Enable some Bash 4 features when possible:
# * autocd - cd by just directory name
# * globstar - Recursive globbing, e.g. `echo **/*.txt`
for option in autocd globstar; do
	shopt -s "$option" 2> /dev/null
done

##
# exports
##

# Default editor
export EDITOR=vim

# history settings
export HISTSIZE=10000
export HISTFILESIZE=20000

##
# etc
##

# Disable Screen stop function and enable forward search (<Ctrl>-S)
stty stop ""

# Add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards
[ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2)" scp sftp ssh

# set tab size
tabs -4

# Prevent overwrite(clobbering)
# http://en.wikipedia.org/wiki/Clobbering
set -o noclobber

# Screen alert
if [ "$TERM" = "screen" ]; then
	echo "[ screen is activated ]"
fi

# Python server
serve() {
    port=${1:-8080}
    python -m SimpleHTTPServer $port &
    open http://localhost:$port
}

# Set tabname
# https://gist.github.com/3877451
tabname() {
  printf "\e]1;$1\a"
}

cd() {
  if [[ $# -gt 0 ]]; then
    builtin cd "$*"
  else
    builtin cd
  fi
  tabname $(basename $(pwd))
}

case $OSTYPE in
	darwin*)
		# Setting PATH for Python 2.7
		# The orginal version is saved in .bash_profile.pysave
		export PATH="/Library/Frameworks/Python.framework/Versions/2.7/bin:${PATH}"
		;;
	cygwin)
		export LANG=ko_KR.UTF-8
		alias open='cygstart'
		/cygdrive/c/Windows/System32/chcp.com 65001 # Set encoding to UTF-8
		;;
esac

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
