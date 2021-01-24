# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit desktop xdg

MY_PN="${PN/-bin}"

DESCRIPTION="A better WeChat on macOS and Linux. Built with Electron"
HOMEPAGE="https://github.com/kooritea/electronic-wechat"
SRC_URI="${HOMEPAGE}/releases/download/v${PV}/${P/bin/linux-x64}.zip"

LICENSE="MIT"
SLOT="0"
RESTRICT="strip"
KEYWORDS="-* ~amd64"

RDEPEND="x11-libs/gtk+:3[cups]
	x11-libs/libXScrnSaver
	dev-libs/nss
	app-crypt/p11-kit
	!net-im/electronic-wechat
"
DEPEND=""
BDEPEND=""

S="${WORKDIR}/${MY_PN}-linux-x64"

src_prepare() {
	sed -e "/Exec/c Exec=${MY_PN}" -e "/Icon/c Icon=${MY_PN}" -e '$a StartupNotify=true' \
		-e '/Cate/s/$/InstantMessaging;Application;/' -i "${MY_PN}".desktop || die
	default
}

src_install() {
	insinto /opt/"${PN}"
	doins -r .
	fperms +x /opt/"${PN}"/{"${MY_PN}",libEGL.so,libffmpeg.so,libGLESv2.so,libVkICD_mock_icd.so}
	fperms +x /opt/"${PN}"/swiftshader/{libEGL.so,libGLESv2.so}
	dosym ../../opt/"${PN}"/"${MY_PN}" /usr/bin/"${MY_PN}"

	domenu "${MY_PN}".desktop
	newicon -s 512 assets/icon.png "${MY_PN}".png
}
