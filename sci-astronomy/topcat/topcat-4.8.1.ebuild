# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit desktop java-pkg-2 xdg
MY_PV=$(ver_rs 2 -)

DESCRIPTION="Interactive graphical viewer and editor for astronomical tables"
HOMEPAGE="http://www.star.bris.ac.uk/~mbt/topcat/"
SRC_COM="ftp://andromeda.star.bris.ac.uk/pub/star/${PN}/v${MY_PV}"
SRC_URI="${SRC_COM}/${PN}-lite.jar -> ${P}-lite.jar
	!minimal? ( ${SRC_COM}/${PN}-full.jar -> ${P}-full.jar )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="minimal"

RDEPEND=">=virtual/jre-1.8"
DEPEND=""

S="${WORKDIR}"

src_install() {
	java-pkg_newjar "${DISTDIR}"/${P}-lite.jar ${PN}-lite.jar
	java-pkg_dolauncher ${PN}-lite
	use minimal || ( java-pkg_newjar "${DISTDIR}"/${P}-full.jar ${PN}-full.jar; \
		java-pkg_dolauncher ${PN}-full --jar ${PN}-full.jar )
	dosym ${PN}-$(usex minimal lite full) /usr/bin/${PN}

	domenu "${FILESDIR}"/${PN}.desktop
	doicon -s scalable "${FILESDIR}"/${PN}.svg
	doicon -s 72 "${FILESDIR}"/${PN}.png
}
