# Copyright 2020-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit unpacker systemd desktop xdg

MY_PN="awesun"
MY_P="${MY_PN}_${PV}"

DESCRIPTION="Sunlogin Remote Control for mobile devices, Win, Mac, Linux, etc. (GUI version)"
HOMEPAGE="https://sunlogin.oray.com"
SRC_URI="amd64? ( https://dw.oray.com/sl/linux/${MY_PN}_${PV}_amd64.deb )"
RESTRICT="mirror strip"
LICENSE="Sunlogin"
SLOT="0"
KEYWORDS="-* ~amd64"
IUSE="keep-server"

RDEPEND="dev-libs/libappindicator:3
	media-libs/libepoxy
	net-libs/webkit-gtk:4.1
	virtual/libcrypt:=
	x11-libs/gtk+:3
	x11-libs/libnotify
"

S="${WORKDIR}/usr"

QA_PREBUILT="opt/${MY_PN}/bin/*"
#QA_DESKTOP_FILE="usr/share/applications/${MY_PN}.desktop"

src_prepare() {
	local LS="${S}/local/${MY_PN}"
	sed -i 's/libwebkit2gtk-4\.0\.so/libwebkit2gtk-0.0.so/g' ${LS}/lib/libwebview_linux_plugin.so || die
	sed -e "s#/usr/local/#/opt/#g" -e '/^Descrip/a Requires=network-online.target\nAfter=network-online.target' \
		-e "/ExecStop/d" -i ${LS}/scripts/run${MY_PN}.service || die
	sed -e "s#Icon=/usr/local/${MY_PN}/${MY_PN}.png#Icon=${PN}#g" \
		-e '/Exec/s#usr/local#opt#' -i share/applications/${MY_PN}.desktop || die
	for BSED in ${LS}/bin/${MY_PN}{,_desktop} ${LS}/bin/plugins/sl*desktop*.so ${LS}/lib/libapp.so; do
		sed -i "s#/usr/local${MY_PN}#///////opt/${MY_PN}#g" ${BSED} || die
	done
	use keep-server || { sed -e "s#/usr/local/${MY_PN}#///////opt/${MY_PN}#g" -i ${LS}/bin/${MY_PN}_daemon || die ; }
	default
}

src_install() {
	local LS="${S}/local/${MY_PN}"
	insinto /opt/${MY_PN}
	doins -r ${LS}/{data,lib}

	insopts -m0755
	doins -r ${LS}/{${MY_PN},bin}
	dosym -r /opt/{${MY_PN},bin}/${MY_PN}
	dosym -r /opt/{${MY_PN}/${MY_PN},bin/${PN}}

	insinto /etc
	newins /dev/null orayconfig.conf

	use keep-server && newinitd "${FILESDIR}"/runawesundaemon.initd runawesundaemon
#	newinitd "${FILESDIR}"/run${PN}-15.2.0.62802$(usex keep-server '-keep' '').initd run${PN}
#	systemd_newunit $(usex keep-server "${FILESDIR}/15.2.0.62802-" "${LS}/scripts/")run${MY_PN}.service run${PN}.service
	newinitd "${FILESDIR}"/run${P}$(usex keep-server '-keep' '').initd run${PN}
	systemd_newunit $(usex keep-server "${FILESDIR}/${PV}-" "${LS}/scripts/")run${MY_PN}.service run${PN}.service

	newicon -s 128 ${LS}/${MY_PN}.png ${PN}.png
	domenu share/applications/${MY_PN}.desktop

	diropts -m0777
	keepdir /var/log/${MY_PN}
}

pkg_postinst() {
	elog
	elog "Before using SunloginClient, you need to start its daemon:"
	elog "OpenRC:"
	elog "# /etc/init.d/runsunloginclient start"
	elog "# rc-update add runsunloginclient default"
	elog
	elog "Systemd:"
	elog "# systemctl start runsunloginclient.service"
	elog "# systemctl enable runsunloginclient.service"
	elog
	elog "You may also need to run \`xhost +\` before remote controlling"
	elog "your computer from others"
	elog

	xdg_pkg_postinst
}
