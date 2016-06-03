[ -h ptlib ] && echo "Already exists" && exit
if [ ! -d ptlib-svn_2.10 ]; then
	svn checkout http://svn.code.sf.net/p/opalvoip/code/ptlib/branches/v2_10 ptlib-svn_2.10 -r 32424 || exit 1
fi
if [ -d ptlib-svn_2.10 ]; then
	ln -svnf ptlib-svn_2.10 ptlib
else
	exit 1
fi
