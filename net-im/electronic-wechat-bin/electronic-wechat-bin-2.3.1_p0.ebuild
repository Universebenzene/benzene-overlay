# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop xdg optfeature

MY_PN="${PN/-bin}"

DESCRIPTION="A better WeChat on macOS and Linux. Built with Electron"
HOMEPAGE="https://github.com/Riceneeder/electronic-wechat"
SRC_URI="${HOMEPAGE}/releases/download/v$(ver_cut 1-3).fix/${MY_PN}-linux-x64.tar.gz -> ${P}-x64.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="-* ~amd64"

RDEPEND="x11-libs/gtk+:3[cups]
	x11-libs/libXScrnSaver
	dev-libs/nss
	app-crypt/p11-kit
	!net-im/electronic-wechat
"
DEPEND=""

S="${WORKDIR}/${MY_PN}-linux-x64"

src_unpack() {
	default
	xz -cd "${FILESDIR}"/${MY_PN}.svg.xz > "${S}"/${MY_PN}.svg || die
}

src_prepare() {
	sed -e "/Exec/c Exec=${MY_PN}" -e "/Icon/c Icon=${MY_PN}" -e '$a StartupNotify=true' \
		-e '/Cate/s/$/InstantMessaging;Application;/' -i ${MY_PN}.desktop || die
	default
}

src_install() {
	insinto /opt/${PN}
	doins -r .
	fperms +x /opt/${PN}/{${MY_PN},libEGL.so,libffmpeg.so,libGLESv2.so,libvk_swiftshader.so,libvulkan.so.1}
	dosym -r /opt/${PN}/${MY_PN} /usr/bin/${MY_PN}

	domenu ${MY_PN}.desktop
	doicon -s scalable ${MY_PN}.svg
	newicon -s 512 assets/icon.png ${MY_PN}.png
}

pkg_postinst() {
	xdg_pkg_postinst

	optfeature_header "Using native desktop portal:"
	optfeature "GNOME" sys-apps/xdg-desktop-portal-gnome
	optfeature "KDE" kde-plasma/xdg-desktop-portal-kde
	optfeature "LXQt" gui-libs/xdg-desktop-portal-lxqt
}
