# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit unpacker desktop udev xdg

DESCRIPTION="A third-party tool for managing Apple (iOS) devices"
HOMEPAGE="https://www.i4.cn"
SRC_URI="https://d-updater.i4.cn/i4linux/deb/i4tools_v${PV}.deb"

LICENSE="i4"
SLOT="0"
RESTRICT="strip"
#KEYWORDS="~amd64"

RDEPEND="media-video/ffmpeg[cdio,iec61883,ieee1394,jack,libcaca,librtmp,sdl,speex,twolame,webp]
	media-plugins/gst-plugins-meta[mp3,wavpack]
	app-pda/usbmuxd
	|| ( net-nds/openldap-compat:2.4 net-nds/openldap:0/0 )
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
	dosym -r /${USD}/${PN}linux.sh /usr/bin/${PN}
	domenu usr/share/applications/${PN}.desktop
}
