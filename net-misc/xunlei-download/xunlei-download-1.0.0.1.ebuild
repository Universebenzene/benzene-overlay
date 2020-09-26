# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit unpacker desktop xdg

MY_PN="com.${PN/-/.}"
MY_P="${MY_PN}_${PV}"

DESCRIPTION="Xunlei download"
HOMEPAGE="https://www.xunlei.com"
SRC_URI="
	amd64? ( https://cdn-package-store6.deepin.com/appstore/pool/appstore/c/${MY_PN}/${MY_P}_amd64.deb )
	arm64? ( https://cdn-package-store6.deepin.com/appstore/pool/appstore/c/${MY_PN}/${MY_P}_arm64.deb )
"

LICENSE=""
SLOT="0"
KEYWORDS="-* ~amd64 ~arm64"
IUSE=""

RDEPEND="dev-libs/dbus-glib
	net-libs/nodejs
	x11-libs/libXtst
	x11-libs/gtk+:2
	x11-libs/libXScrnSaver
	dev-libs/nss
"
DEPEND=""
BDEPEND=""

S="${WORKDIR}"

QA_PREBUILT="opt/${PN}/* opt/${PN}/resources/bin/*"

src_prepare() {
	sed -i -e '/Cate/s/net/Network/' -e '4c Exec=xunlei-download %U' \
		opt/apps/"${MY_PN}"/entries/applications/"${MY_PN}".desktop || die
	sed -i "s/apps\/${MY_PN}\/files/${PN}/" opt/apps/"${MY_PN}"/files/start.sh || die
	mv opt/apps/"${MY_PN}"/entries/icons/hicolor/scalable/apps/{com.thunder.download.svg,"${MY_PN}".svg} || die
	default
}

src_install() {
	insinto /usr/share
	doins -r opt/apps/"${MY_PN}"/entries/icons

	insinto /opt/"${PN}"
	doins -r opt/apps/"${MY_PN}"/files/*
	fperms +x /opt/"${PN}"/{start.sh,thunder,libnode.so,resources/bin/{ThunderHelper.node,ThunderKernel.node}}

	domenu opt/apps/"${MY_PN}"/entries/applications/"${MY_PN}".desktop
	dosym /opt/"${PN}"/start.sh /usr/bin/"${PN}"
}
