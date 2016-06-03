#!/bin/bash

SRC_BASE=`dirname $0`
[ -f "${SRC_BASE}/$0" ] || SRC_BASE=`dirname $0`

cd "${SRC_BASE}/asterisk-g72x"

CPU_VENDOR=`grep -m 1 -P "^vendor_id\s+:\s+" /proc/cpuinfo | sed -r 's/^.*:.*(Intel|AMD).*$/\1/'`
CPU_MODEL=`grep -m 1 -P "^model name\s+:\s+" /proc/cpuinfo | sed -r 's/^.*:.*(Core\(TM\)2|Opteron).*$/\1/'`
CPU_SSE3_FLAG=`grep -m 1 -P "^flags\s+:\s+.*\spni\s.*$" /proc/cpuinfo | wc -l`
CPU_SSE4_FLAG=`grep -m 1 -P "^flags\s+:\s+.*\ssse4.*$" /proc/cpuinfo | wc -l`

CPU_SYSTEM=`uname -i`
if [ "${CPU_SYSTEM}" == "x86_64" ]; then
	CPU_SYSTEM="${CPU_SYSTEM}-"
else
	CPU_SYSTEM=""
fi
        
case "${CPU_VENDOR}" in
	Intel)
		case "${CPU_MODEL}" in
			"Core(TM)2")
				CPU_SUFFIX="${CPU_SYSTEM}core2"
				[ ${CPU_SSE4_FLAG} -gt 0 ] && CPU_SUFFIX="${CPU_SUFFIX}-sse4"
			;;
			*)
				CPU_SUFFIX="${CPU_SYSTEM}pentium4"
				[ "${CPU_SYSTEM}" == "" -a ${CPU_SSE3_FLAG} -gt 0 ] && CPU_SUFFIX="${CPU_SUFFIX}-sse3"
			;;
		esac
	;;

	AMD)
		case "${CPU_MODEL}" in
			Opteron)
				CPU_SUFFIX="${CPU_SYSTEM}opteron"
				[ ${CPU_SSE3_FLAG} -gt 0 ] && CPU_SUFFIX="${CPU_SUFFIX}-sse3"
			;;
			*)
				CPU_SUFFIX="${CPU_SYSTEM}pentium4"
				[ "${CPU_SYSTEM}" == "" -a ${CPU_SSE3_FLAG} -gt 0 ] && CPU_SUFFIX="${CPU_SUFFIX}-sse3"
			;;
		esac
	;;

	*)
		CPU_SUFFIX="${CPU_SYSTEM}pentium4"
		[ "${CPU_SYSTEM}" == "" -a ${CPU_SSE3_FLAG} -gt 0 ] && CPU_SUFFIX="${CPU_SUFFIX}-sse3"
	;;
esac

for CODEC in g723 g729 ; do
	cp -vf "codec_${CODEC}-ast18-gcc4-glibc-${CPU_SUFFIX}.so" "${HOME}/lib/asterisk/modules/" || exit 1
	ln -svnf "codec_${CODEC}-ast18-gcc4-glibc-${CPU_SUFFIX}.so" "${HOME}/lib/asterisk/modules/codec_${CODEC}.so" || exit 1
done
