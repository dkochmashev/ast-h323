if [ "`uname -o`" == "GNU/Linux" ]; then
	export MAKE_CMD=make
else
	export MAKE_CMD=gmake
fi
