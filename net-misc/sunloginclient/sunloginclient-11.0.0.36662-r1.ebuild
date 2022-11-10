# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit unpacker systemd desktop xdg

MY_PN="${PN%client}"

DESCRIPTION="Sunlogin Remote Control for mobile devices, Win, Mac, Linux, etc. (GUI version)"
HOMEPAGE="https://sunlogin.oray.com"
SRC_URI="amd64? ( https://down.oray.com/${MY_PN}/linux/${P}-amd64.deb )
	arm64? ( https://down.oray.com/${MY_PN}/linux/${P/-/_}_arm.deb )"

RESTRICT="mirror"
LICENSE="Sunlogin"
SLOT="0"
KEYWORDS="-* ~amd64 ~arm64"
IUSE="keep-server systemd"

RDEPEND="dev-libs/libappindicator:3
	x11-apps/xhost
	virtual/libcrypt:=
	virtual/libsystemd[systemd=]
"
DEPEND=""
BDEPEND=""

S="${WORKDIR}/usr"

QA_PREBUILT="opt/${MY_PN}/bin/*"
#QA_DESKTOP_FILE="usr/share/applications/${MY_PN}.desktop"

src_prepare() {
	local LS="${S}/local/${MY_PN}"
	sed -e "s#/usr/local/#/opt/#g" -e '/^Descrip/a Requires=network-online.target\nAfter=network-online.target' \
		-i ${LS}/scripts/run${PN}.service || die
	sed -e 's#Icon=/usr/local/sunlogin/res/icon/sunlogin_client.png#Icon=sunloginclient#g' \
		-e 's#Exec=/usr/local/sunlogin/bin/#Exec=#g' -i share/applications/${MY_PN}.desktop || die
	sed -e "s#/usr/local/sunlogin/res/icon/%s.ico\x0#/opt/sunlogin/res/icon/%s.ico\x0\x0\x0\x0\x0\x0\x0#g" \
		-e "s#/usr/local/sunlogin\x0#/opt/sunlogin\x0\x0\x0\x0\x0\x0\x0#g" -i ${LS}/bin/${PN} || die
	use keep-server || { sed "s#\x48\xB8/usr/loc\x48\x89\x45\xD0\x48\xB8al#\x48\xB8///////o\x48\x89\x45\xD0\x48\xB8pt#g" \
		-i ${LS}/bin/oray_rundaemon || die ; }
#	xdg_src_prepare
	default
}

src_install() {
	local LS="${S}/local/${MY_PN}"
	insinto /opt/${MY_PN}
	doins -r ${LS}/{bin,res}
	fperms +x /opt/${MY_PN}/bin/{oray_rundaemon,${PN}}
	fperms 666 /opt/${MY_PN}/res/skin/{desktopcontrol.skin,remotecamera.skin,remotecmd.skin,remotefile.skin,skin.skin}
	dosym -r /opt/{${MY_PN},}/bin/${PN}

	use keep-server && newinitd "${FILESDIR}"/runoraydaemon.initd runoraydaemon
	newinitd "${FILESDIR}"/run${P}$(usex keep-server '-keep' '').initd run${PN}
	systemd_dounit $(usex keep-server "${FILESDIR}" "${LS}/scripts")/run${PN}.service

	newicon -s 128 ${LS}/res/icon/sunlogin_client.png ${PN}.png
	domenu share/applications/${MY_PN}.desktop
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
	if ! use systemd; then
		ewarn
		ewarn "For OpenRC users, remote controlling from others may not work with the"
		ewarn "newest version of sunloginclient, without libsystemd.so"
		ewarn "We produce a virtual/libsystemd package for you to choose, which is not well tested."
		ewarn "Or you can install the OLDER version 10.0.2.24779 if you use OpenRC system"
		ewarn
	fi

	xdg_pkg_postinst
}
