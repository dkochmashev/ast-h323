cd "${SRC_BASE}/h323plus"
echo -e "\nPatching 'h323plus'...\n"
patch -bENp0 < "${SRC_BASE}/h323plus-patchset/patchset.diff" || exit 1
