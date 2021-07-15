# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit unpacker systemd desktop xdg

MY_PN="${PN%client}"

DESCRIPTION="Sunlogin Remote Control for mobile devices, Win, Mac, Linux, etc. (GUI version)"
HOMEPAGE="https://sunlogin.oray.com"
SRC_URI="https://down.oray.com/${MY_PN}/linux/${P}-amd64.deb"

RESTRICT="mirror"
LICENSE="Sunlogin"
SLOT="0"
KEYWORDS="-* ~amd64"

RDEPEND="dev-libs/libappindicator:3
	x11-apps/xhost
"
DEPEND=""
BDEPEND=""

S="${WORKDIR}/usr"

QA_PREBUILT="opt/${MY_PN}/bin/*"
#QA_DESKTOP_FILE="usr/share/applications/${MY_PN}.desktop"

src_prepare() {
	local LS="${S}/local/${MY_PN}"
	sed -e 's#Icon=/usr/local/sunlogin/res/icon/sunlogin_client.png#Icon=sunloginclient#g' \
		-e 's#Exec=/usr/local/sunlogin/bin/#Exec=#g' -i share/applications/${MY_PN}.desktop || die
	sed -e "s#/usr/local/sunlogin/res/icon/%s.ico\x0#/opt/sunlogin/res/icon/%s.ico\x0\x0\x0\x0\x0\x0\x0#g" \
		-e "s#/usr/local/sunlogin\x0#/opt/sunlogin\x0\x0\x0\x0\x0\x0\x0#g" -i ${LS}/bin/${PN} || die
	sed -i "s#/usr/local/sunlogin\x0#/opt/sunlogin\x0\x0\x0\x0\x0\x0\x0#g" ${LS}/bin/oray_rundaemon || die
	xdg_src_prepare
}

src_install() {
	local LS="${S}/local/${MY_PN}"
	insinto /opt/${MY_PN}
	doins -r ${LS}/{bin,res}
	fperms +x /opt/${MY_PN}/bin/{oray_rundaemon,${PN}}
	fperms 666 /opt/${MY_PN}/res/skin/{desktopcontrol.skin,remotecamera.skin,remotecmd.skin,remotefile.skin,skin.skin}
	dosym {/opt/${MY_PN},/opt}/bin/${PN}

	newinitd "${FILESDIR}"/run${PN}-11.0.0.35346.initd run${PN}
	systemd_dounit "${FILESDIR}"/run${PN}.service

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
	ewarn
	ewarn "For OpenRC+elogind users, remote controlling from others may"
	ewarn "not work on newer version. For OpenRC users please install"
	ewarn "the older version 10.0.2.24779"
	ewarn

	xdg_pkg_postinst
}
