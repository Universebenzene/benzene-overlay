# Copyright 2020-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit unpacker systemd desktop xdg

MY_PN="SunloginClient"
MY_P="${MY_PN}-${PV}"
MY_PPN="${PN%client}"

DESCRIPTION="Sunlogin Remote Control for mobile devices, Win, Mac, Linux, etc. (GUI version)"
HOMEPAGE="https://sunlogin.oray.com"
SRC_URI="http://download.oray.com/sunlogin/linux/${MY_P}_amd64.deb"

RESTRICT="mirror"
LICENSE="Sunlogin"
SLOT="0"
KEYWORDS="-* ~amd64"

RDEPEND="app-text/aspell
	app-text/hunspell
	app-text/nuspell
	dev-libs/libappindicator:3
	dev-libs/libvoikko
	x11-apps/xhost
	virtual/libcrypt:=
"

S="${WORKDIR}/usr"

QA_PREBUILT="opt/${MY_PPN}/bin/*"
#QA_DESKTOP_FILE="usr/share/applications/${MY_PPN}.desktop"

src_prepare() {
	local LS="${S}/local/${MY_PPN}"
	sed -i 's#/usr/local/#/opt/#g' ${LS}/etc/watch.sh || die
	sed -e "s#/usr/local/#/opt/#g" -e '2a\Requires=network-online.target\nAfter=network-online.target' \
		-i ${LS}/scripts/run${PN}.service || die
	sed -e 's#Icon=/usr/local/sunlogin/res/icon/sunlogin_client.png#Icon=sunloginclient#g' \
		-e 's#Exec=/usr/local/sunlogin/bin/#Exec=#g' -i share/applications/${MY_PPN}.desktop || die
	sed -e "s#/usr/local/sunlogin/res/icon/%s.ico\x0#/opt/sunlogin/res/icon/%s.ico\x0\x0\x0\x0\x0\x0\x0#g" \
		-e "s#/usr/local/sunlogin\x0#/opt/sunlogin\x0\x0\x0\x0\x0\x0\x0#g" -i ${LS}/bin/${PN} || die
#	xdg_src_prepare
	default
}

src_install() {
	local LS="${S}/local/${MY_PPN}"
	insinto /opt/${MY_PPN}
	doins -r ${LS}/{bin,etc,res}
	fperms +x /opt/${MY_PPN}/bin/{oray_rundaemon,${PN}}
	fperms 666 /opt/${MY_PPN}/res/font/wqy-zenhei.ttc
	fperms 666 /opt/${MY_PPN}/res/skin/{desktopcontrol.skin,remotecamera.skin,remotecmd.skin,remotefile.skin,skin.skin}
	dosym -r /opt/{${MY_PPN},}/bin/${PN}

	newinitd "${FILESDIR}"/run${P}.initd run${PN}
	systemd_dounit ${LS}/scripts/run${PN}.service

	newicon -s 128 ${LS}/res/icon/sunlogin_client.png ${PN}.png
	domenu share/applications/${MY_PPN}.desktop
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
