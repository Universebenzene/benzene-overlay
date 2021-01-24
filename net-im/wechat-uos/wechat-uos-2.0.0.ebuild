# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit unpacker desktop xdg

MY_PN="com.qq.weixin"
MY_PV="${PV}-2"
MY_P="${MY_PN}_${MY_PV}"

DESCRIPTION="Official WeChat (Weixin) for UOS (patched by AUR for other distros)"
HOMEPAGE="https://www.chinauos.com/resource/download-professional"
SRC_URI="https://cdn-package-store6.deepin.com/appstore/pool/appstore/${MY_PN:0:1}/${MY_PN}/${MY_P}_amd64.deb"

LICENSE="MIT"
SLOT="0"
RESTRICT="strip"
KEYWORDS="-* ~amd64"

RDEPEND="sys-apps/bubblewrap
	gnome-base/gconf:2
	x11-libs/gtk+:2[cups]
	x11-libs/gtk+:3[cups]
	x11-libs/libXScrnSaver
	dev-libs/nss
	app-crypt/p11-kit
	sys-apps/lsb-release
"
DEPEND=""
BDEPEND=""

S="${WORKDIR}"

src_install() {
	insinto /opt/"${PN}"
	doins -r opt/apps/"${MY_PN}"/files/*
	fperms +x /opt/"${PN}"/{libnode.so,wechat,resources/{sae.dat,wcs.node}}

	dobin "${FILESDIR}/${PN}"

	insinto /opt/"${PN}"/crap
	doins "${FILESDIR}"/{uos-lsb,uos-release}

	insinto /usr/lib
	doins -r usr/lib/*

	gzip -d usr/share/doc/"${MY_PN}"/*.gz || die
	dodoc usr/share/doc/"${MY_PN}"/changelog*

	for si in 16 48 64 128 256; do
		doicon -s ${si} opt/apps/"${MY_PN}"/entries/icons/hicolor/${si}x${si}/apps/wechat.png
	done
	domenu "${FILESDIR}/${PN}.desktop"
}
