##########################
# 1. Basic Configuration #
##########################

# history settings
shopt -s histappend		# append, no overwrite
HISTSIZE=10000
HISTFILESIZE=20000

##############
# 2. Aliases #
##############

alias vi='vim'

# color and with classfication
alias ls='ls -FG'
alias ll='ls -alFG'

# grep
alias grep='grep -G'
alias fgrep='fgrep -G'
alias egrep='egrep -G'

# alert for rm, cp, mv
alias rm='rm -iv'
alias cp='cp -iv'
alias mv='mv -iv'

# screens
alias scr='screen -rD'

##################
# 3. Color & PS1 #
##################

source ~/.bash_prompt

###########
# 4. etc  #
###########

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

