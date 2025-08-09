# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake flag-o-matic

DESCRIPTION="Spell checking for Qt text widgets"
HOMEPAGE="https://github.com/manisandro/qtspell"
SRC_URI="https://github.com/manisandro/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="qt5 +qt6"
REQUIRED_USE="^^ ( qt5 qt6 )"

RDEPEND="app-text/enchant:2
	app-text/iso-codes
"
DEPEND="${RDEPEND}"
BDEPEND="qt5? ( dev-qt/linguist-tools:5 )
	qt6? ( dev-qt/qttools:6[linguist] )
"

src_prepare() {
	filter-flags '-flto*' '-fuse-linker-plugin' '-emit-llvm'
	cmake_src_prepare
}

src_configure() {
	use qt5 && local mycmakeargs=( -DQT_VER=5 )
	use qt6 && local mycmakeargs=( -DQT_VER=6 )
	cmake_src_configure
}
