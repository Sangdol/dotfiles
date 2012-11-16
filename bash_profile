if [ -r ~/.profile ]; then . ~/.profile; fi
case "$-" in *i*) if [ -r ~/.bashrc ]; then . ~/.bashrc; fi;; esac

case $OSTYPE in
	cygwin)
		exec /usr/bin/screen
		;;
esac
