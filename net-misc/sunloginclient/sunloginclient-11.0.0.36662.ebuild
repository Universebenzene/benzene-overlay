# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit unpacker systemd desktop xdg

MY_PN="${PN%client}"

DESCRIPTION="Sunlogin Remote Control for mobile devices, Win, Mac, Linux, etc. (GUI version)"
HOMEPAGE="https://sunlogin.oray.com"
SRC_URI="https://down.oray.com/${MY_PN}/linux/${P}-amd64.deb"

RESTRICT="mirror"
LICENSE="Sunlogin"
SLOT="0"
KEYWORDS="-* ~amd64"
IUSE="libsystemd supervise-daemon"

RDEPEND="dev-libs/libappindicator:3
	x11-apps/xhost
	virtual/libcrypt:=
	libsystemd? ( sys-libs/libsystemd )
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

	local scriptx="$(usex supervise-daemon '-super' '')"
	newinitd "${FILESDIR}"/run${PN}-11.0.0.35346${scriptx}.initd run${PN}
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
	if ! use libsystemd; then
		ewarn
		ewarn "For OpenRC users, remote controlling from others may not work with the"
		ewarn "newest version of sunloginclient, as newer versions depends on libsystemd.so"
		ewarn "You can try enabling the libsystemd USE flag to get a trial standalone libsystemd package"
		ewarn "or install the OLDER version 10.0.2.24779 if you use OpenRC system"
		ewarn
	fi
	if use supervise-daemon; then
		ewarn
		ewarn "Users who enable the supervise-daemon USE flag may find that"
		ewarn "runsunloginclient daemon stops automatically after system sleeps and wakes up."
		ewarn "To restart the daemon after waking up automatically you can try this script:"
		ewarn "https://github.com/Universebenzene/dotfiles/blob/master/allconfig/lib64/elogind/system-sleep/rerunsunloginclient"
		ewarn "You can check this link for more details:"
		ewarn "https://wiki.gentoo.org/wiki/Elogind#Hook_scripts_to_be_run_when_suspending.2Fhibernating_and.2For_when_resuming.2Fthawing"
		ewarn
	fi

	xdg_pkg_postinst
}
