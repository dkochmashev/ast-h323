[ -h ptlib ] && rm -vf ptlib
[ -d ptlib-svn_latest ] && rm -vrf ptlib-svn_latest
svn checkout http://opalvoip.svn.sourceforge.net/svnroot/opalvoip/ptlib/trunk ptlib-svn_latest || exit 1
if [ -d ptlib-svn_latest ]; then
	ln -svnf ptlib-svn_latest ptlib
else
	exit 1
fi
