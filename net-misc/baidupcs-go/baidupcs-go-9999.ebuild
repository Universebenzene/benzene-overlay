# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PN="BaiduPCS-Go"

inherit go-module-vendor

DESCRIPTION="The terminal utility for Baidu Network Disk (Golang Version)."
HOMEPAGE="https://github.com/qjfoidnh/BaiduPCS-Go"
LICENSE="Apache-2.0"
SLOT="0"

EGIT_REPO_URI="${HOMEPAGE}.git"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3

	src_unpack() {
		git-r3_src_unpack
		go-module-vendor_live_vendor
	}
else
	KEYWORDS="~amd64 ~arm ~arm64 ~x86"
	SRC_URI="${HOMEPAGE}/archive/v${PV}.tar.gz -> ${P}.tar.gz
		https://github.com/Universebenzene/ebuild-vendors/archive/refs/tags/${P}.tar.gz -> ${P}-vendor.tar.gz"

	S="${WORKDIR}/${MY_PN}-${PV}"
	PATCHES=( "${FILESDIR}/${PN}-3.9.6-fix-go-1.23.patch" )
fi

RDEPEND="${DEPEND}
	!net-misc/baidupcs-go-bin
"

src_compile() {
	export GOFLAGS="-buildmode=pie -trimpath"
	export CGO_LDFLAGS="${LDFLAGS}"
	export CGO_CFLAGS="${CFLAGS}"
	export CGO_CPPFLAGS="${CPPFLAGS}"
	ego build -mod vendor -v -work -x -ldflags="-s" -o ${PN}
}

src_install() {
	default
	dobin ${PN}
}
