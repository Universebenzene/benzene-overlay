# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit unpacker desktop xdg

MY_PN="${PN/-fr-bin/_fr}"

DESCRIPTION="Daily French Listening software from eusoft"
HOMEPAGE="https://www.eudic.net/v4/fr/app/ting"
SRC_URI="https://static.frdic.com/pkg/${MY_PN}/${MY_PN}.deb -> ${P/-bin}_amd64.deb"

LICENSE="eudic"
SLOT="0"
RESTRICT="strip"
KEYWORDS="-* ~amd64"

RDEPEND="x11-libs/gtk+:3[cups]
	x11-libs/libXScrnSaver
	dev-libs/nss
	app-crypt/p11-kit
	dev-libs/libappindicator:3
"
DEPEND=""
BDEPEND=""

S="${WORKDIR}"

src_prepare() {
	sed -i "/Exec/c Exec=${PN/-bin}\ \%U" usr/share/applications/${MY_PN}.desktop || die
	default
}

src_install() {
	local CPN=$(ls opt/)
	insinto /opt/${PN/-bin}
	doins -r opt/${CPN}/*
	fperms +x /opt/${PN/-bin}/{${MY_PN},libEGL.so,libffmpeg.so,libGLESv2.so,libvk_swiftshader.so,libvulkan.so,chrome-sandbox,swiftshader/{libEGL.so,libGLESv2.so}}
	dosym -r /opt/${PN/-bin}/${MY_PN} /usr/bin/${PN/-bin}

	gzip -d usr/share/doc/${PN/-bin}/*.gz || die
	dodoc usr/share/doc/${PN/-bin}/*

	for si in 32 128 256; do
		doicon -s ${si} usr/share/icons/hicolor/${si}x${si}/apps/${MY_PN}.png
	done
	domenu usr/share/applications/${MY_PN}.desktop
}
