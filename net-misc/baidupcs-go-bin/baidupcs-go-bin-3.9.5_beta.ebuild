# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PN="BaiduPCS-Go"
MY_PV="${PV/_/-}"
MY_P="${MY_PN}-v${MY_PV}"

DESCRIPTION="The terminal utility for Baidu Network Disk (Golang Version)."
HOMEPAGE="https://github.com/qjfoidnh/BaiduPCS-Go"
SRC_URI="
	amd64? ( https://github.com/qjfoidnh/${MY_PN}/releases/download/v${MY_PV}/${MY_P}-linux-amd64.zip )
	x86? ( https://github.com/qjfoidnh/${MY_PN}/releases/download/v${MY_PV}/${MY_P}-linux-386.zip )
	arm64? ( https://github.com/qjfoidnh/${MY_PN}/releases/download/v${MY_PV}/${MY_P}-linux-arm64.zip )
	arm? ( https://github.com/qjfoidnh/${MY_PN}/releases/download/v${MY_PV}/${MY_P}-linux-arm.zip )
"
LICENSE="Apache-2.0"
SLOT="0"
#KEYWORDS="-* ~amd64 ~arm ~arm64 ~x86"

DEPEND=""
RDEPEND="${DEPEND}
	!net-misc/baidupcs-go
"
BDEPEND="app-arch/unzip"

S="${WORKDIR}/${MY_P}-linux-${ARCH/x86/386}"

QA_PREBUILT="usr/bin/${PN%-bin}"

src_install() {
	default
	newbin ${MY_PN} ${PN%-bin}
}
