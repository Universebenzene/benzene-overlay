# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PN="${PN/-bin}"

inherit desktop xdg

DESCRIPTION="A graphical management tool developed by Alibaba Cloud"
HOMEPAGE="https://help.aliyun.com/zh/oss/developer-reference/ossbrowser-1
	https://github.com/aliyun/oss-browser
"
SRC_URI="amd64? ( https://gosspublic.alicdn.com/ossbrowser/${PV}/${MY_PN}-linux-x64.zip -> ${P}-amd64.zip )
	x86? ( https://gosspublic.alicdn.com/ossbrowser/${PV}/${MY_PN}-linux-ia32.zip -> ${P}-x86.zip )
"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="-* ~amd64 ~x86"

RDEPEND="media-libs/alsa-lib
	gnome-base/gconf:2
	x11-libs/gtk+:2
	x11-libs/libX11
	x11-libs/libXScrnSaver
	x11-libs/libXtst
"
BDEPEND="app-arch/unzip"

S="${WORKDIR}"

QA_PREBUILT="opt/${MY_PN}/*"

src_install() {
	insinto /opt/${MY_PN}
	doins -r ${MY_PN}-linux-$(usex amd64 'x64' 'ia32')/*
	fperms +x /opt/${MY_PN}/${MY_PN}

	domenu "${FILESDIR}"/${MY_PN}.desktop
}
