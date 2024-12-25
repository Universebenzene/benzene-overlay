# Copyright 2020-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit unpacker desktop xdg

MY_PN="com.${PN/-/.}"

DESCRIPTION="Xunlei download"
HOMEPAGE="https://www.xunlei.com"
SRC_URI="
	amd64? ( https://com-store-packages.uniontech.com/appstore/pool/appstore/c/${MY_PN}/${MY_PN}_${PV}_amd64.deb )
	arm64? ( https://com-store-packages.uniontech.com/appstore/pool/appstore/c/${MY_PN}/${MY_PN}_${PV}_arm64.deb )
"

LICENSE="com.xunlei.download"
SLOT="0"
KEYWORDS="-* ~amd64 ~arm64"

RDEPEND="dev-libs/dbus-glib
	x11-libs/libXtst
	x11-libs/gtk+:2
	x11-libs/libXScrnSaver
	dev-libs/nss
"

S="${WORKDIR}/opt/apps/${MY_PN}"

QA_PREBUILT="opt/${PN}/* opt/${PN}/resources/bin/*"

src_prepare() {
	sed -e '/Cate/s/net/Network/' -e '/^Exec/c Exec=xunlei-download %U' \
		-e '/^Icon/c Icon=com.xunlei.download' -i entries/applications/${MY_PN}.desktop || die
	sed -i "s/apps\/${MY_PN}\/files/${PN}/" files/start.sh || die
	default
}

src_install() {
	insinto /opt/${PN}
	doins -r files/*
	fperms +x /opt/${PN}/{start.sh,thunder,libnode.so,resources/bin/{ThunderHelper.node,ThunderKernel.node}}
	dosym -r /opt/{${PN}/start.sh,bin/${PN}}

	for si in 16 24 32 48 128 256; do
		doicon -s ${si} entries/icons/hicolor/${si}x${si}/apps/${MY_PN}.png
	done
	newicon -s scalable entries/icons/hicolor/scalable/apps/com.thunder.download.svg ${MY_PN}.svg
	domenu entries/applications/${MY_PN}.desktop
}
