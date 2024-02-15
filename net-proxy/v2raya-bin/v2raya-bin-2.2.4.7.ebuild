# Copyright 2021-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PN="${PN/-bin}"

inherit systemd desktop xdg

DESCRIPTION="Web client of Project V for VMess, VLESS, SS, SSR, Trojan & Pingtunnel protocols"
HOMEPAGE="https://github.com/v2rayA/v2rayA"
SRC_URI="
	amd64? ( https://apt.v2raya.org/static/${MY_PN}_linux_x64_${PV} -> ${P}-amd64 )
	x86? ( https://apt.v2raya.org/static/${MY_PN}_linux_x86_${PV} -> ${P}-x86 )
	arm64? ( https://apt.v2raya.org/static/${MY_PN}_linux_arm64_${PV} -> ${P}-arm64 )
	arm? ( https://apt.v2raya.org/static/${MY_PN}_linux_armv7_${PV} -> ${P}-arm )
	https://github.com/v2rayA/v2rayA/archive/refs/tags/v${PV}.tar.gz -> ${MY_PN}-${PV}.tar.gz
"
LICENSE="AGPL-3"
SLOT="0"
KEYWORDS="-* ~amd64 ~arm ~arm64 ~x86"
IUSE="+v2ray xray"
REQUIRED_USE="|| ( v2ray xray )"

DEPEND=""
RDEPEND="${DEPEND}
	v2ray? ( || (
		>=net-proxy/v2ray-5.0.0
		>=net-proxy/v2ray-core-5.0.0
		>=net-proxy/v2ray-bin-5.0.0
		>=net-proxy/v2ray-core-bin-5.0.0
	) )
	xray? ( >=net-proxy/Xray-1.4.2 )
	!xray? ( !net-proxy/Xray )
"
BDEPEND=""

S="${WORKDIR}/v2rayA-${PV}"

QA_PREBUILT="usr/bin/${MY_PN}"

src_install() {
	default
	newbin "${DISTDIR}"/${P}-${ARCH} ${MY_PN}

	newinitd "${FILESDIR}"/${MY_PN}.initd ${MY_PN}
	newinitd "${FILESDIR}"/${MY_PN}-user.initd-r2 ${MY_PN}-user
	newconfd "${FILESDIR}"/${MY_PN}.confd-r3 ${MY_PN}
	newconfd "${FILESDIR}"/${MY_PN}-user.confd-r1 ${MY_PN}-user
	systemd_newunit "${FILESDIR}"/${MY_PN}-r3.service ${MY_PN}.service
	systemd_newuserunit "${FILESDIR}"/${MY_PN}-lite-r1.service ${MY_PN}-lite.service

	newicon -s 512 gui/public/img/icons/android-chrome-512x512.png ${MY_PN}.png
	domenu "${FILESDIR}"/${MY_PN}.desktop

	insinto /etc/default
	newins "${FILESDIR}"/${MY_PN}.conf ${MY_PN}
	"${ED%/}"/usr/bin/v2raya --report config | sed '1,6d' | fold -s -w 78 | sed -E 's/^([^#].+)/# \1/' >> \
		"${ED%/}/etc/default/v2raya" || die
}
