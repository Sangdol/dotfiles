# Load files
source ~/dotfiles/aliases
source ~/dotfiles/bash_prompt

# history settings
shopt -s histappend		# append, no overwrite
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
		# add bash completion
		# https://github.com/bobthecow/git-flow-completion/wiki/Install-Bash-git-completion
		if [ -f `brew --prefix`/etc/bash_completion ]; then
				. `brew --prefix`/etc/bash_completion
		fi

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

