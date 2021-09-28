# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

MY_PN="Aladin"

inherit desktop java-pkg-2 xdg

DESCRIPTION="Interactive software sky atlas"
HOMEPAGE="https://aladin.u-strasbg.fr/aladin.gml"
SRC_URI="https://aladin.u-strasbg.fr/java/${MY_PN}.tar -> ${P}.tar"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="doc"

RDEPEND=">=virtual/jre-1.8"
DEPEND=""

S="${WORKDIR}/${MY_PN}"

src_unpack() {
	default
	xz -cd "${FILESDIR}"/${PN}.svg.xz > "${S}"/${PN}.svg || die
}

src_prepare() {
	sed -i -e "/prog/s/\\$\0/\/usr\/share\/${PN}\/lib\/${MY_PN}.jar/" ${MY_PN} || die
	xdg_src_prepare
}

src_install() {
	java-pkg_dojar ${MY_PN}.jar
	newbin ${MY_PN} ${PN}

	domenu "${FILESDIR}"/${PN}.desktop
	doicon -s 192 "${FILESDIR}"/${PN}.png
	doicon -s scalable ${PN}.svg
	use doc && HTML_DOCS=( *.html )
	default
}
