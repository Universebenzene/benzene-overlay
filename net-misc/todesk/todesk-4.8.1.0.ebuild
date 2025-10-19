# Copyright 2022-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit unpacker systemd desktop optfeature xdg

MY_P="${PN}-v${PV}"

DESCRIPTION="Remote control and team work"
HOMEPAGE="https://www.todesk.com"
SRC_URI="amd64? ( https://dl.todesk.com/linux/${MY_P}-amd64.deb )"

RESTRICT="mirror"
LICENSE="ToDesk"
SLOT="0"
KEYWORDS="-* ~amd64"
IUSE="keep-server"

RDEPEND="dev-libs/libayatana-appindicator
	virtual/libsystemd
"

S="${WORKDIR}"

QA_PREBUILT="opt/${PN}/*"
#QA_DESKTOP_FILE="usr/share/applications/${PN}.desktop"

src_install() {
	insinto /opt
	insopts -m755
	doins -r opt/${PN}
	fperms -x /opt/${PN}/res/{20-todesk.conf,fake.png,small.ico}
	dosym -r /usr/$(get_libdir)/libayatana-appindicator3.so /opt/${PN}/bin/libappindicator3.so.1

	exeinto /opt/${PN}/bin
	use keep-server && { dosym -r /usr/bin/sleep /opt/${PN}/bin/${PN}-hold ; \
		newexe {"${FILESDIR}"/${PV}-,}starthold-todeskd-systemd ; \
		newexe {"${FILESDIR}"/${PV}-,}systemd-todeskd ; \
		doexe "${FILESDIR}"/stophold-todeskd-systemd ;
	}

	newinitd "${FILESDIR}"/$(usex keep-server "${PN}d-alone-4.3.0.0.initd" "${PN}d-4.3.0.0.initd") ${PN}d
	use keep-server && systemd_newunit "${FILESDIR}"/${PV}-${PN}d-keep.service ${PN}d.service || \
		systemd_dounit etc/systemd/system/${PN}d.service

	exeinto /opt/bin
	doexe usr/local/bin/${PN}

	for si in 16 24 32 48 64 128 256 512; do
		doicon -s ${si} usr/share/icons/hicolor/${si}x${si}/apps/${PN}.png
	done
	domenu usr/share/applications/${PN}.desktop
}

pkg_postinst() {
	elog
	elog "Before using ToDesk, you need to start its daemon:"
	elog "OpenRC:"
	elog "# /etc/init.d/todeskd start"
	elog "# rc-update add todeskd default"
	elog
	elog "Systemd:"
	elog "# systemctl start todeskd.service"
	elog "# systemctl enable todeskd.service"
	elog
	optfeature "better Chinese font appearance for GUI client" media-fonts/noto-cjk

	xdg_pkg_postinst
}
