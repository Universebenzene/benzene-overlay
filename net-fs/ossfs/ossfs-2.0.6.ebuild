# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CMAKE_MAKEFILE_GENERATOR="emake"
inherit cmake

DESCRIPTION="Export s3fs for aliyun oss"
HOMEPAGE="https://github.com/aliyun/ossfs
	https://help.aliyun.com/zh/oss/developer-reference/ossfs-2-0
"
SRC_URI="https://github.com/aliyun/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="2"
KEYWORDS="~amd64 ~x86"

export CMAKE_POLICY_VERSION_MINIMUM=3.5

src_prepare() {
	sed -e 's:/usr/local/lib64/ossfs2:/opt/ossfs2/lib64/ossfs2:g' \
		-e 's:/usr/local/bin:/opt/ossfs2/bin:g' -i CMakeLists.txt || die
	cmake_src_prepare
}

#src_configure() {
#	local mycmakeargs=( -DCMAKE_POLICY_VERSION_MINIMUM=3.5 )
#	cmake_src_configure
#}

src_install() {
	cmake_src_install
	dosym -r {/opt/${PN}2/,/usr/}bin/${PN}2
}
