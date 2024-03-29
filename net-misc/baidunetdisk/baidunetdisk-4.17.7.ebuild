# Copyright 2023 Gentoo Authors
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

RDEPEND="app-crypt/libsecret
	app-crypt/p11-kit
	dev-libs/nss
	x11-libs/gtk+:3[cups]
	x11-libs/libnotify
	x11-libs/libXScrnSaver
	x11-libs/libXtst
	x11-misc/xdg-utils
"

S="${WORKDIR}"

QA_PREBUILT="opt/${PN}/*"

src_prepare() {
	sed -e "s/Exec=.*/Exec=baidunetdisk %U/g" \
		-e '/Name/a Name[zh_CN]=百度网盘' -i usr/share/applications/${PN}.desktop || die
	default
}

src_install() {
	insinto /opt
	doins -r opt/${PN}
	fperms +x /opt/${PN}/${PN}
	exeinto /opt/bin
	newexe "${FILESDIR}"/${PN}.sh ${PN}

	gzip -d usr/share/doc/${PN}/*.gz || die
	dodoc usr/share/doc/${PN}/*

	domenu usr/share/applications/${PN}.desktop
	doicon -s scalable usr/share/icons/hicolor/scalable/apps/${PN}.svg
}
