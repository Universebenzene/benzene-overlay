# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit unpacker desktop xdg optfeature

MY_PN="${PN/-bin}"
MY_P="${MY_PN}_${PV}"

DESCRIPTION="A Linux client for QQ and more. Previously called Electron QQ"
HOMEPAGE="https://github.com/Clansty/Icalingua"
SRC_URI="amd64? ( ${HOMEPAGE}/releases/download/v${PV}/${MY_P}_amd64.deb )
	x86? ( ${HOMEPAGE}/releases/download/v${PV}/${MY_P}_i386.deb )
	arm64? ( ${HOMEPAGE}/releases/download/v${PV}/${MY_P}_arm64.deb )
"

LICENSE="GPL-3"
SLOT="0"
RESTRICT="strip"
KEYWORDS="-* ~amd64 ~arm64 ~x86"

RDEPEND="x11-libs/gtk+:3[cups]
	x11-libs/libXScrnSaver
	dev-libs/nss
	app-crypt/p11-kit
	dev-libs/libappindicator:3
	app-accessibility/at-spi2-core[X]
	app-crypt/libsecret
	x11-libs/libnotify
"
DEPEND=""
BDEPEND=""

S="${WORKDIR}"

src_install() {
	insinto /opt
	doins -r opt/*
	fperms +x /opt/${MY_PN^}/${MY_PN}
	dosym -r /opt/${MY_PN^}/${MY_PN} /usr/bin/${MY_PN}

	gzip -d usr/share/doc/${MY_PN}/*.gz || die
	dodoc usr/share/doc/${MY_PN}/*

	doicon -s 512 usr/share/icons/hicolor/512x512/apps/${MY_PN}.png
	domenu usr/share/applications/${MY_PN}.desktop
}

pkg_postinst() {
	xdg_pkg_postinst

	optfeature_header "Provide storage:"
	optfeature "Use mongodb" dev-db/mongodb
	optfeature "Use redis" dev-db/redis

	ewarn
	ewarn "For users who get problem after upgrading from 2.3.2 please have a look at this issue:"
	ewarn "https://github.com/Icalingua/Icalingua/issues/322"
	ewarn
}
