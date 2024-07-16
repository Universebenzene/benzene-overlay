# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module
#inherit go-module-vendor

DESCRIPTION="A user friendly command line tool to access AliCloud OSS."
HOMEPAGE="https://help.aliyun.com/zh/oss/developer-reference/ossutil-1
	https://github.com/aliyun/ossutil
"
LICENSE="MIT"
SLOT="0"

EGIT_REPO_URI="https://github.com/aliyun/${PN}.git"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3

	src_unpack() {
		git-r3_src_unpack
		go-module_live_vendor
#		go-module-vendor_live_vendor
	}
else
	KEYWORDS="~amd64 ~arm ~arm64 ~x86"
	SRC_URI="https://github.com/aliyun/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz
		https://github.com/Universebenzene/ebuild-vendors/archive/refs/tags/${P}-deps.tar.gz"
	src_unpack() {
		unpack ${P}-deps.tar.gz
		mv -v ebuild-vendors-${P}-deps/go-mod "${WORKDIR}" || die
		go-module_src_unpack
	}
fi
#		https://github.com/Universebenzene/ebuild-vendors/archive/refs/tags/${P}.tar.gz -> ${P}-vendor.tar.gz"

RDEPEND="${DEPEND}
	!net-misc/ossutil-bin
"

src_compile() {
	ego build -v -work -x
#	ego build -mod vendor -v -work -x
}

src_install() {
	default
	dobin ${PN}
}
