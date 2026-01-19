# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="A very small data compression library"
HOMEPAGE="https://software.schmorp.de/pkg/liblzf.html
	https://oldhome.schmorp.de/marc/liblzf.html
"
SRC_URI="http://dist.schmorp.de/${PN}/${P}.tar.gz"

LICENSE="BSD-2"
SLOT="0/1"
KEYWORDS="~amd64 ~x86"
IUSE="static-libs"

PATCHES=( "${FILESDIR}/${P}-autoconf-20140314.patch" )

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	econf $(use_enable static-libs static)
}

src_install() {
	default
	dosym -r /usr/bin/{,un}lzf
	use static-libs || find "${D}" -name '*.la' -delete || die
}
