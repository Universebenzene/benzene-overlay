# Copyright 2021-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake-multilib

DESCRIPTION="A cross-platform (C99/C++11) process library"
HOMEPAGE="https://github.com/fcitx/fcitx5-table-extra"
SRC_URI="https://github.com/DaanDeMeyer/reproc/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0/14"
KEYWORDS="~amd64 ~arm64 ~x86"

PATCHES=( "${FILESDIR}/${P}-fix-gcc13-build.patch" )

multilib_src_configure() {
	local mycmakeargs=(
		-DCMAKE_BUILD_TYPE=Release
		-DCMAKE_INSTALL_PREFIX="${EPREFIX}"/usr
		-DCMAKE_INSTALL_LIBDIR=$(get_libdir)
		-DBUILD_SHARED_LIBS=ON
		-DREPROC++=ON
		-DREPROC_TEST=ON
	)
	cmake_src_configure
}
