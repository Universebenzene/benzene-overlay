# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit unpacker desktop xdg

MY_PN="${PN/-bin}"

DESCRIPTION="A cross-platform QQ made with Electron (Deprecated. Moved to Icalingua)"
HOMEPAGE="https://github.com/Clansty/electron-qq"
SRC_URI="${HOMEPAGE}/releases/download/v${PV}/${MY_PN}_${PV}_amd64.deb"

LICENSE="GPL-3"
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

src_prepare() {
	sed -i '/Exec/s/\/opt\/Electron\ QQ\///' usr/share/applications/${MY_PN}.desktop || die
	xdg_src_prepare
}

src_install() {
	insinto /opt/${MY_PN}
	doins -r opt/Electron\ QQ/*
	fperms +x /opt/${MY_PN}/{${MY_PN},chrome-sandbox,libEGL.so,libffmpeg.so,libGLESv2.so,libvk_swiftshader.so,libvulkan.so.1}
	fperms +x /opt/${MY_PN}/swiftshader/{libEGL.so,libGLESv2.so}
	dosym ../../opt/${MY_PN}/${MY_PN} /usr/bin/${MY_PN}

	gzip -d usr/share/doc/${MY_PN}/*.gz || die
	dodoc usr/share/doc/${MY_PN}/*

	doicon -s 512 usr/share/icons/hicolor/512x512/apps/${MY_PN}.png
	domenu usr/share/applications/${MY_PN}.desktop
}
