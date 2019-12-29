# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

MY_PN=${PN}-2
MY_P=${MY_PN}-${PV}

inherit desktop xdg

DESCRIPTION="A small easy-to-use paint program for the GNOME Desktop"
HOMEPAGE="https://savannah.gnu.org/projects/gpaint/"
SRC_URI="mirror://gnu-alpha/${PN}/${MY_P}.tar.gz"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="x11-libs/gdk-pixbuf:2
	gnome-base/libglade:2.0
"
RDEPEND="${DEPEND}"
BDEPEND=""

S=${WORKDIR}/${MY_P}

PATCHES=( "${FILESDIR}" )

src_install() {
	default
	domenu ${PN}.desktop
	doicon ${FILESDIR}/${MY_PN}.xpm
	doicon -s scalable ${FILESDIR}/${MY_PN}.svg
}
