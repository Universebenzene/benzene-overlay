# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="C++ binding for gtkspell"
HOMEPAGE="http://gtkspell.sourceforge.net"
SRC_URI="https://downloads.sourceforge.net/gtkspell/${P}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

RDEPEND="app-text/gtkspell:3
	dev-cpp/gtkmm:3.0
"
DEPEND="${RDEPEND}"
BDEPEND="doc? ( app-doc/doxygen )"

src_configure() {
	econf $(use_enable doc documentation)
#	sed -i -e 's/ -shared / -Wl,-O1,--as-needed\0/g' libtool || die
}

src_install() {
	default
	rm -f "${ED%/}"/usr/lib*/lib*.la || die
	use doc && { mv "${ED%/}"/usr/share/doc/{${PN}-3.0,${PF}} || die ; }
}
