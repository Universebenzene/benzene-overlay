# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop unpacker xdg optfeature

MY_PN="${PN/-bin}"

DESCRIPTION="A better WeChat on macOS and Linux. Built with Electron"
HOMEPAGE="https://github.com/Riceneeder/electronic-wechat"
SRC_URI="amd64? ( ${HOMEPAGE}/releases/download/v${PV}-6/${MY_PN}_${PV}_amd64.deb )
	arm64? ( ${HOMEPAGE}/releases/download/v${PV}-6/${MY_PN}_${PV}_arm64.deb )
"

LICENSE="MIT"
SLOT="0"
#KEYWORDS="-* ~amd64 ~arm64"

RDEPEND="x11-libs/gtk+:3[cups]
	x11-libs/libXScrnSaver
	dev-libs/nss
	app-crypt/p11-kit
	!net-im/electronic-wechat
"
DEPEND=""

S="${WORKDIR}"

src_unpack() {
	unpacker_src_unpack
	xz -cd "${FILESDIR}"/${MY_PN}.svg.xz > "${S}"/${MY_PN}.svg || die
}

src_prepare() {
	sed -e '/Cate/s/$/InstantMessaging;Application;/' -i usr/share/applications/${MY_PN}.desktop || die
	default
}

src_install() {
	insinto /opt/${PN}
	doins -r usr/lib/${MY_PN}/*
	fperms +x /opt/${PN}/{${MY_PN},libEGL.so,libffmpeg.so,libGLESv2.so,libvk_swiftshader.so,libvulkan.so.1}
	dosym -r /opt/${PN}/${MY_PN} /usr/bin/${MY_PN}

	domenu usr/share/applications/${MY_PN}.desktop
	doicon -s scalable ${MY_PN}.svg
	newicon -s 512 usr/lib/${MY_PN}/assets/icon.png ${MY_PN}.png
	doicon usr/share/pixmaps/${MY_PN}.png
	dodoc usr/share/doc/${MY_PN}/*
}

pkg_postinst() {
	xdg_pkg_postinst

	optfeature "Desktop notifications" x11-libs/libnotify
	optfeature_header "Using native desktop portal:"
	optfeature "GNOME" sys-apps/xdg-desktop-portal-gnome
	optfeature "KDE" kde-plasma/xdg-desktop-portal-kde
	optfeature "LXQt" gui-libs/xdg-desktop-portal-lxqt

	ewarn
	ewarn "Version 2.3.2 is a fixed version by UOS header."
	ewarn "HOWEVER TENCENT WILL PROBABLY LIMIT YOUR ACCOUNT IF YOU USE THIS VERSION."
	ewarn "2.3.1 SHOULD BE MUCH SAFER. SEE HERE FOR MORE INFORMATION:"
	ewarn "https://aur.archlinux.org/packages/electronic-wechat-uos-bin"
	ewarn
}
