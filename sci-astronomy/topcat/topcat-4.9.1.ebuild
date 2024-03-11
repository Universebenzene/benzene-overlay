# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop java-pkg-2 xdg
MY_PV=$(ver_rs 2 -)
#MY_PV=${PV}

DESCRIPTION="Interactive graphical viewer and editor for astronomical tables"
HOMEPAGE="http://www.star.bris.ac.uk/~mbt/topcat"
SRC_COM="https://www.star.bris.ac.uk/mbt/releases/topcat/v${MY_PV}"
SRC_URI="${SRC_COM}/${PN}-lite.jar -> ${P}-lite.jar
	standard? ( ${SRC_COM}/${PN}-full.jar -> ${P}-full.jar )
	extra? ( ${SRC_COM}/${PN}-extra.jar -> ${P}-extra.jar )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="minimal +standard extra"
REQUIRED_USE="^^ ( minimal standard extra )"

RDEPEND=">=virtual/jre-1.8"
DEPEND=""

S="${WORKDIR}"

src_install() {
	java-pkg_newjar "${DISTDIR}"/${P}-lite.jar ${PN}-lite.jar
	java-pkg_dolauncher ${PN}-lite
	use !minimal && { java-pkg_newjar "${DISTDIR}"/${P}-$(usex extra extra full).jar ${PN}-$(usex extra extra full).jar; \
		java-pkg_dolauncher ${PN}-$(usex extra extra full) --jar ${PN}-$(usex extra extra full).jar; \
		dosym ${PN}-$(usex extra extra full) /usr/bin/${PN} ; } || dosym ${PN}-lite /usr/bin/${PN}

	domenu "${FILESDIR}"/${PN}.desktop
	doicon -s scalable "${FILESDIR}"/${PN}.svg
	doicon -s 72 "${FILESDIR}"/${PN}.png
}
