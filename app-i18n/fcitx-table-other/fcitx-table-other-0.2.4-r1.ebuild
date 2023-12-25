# Copyright 2012-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake xdg

DESCRIPTION="Provides some other tables for Fcitx"
HOMEPAGE="https://fcitx-im.org https://github.com/fcitx/fcitx-table-other"
SRC_URI="https://download.fcitx-im.org/${PN}/${P}.tar.xz"

LICENSE="GPL-3+"
SLOT="4"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE=""

BDEPEND=">=app-i18n/fcitx-4.2.9:4
	virtual/pkgconfig
"
DEPEND=">=app-i18n/fcitx-4.2.9:4"
RDEPEND="${DEPEND}"

DOCS=( AUTHORS README )

src_prepare() {
	for iconn in icons/fcitx*g; do { mv ${iconn} ${iconn%%-*}4-${iconn#*-} || die ; }; done
	sed -i "s/fcitx-/fcitx4-/g" icons/CMakeLists.txt || die
	cmake_src_prepare
}
