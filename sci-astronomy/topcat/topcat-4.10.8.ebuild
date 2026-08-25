# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop java-pkg-2 xdg
MY_PV=$(ver_rs 2 -)
#MY_PV=${PV}

DESCRIPTION="Interactive graphical viewer and editor for astronomical tables"
HOMEPAGE="http://www.star.bris.ac.uk/~mbt/topcat"
SRC_COM="https://www.star.bris.ac.uk/mbt/releases/topcat/v${MY_PV}"
SRC_URI="${SRC_COM}/${PN}-full.jar -> ${P}-full.jar"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86" #~amd64-linux ~x86-linux"

RDEPEND=">=virtual/jre-1.8"

S="${WORKDIR}"

src_install() {
	java-pkg_newjar {"${DISTDIR}"/${P},${PN}}-full.jar
	java-pkg_dolauncher ${PN}-full --jar ${PN}-full.jar
	dosym ${PN}-full /usr/bin/${PN}

	domenu "${FILESDIR}"/${PN}.desktop
	doicon -s scalable "${FILESDIR}"/${PN}.svg
	doicon -s 72 "${FILESDIR}"/${PN}.png
}
