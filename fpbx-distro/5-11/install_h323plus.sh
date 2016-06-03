cd "${SRC_BASE}/h323plus"

if [ "`uname`" == "Linux" ]; then
	cp -vf --no-dereference lib/libh323_* /usr/lib${LIB_SUFFIX}
else
	cp -vfR lib/libh323_* /usr/local/lib
fi
