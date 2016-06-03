[ -h gnugk ] && rm -vf gnugk
[ -d gnugk-cvs_latest ] && rm -vrf gnugk-cvs_latest
cvs -z3 -d:pserver:anonymous@openh323gk.cvs.sourceforge.net:/cvsroot/openh323gk co -P openh323gk || exit 1
mv openh323gk gnugk-cvs_latest || exit 1
ln -svnf gnugk-cvs_latest gnugk
