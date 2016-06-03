if [ "`uname -o`" == "GNU/Linux" ]; then
	export MAKE_CMD=make
else
	export MAKE_CMD=gmake
fi

if [ "`uname -m`" == "x86_64" ]; then
	export LIB_SUFFIX=64
else
	export LIB_SUFFIX=
fi