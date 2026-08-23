# Copyright 2021-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PN="${PN/-bin}"

inherit systemd desktop unpacker xdg

DESCRIPTION="Web client of Project V for VMess, VLESS, SS, SSR, Trojan & Pingtunnel protocols"
HOMEPAGE="https://github.com/v2rayA/v2rayA"
SRC_URI="
	amd64? ( https://github.com/v2rayA/v2rayA/releases/download/v${PV}/installer_archlinux_x64_${PV}.pkg.tar.zst )
	x86? ( https://github.com/v2rayA/v2rayA/releases/download/v${PV}/installer_archlinux_x86_${PV}.pkg.tar.zst )
	arm64? ( https://github.com/v2rayA/v2rayA/releases/download/v${PV}/installer_archlinux_arm64_${PV}.pkg.tar.zst )
	arm? ( https://github.com/v2rayA/v2rayA/releases/download/v${PV}/installer_archlinux_armv7_${PV}.pkg.tar.zst )
	loong? ( https://github.com/v2rayA/v2rayA/releases/download/v${PV}/installer_archlinux_loongarch64_${PV}.pkg.tar.zst )
	riscv? ( https://github.com/v2rayA/v2rayA/releases/download/v${PV}/installer_archlinux_riscv64_${PV}.pkg.tar.zst )
"
LICENSE="AGPL-3"
SLOT="0"
KEYWORDS="-* ~amd64 ~arm ~arm64 ~loong ~riscv ~x86"

RDEPEND="app-alternatives/v2ray-geoip
	app-alternatives/v2ray-geosit
"

S="${WORKDIR}"

QA_PREBUILT="usr/bin/${MY_PN}*"

src_install() {
	default
	dobin usr/bin/*

	newinitd "${FILESDIR}"/${MY_PN}.initd ${MY_PN}
	newconfd "${FILESDIR}"/${MY_PN}.confd-r4 ${MY_PN}
	exeinto /etc/user/init.d
	newexe "${FILESDIR}"/${MY_PN}-user.initd-r3 ${MY_PN}-user
	insinto /etc/user/conf.d
	newins "${FILESDIR}"/${MY_PN}-user.confd-r2 ${MY_PN}-user
	systemd_dounit usr/lib/systemd/system/${MY_PN}.service
	systemd_douserunit usr/lib/systemd/user/${MY_PN}-lite.service

	doicon -s 512 usr/share/icons/hicolor/512x512/apps/${MY_PN}.png
	domenu usr/share/applications/${MY_PN}.desktop

	dosym -r /usr/share/v2ray{,a}/geoip.dat
	dosym -r /usr/share/v2ray{,a}/geosite.dat

	insinto /etc/default
	doins etc/default/${MY_PN}
}
