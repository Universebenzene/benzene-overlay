# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PN=LANDrop
MY_P=${MY_PN}-${PV}

inherit qmake-utils xdg

DESCRIPTION="Drop any files to any devices on your LAN"
HOMEPAGE="https://landrop.app"
SRC_URI="https://github.com/${MY_PN}/${MY_PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="dev-libs/libsodium:=
	dev-qt/qtcore:5
	dev-qt/qtconcurrent:5
	dev-qt/qtdbus:5
	dev-qt/qtgui:5
	dev-qt/qtnetwork:5
	dev-qt/qtwidgets:5
"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}/${MY_PN}"

src_configure() {
	PREFIX="/usr" eqmake5
}

src_install() {
	emake INSTALL_ROOT="${D}" install
	dodoc ../README.md
}
