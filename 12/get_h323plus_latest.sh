[ -h h323plus ] && rm -vf h323plus
[ -d h323plus-cvs_latest ] && rm -vrf h323plus-cvs_latest
cvs -z3 -d:pserver:anonymous@h323plus.cvs.sourceforge.net:/cvsroot/h323plus co -P h323plus || exit 1
mv h323plus h323plus-cvs_latest || exit 1
ln -svnf h323plus-cvs_latest h323plus
