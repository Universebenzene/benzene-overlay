# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PN="${PN%-bin}"
MY_CPN="Aladin"

inherit desktop java-pkg-2 xdg

DESCRIPTION="Interactive software sky atlas"
HOMEPAGE="https://aladin.u-strasbg.fr/aladin.gml"
SRC_URI="https://aladin.u-strasbg.fr/java/${MY_CPN}.tar -> ${P}.tar"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="doc"

RDEPEND=">=virtual/jre-1.8
	!sci-astronomy/aladin
"
DEPEND=""

S="${WORKDIR}/${MY_CPN}"

src_unpack() {
	default
	xz -cd "${FILESDIR}"/${MY_PN}.svg.xz > "${S}"/${MY_PN}.svg || die
}

src_prepare() {
	sed -i -e "/prog/s/\\$\0/\/usr\/share\/${PN}\/lib\/${MY_CPN}.jar/" ${MY_CPN} || die
	default
}

src_install() {
	java-pkg_dojar ${MY_CPN}.jar
	newbin ${MY_CPN} ${MY_PN}

	domenu "${FILESDIR}"/${MY_PN}.desktop
	doicon -s 192 "${FILESDIR}"/${MY_PN}.png
	doicon -s scalable ${MY_PN}.svg
	use doc && HTML_DOCS=( *.html )
	default
}
