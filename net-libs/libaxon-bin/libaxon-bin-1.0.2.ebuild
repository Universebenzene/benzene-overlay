# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PN="${PN/-bin}"

inherit systemd

DESCRIPTION="Nodejs backend for purple-oicq"
HOMEPAGE="https://codeberg.org/goodspeed/axon"
SRC_URI="amd64? ( http://ci.hackflow.org/job/oicq-axon/16/artifact/dist/oicq-axon-linux-x64.gz -> ${P}-amd64.gz )
	arm64? ( http://ci.hackflow.org/job/oicq-axon/16/artifact/dist/oicq-axon-linux-arm64.gz -> ${P}-arm64.gz )
"
LICENSE="Unlicense"
SLOT="0"
RESTRICT="strip"
KEYWORDS="-* ~amd64 ~arm64"
IUSE="+purple"

PDEPEND="purple? ( x11-plugins/purple-oicq[libaxon] )"

S="${WORKDIR}"

QA_PREBUILT="usr/bin/${MY_PN}"

src_install() {
	default
	newbin ${P}-${ARCH} ${MY_PN}
	newinitd "${FILESDIR}"/${MY_PN}-user.initd ${MY_PN}-user
	systemd_newunit "${FILESDIR}"/${MY_PN}_at.service ${MY_PN}@.service
	systemd_newuserunit "${FILESDIR}"/${MY_PN}_user.service ${MY_PN}.service
}

pkg_postinst() {
	elog
	elog "Before using libaxon, you need to start its daemon (<user> below just means your Username):"
	elog "OpenRC:"
	elog "# ln -s /etc/init.d/libaxon-user /etc/init.d/libaxon-user.<user>"
	elog "# /etc/init.d/libaxon-user.<user> start"
	elog "# rc-update add libaxon-user.<user> default"
	elog
	elog "Systemd:"
	elog "# systemctl start libaxon@<user>.service"
	elog "# systemctl enable libaxon@<user>.service"
	elog "or:"
	elog "$ systemctl --user start libaxon.service"
	elog "$ systemctl --user enable libaxon.service"
	elog
}
