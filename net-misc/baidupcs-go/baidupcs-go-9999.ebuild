# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3 go-module

DESCRIPTION="The terminal utility for Baidu Network Disk (Golang Version)."
HOMEPAGE="https://github.com/qjfoidnh/BaiduPCS-Go"
EGIT_REPO_URI="${HOMEPAGE}.git"

LICENSE="Apache-2.0"
SLOT="0"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}
	!net-misc/baidupcs-go-bin
"

src_unpack() {
	git-r3_src_unpack
	rm -r "${S}/vendor" || die
	go-module_live_vendor
}
src_compile() {
	go build -o ${PN} || die
}

src_install() {
	default
	dobin ${PN}
}
