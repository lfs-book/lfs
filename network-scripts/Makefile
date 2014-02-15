EXTDIR=${DESTDIR}/etc
LIBDIR=${DESTDIR}/lib
SERVICEDIR=${LIBDIR}/services
UNITDIR=${LIBDIR}/systemd/system
MAN8=${DESTDIR}/usr/share/man/man8
SBIN=${DESTDIR}/sbin
MODE=755
DIRMODE=755
CONFMODE=644

install: files

create-dirs:
	install -d -m ${DIRMODE}  ${EXTDIR}/sysconfig
	install -d -m ${DIRMODE}  ${SERVICEDIR}
	install -d -m ${DIRMODE}  ${UNITDIR}
	install -d -m ${DIRMODE}  ${MAN8}
	install -d -m ${DIRMODE}  ${SBIN}
	ln -sfn       services    ${LIBDIR}/lsb

files: create-dirs
	install -m ${MODE} lfs/sbin/ifup   ${SBIN}
	install -m ${MODE} lfs/sbin/ifdown ${SBIN}
	install -m ${MODE} lfs/sbin/ifup.8 ${MAN8}
	ln -sf  ifup.8                     ${MAN8}/ifdown.8
	install -m ${MODE} lfs/lib/services/ipv4-static-route  ${SERVICEDIR}
	install -m ${MODE} lfs/lib/services/ipv4-static        ${SERVICEDIR}
	install -m ${CONFMODE} lfs/lib/services/init-functions ${SERVICEDIR}
	install -m ${CONFMODE} lfs/units/ifupdownat.service ${UNITDIR}/ifupdown@.service

uninstall:
	rm -rf ${SERVICEDIR} ${LIBDIR}/lsb ${UNITDIR}/ifupdown@.service \
               ${SBIN}/ifup ${SBIN}/ifdown ${MAN8}/ifup.8 ${MAN8}/ifdown.8

.PHONY: all create-dirs install files uninstall
