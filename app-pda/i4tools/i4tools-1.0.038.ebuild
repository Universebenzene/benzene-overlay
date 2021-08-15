# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit unpacker desktop udev xdg

DESCRIPTION="A third-party tool for managing iOS devices"
HOMEPAGE="https://www.i4.cn"
SRC_URI="https://d-updater.i4.cn/i4linux/deb/i4tools_v${PV}.deb"

LICENSE="i4"
SLOT="0"
RESTRICT="strip"
KEYWORDS="~amd64"

RDEPEND="media-video/ffmpeg[iec61883,ieee1394,jack,libcaca,librtmp,speex,twolame]
	app-pda/usbmuxd
	media-libs/libwebp
	media-sound/wavpack
	net-nds/openldap
	sys-process/numactl
"
DEPEND=""
BDEPEND=""

S="${WORKDIR}"

src_install() {
	udev_dorules etc/udev/rules.d/39-i4tools.rules

	insinto /usr/share
	doins -r usr/share/polkit-1

	local USD="usr/share/${PN}"

	insinto /${USD}
	doins -r ${USD}/{files,${PN}.png,qt.conf,resources,translations}

	insinto /${USD}/lib/openssl
	doins -r ${USD}/lib/openssl/pkgconfig

	insopts -m755
	insinto /${USD}
	doins -r ${USD}/{${PN}linux{,.sh},libexec,plugins}

	insinto /${USD}/lib
	doins -r ${USD}/lib/{*so*,customui}

	insinto /${USD}/lib/openssl
	doins -r ${USD}/lib/openssl/{*so*,engines-1.1}

	dosym libwebp.so /usr/$(get_libdir)/libwebp.so.6
	domenu usr/share/applications/${PN}.desktop
}
