# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit unpacker systemd font desktop xdg

MY_P="${PN}_${PV}"

DESCRIPTION="Remote control and team work"
HOMEPAGE="https://www.todesk.com"
SRC_URI="amd64? ( https://dl.todesk.com/linux/${MY_P}_amd64.deb )
	arm? ( https://dl.todesk.com/linux/${MY_P}_armv7l.deb )
	arm64? ( https://dl.todesk.com/linux/${MY_P}_aarch64.deb )"

RESTRICT="mirror"
LICENSE="ToDesk"
SLOT="0"
KEYWORDS="-* ~amd64 ~arm ~arm64"
IUSE="+fonts"

RDEPEND="x11-libs/gtk+:3"
DEPEND=""
BDEPEND=""

FONT_S="opt/${PN}/res/fonts"
FONT_SUFFIX="ttc"

S="${WORKDIR}"

QA_PREBUILT="opt/${PN}/*"
#QA_DESKTOP_FILE="usr/share/applications/${PN}.desktop"

src_install() {
	insinto /opt
	doins -r opt/${PN}
	fperms +x /opt/${PN}/bin/${PN}{,c,d}
	keepdir /opt/${PN}/config
	rm -r ${ED%/}/opt/${PN}/res/fonts || die

	exeinto /opt/bin
	doexe usr/local/bin/${PN}

	newinitd "${FILESDIR}"/${PN}d.initd ${PN}d
	systemd_dounit etc/systemd/system/${PN}d.service

	for si in 16 24 32 48 64 128 256 512; do
		doicon -s ${si} usr/share/icons/hicolor/${si}x${si}/apps/${PN}.png
	done
	domenu usr/share/applications/${PN}.desktop

	use fonts && font_src_install
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

	xdg_pkg_postinst
	use fonts && font_pkg_postinst
}

pkg_postrm() {
	xdg_pkg_postrm
	use fonts && font_pkg_postrm
}
