# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module-vendor

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
		go-module-vendor_live_vendor
	}
else
	KEYWORDS="~amd64 ~arm ~arm64 ~x86"
	SRC_URI="https://github.com/aliyun/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz
		https://github.com/Universebenzene/ebuild-vendors/archive/refs/tags/${P}.tar.gz -> ${P}-vendor.tar.gz"
fi

RDEPEND="${DEPEND}
	!net-misc/ossutil-bin
"

src_compile() {
	ego build -mod vendor -v -work -x
}

src_install() {
	default
	dobin ${PN}
}
