# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit unpacker desktop xdg

DESCRIPTION="Baidu Net Disk is a cloud storage client (Linux Version)"
HOMEPAGE="https://pan.baidu.com"
SRC_URI="http://wppkg.baidupcs.com/issue/netdisk/Linuxguanjia/${PV}/${PN}_${PV}_amd64.deb"

LICENSE="BaiduNetDisk"
SLOT="0"
RESTRICT="strip"
KEYWORDS="-* ~amd64"

RDEPEND="x11-libs/gtk+:3[cups]
	x11-libs/libXScrnSaver
	dev-libs/nss
	app-crypt/p11-kit
"
DEPEND=""
BDEPEND=""

S="${WORKDIR}"

QA_PREBUILT="opt/${PN}/*"

src_prepare() {
	sed -i '/Name/a Name[zh_CN]=百度网盘' usr/share/applications/${PN}.desktop || die
	default
}

src_install() {
	insinto /opt
	doins -r opt/${PN}
	fperms +x /opt/${PN}/${PN}
	dosym -r /opt/{${PN}/${PN},bin/${PN}}

	gzip -d usr/share/doc/${PN}/*.gz || die
	dodoc usr/share/doc/${PN}/*

	domenu usr/share/applications/${PN}.desktop
	doicon -s scalable usr/share/icons/hicolor/scalable/apps/${PN}.svg
}
