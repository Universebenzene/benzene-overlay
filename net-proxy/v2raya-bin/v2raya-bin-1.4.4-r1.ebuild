# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PN="${PN/-bin}"

inherit systemd desktop xdg

DESCRIPTION="Web client of Project V for VMess, VLESS, SS, SSR, Trojan & Pingtunnel protocols"
HOMEPAGE="https://github.com/v2rayA/v2rayA"
SRC_URI="
	amd64? ( https://apt.v2raya.mzz.pub/pool/main/${MY_PN:0:1}/${MY_PN}/${MY_PN}_linux_x64_v${PV} -> ${P}-amd64 )
	x86? ( https://apt.v2raya.mzz.pub/pool/main/${MY_PN:0:1}/${MY_PN}/${MY_PN}_linux_x86_v${PV} -> ${P}-x86 )
	arm64? ( https://apt.v2raya.mzz.pub/pool/main/${MY_PN:0:1}/${MY_PN}/${MY_PN}_linux_arm64_v${PV} -> ${P}-arm64 )
	arm? ( https://apt.v2raya.mzz.pub/pool/main/${MY_PN:0:1}/${MY_PN}/${MY_PN}_linux_arm_v${PV} -> ${P}-arm )
	https://apt.v2raya.mzz.pub/pool/main/${MY_PN:0:1}/${MY_PN}/web_v${PV}.tar.gz
"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="-* ~amd64 ~arm ~arm64 ~x86"
IUSE="+v2ray xray"
REQUIRED_USE="|| ( v2ray xray )"

DEPEND=""
RDEPEND="${DEPEND}
	v2ray? ( || (
		>=net-proxy/v2ray-4.37.0
		>=net-proxy/v2ray-core-4.37.0
		>=net-proxy/v2ray-bin-4.37.0
	) )
	!v2ray? (
		!net-proxy/v2ray
		!net-proxy/v2ray-core
		!net-proxy/v2ray-bin
	)
	xray? ( >=net-proxy/Xray-1.4.2 )
"
BDEPEND=""

S="${WORKDIR}"

QA_PREBUILT="usr/bin/${MY_PN}"

src_install() {
	default
	newbin "${DISTDIR}"/${P}-${ARCH} ${MY_PN}

	insinto /etc/${MY_PN}
	doins -r web

	newinitd "${FILESDIR}"/${MY_PN}.initd ${MY_PN}
	newconfd "${FILESDIR}"/${MY_PN}.confd ${MY_PN}
	systemd_dounit "${FILESDIR}"/${MY_PN}.service

	newicon -s 512 web/img/icons/android-chrome-512x512.png ${MY_PN}.png
	domenu "${FILESDIR}"/${MY_PN}.desktop
}

pkg_postinst() {
	elog
	elog "Before using v2rayA, you need to start its daemon:"
	elog "OpenRC:"
	elog "# /etc/init.d/v2raya start"
	elog "# rc-update add v2raya default"
	elog
	elog "Systemd:"
	elog "# systemctl start v2raya.service"
	elog "# systemctl enable v2raya.service"
	elog
	elog "Options passed to v2raya daemon can be set in /etc/conf.d/v2raya"
	elog

	xdg_pkg_postinst
}
