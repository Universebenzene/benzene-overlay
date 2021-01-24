# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit unpacker desktop xdg

MY_PN="${PN/-bin}"

DESCRIPTION="For creating the most usable Linux/MacOS WeChat client. A.k.a. Freechat"
HOMEPAGE="https://github.com/eNkru/freechat"
SRC_URI="${HOMEPAGE}/releases/download/v${PV}/${MY_PN}_${PV}_amd64.deb"

LICENSE="MIT"
SLOT="0"
RESTRICT="strip"
KEYWORDS="-* ~amd64"

RDEPEND="gnome-base/gconf:2
	x11-libs/libnotify
	x11-libs/libXtst
	x11-libs/gtk+:3[cups]
	x11-libs/libXScrnSaver
	dev-libs/nss
	app-crypt/p11-kit
	!net-im/electron-wechat
"
DEPEND=""
BDEPEND=""

S="${WORKDIR}"

src_prepare() {
	sed -i '/Exec/s/\/opt\/Freechat\///' usr/share/applications/"${MY_PN}".desktop
	default
}

src_install() {
	insinto /opt
	doins -r opt/*
	fperms +x /opt/Freechat/{"${MY_PN}",chrome-sandbox,libEGL.so,libffmpeg.so,libGLESv2.so}
	fperms +x /opt/Freechat/swiftshader/{libEGL.so,libGLESv2.so}
	dosym ../../opt/Freechat/"${MY_PN}" /usr/bin/"${MY_PN}"

	gzip -d usr/share/doc/"${MY_PN}"/*.gz || die
	dodoc usr/share/doc/"${MY_PN}"/*

	for si in 16 32 48 64 128 256 512; do
		doicon -s ${si} usr/share/icons/hicolor/${si}x${si}/apps/"${MY_PN}".png
	done
	domenu usr/share/applications/"${MY_PN}".desktop
}
