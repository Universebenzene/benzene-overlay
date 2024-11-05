# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop java-pkg-2 xdg

DESCRIPTION="A GUI front-end of fontconfig"
HOMEPAGE="https://github.com/guoyunhe/fontweak"
SRC_URI="https://github.com/guoyunhe/fontweak/archive/v${PV}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm64"

RDEPEND=">=virtual/jre-1.8"
DEPEND=">=virtual/jdk-1.8"
BDEPEND=">=dev-java/ant-1.10.14-r3"

src_compile() {
	eant jar
}

src_install() {
	default
	java-pkg_dojar dist/${PN}.jar
	java-pkg_dolauncher ${PN}

	domenu ${PN}.desktop
	newicon -s scalable icon.svg ${PN}.svg
}
