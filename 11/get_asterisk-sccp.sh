[ -h asterisk-sccp ] && rm -vf asterisk-sccp
[ -d asterisk-sccp-svn_latest ] && rm -vrf asterisk-sccp-svn_latest
svn checkout svn://svn.code.sf.net/p/chan-sccp-b/code/trunk asterisk-sccp-svn_latest || exit 1
if [ -d asterisk-sccp-svn_latest ]; then
	ln -svnf asterisk-sccp-svn_latest asterisk-sccp
else
	exit 1
fi
