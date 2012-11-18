#
# Many things from Mathia's dotfiles
# https://github.com/mathiasbynens/dotfiles/blob/master/.bash_profile
#

##
# Load files
##
source ~/dotfiles/aliases
source ~/dotfiles/bash_prompt

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

# Enable some Bash 4 features when possible:
# * autocd - cd by just directory name
# * globstar - Recursive globbing, e.g. `echo **/*.txt`
for option in autocd globstar; do
	shopt -s "$option" 2> /dev/null
done

##
# etc
##

# Add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards
[ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2)" scp sftp ssh

# Exports
export EDITOR=vim

# history settings
HISTSIZE=10000
HISTFILESIZE=20000

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
		# update locate database
		# http://www.mechanicalgirl.com/post/update-locate-database-for-mac-os-x/
		alias updatedb="sudo /usr/libexec/locate.updatedb"

		# Setting PATH for Python 2.7
		# The orginal version is saved in .bash_profile.pysave
		export PATH="/Library/Frameworks/Python.framework/Versions/2.7/bin:${PATH}"
		;;
	cygwin)
		export LANG=ko_KR.UTF-8
		alias open='cygstart'
		;;
esac

