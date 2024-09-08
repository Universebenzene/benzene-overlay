# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PN="i4Tools"

inherit unpacker desktop xdg

DESCRIPTION="A third-party tool for managing Apple (iOS) devices"
HOMEPAGE="https://www.i4.cn/pro_pc.html"
SRC_URI="https://d-updater.i4.cn/i4linux/deb/i4tools_v${PV}.deb"

LICENSE="i4"
SLOT="0"
KEYWORDS="~amd64"
#IUSE="fcitx fcitx5 ibus"

RDEPEND="
	app-arch/brotli
	app-pda/usbmuxd
	app-crypt/p11-kit
	dev-libs/expat
	dev-libs/glib:2
	dev-libs/libffi
	dev-libs/openssl
	net-misc/curl
	sys-libs/zlib
"

S="${WORKDIR}"

src_prepare() {
	sed -i -e "/Exec/c Exec=i4tools" -e "/Icon/c Icon=i4tools" usr/share/applications/cn.${MY_PN}.desktop || die
	sed -e '/echo/a \    export LD_LIBRARY_PATH=/opt/i4Tools/lib:$LD_LIBRARY_PATH' \
		-e 's:$CUR_PATH:/opt/i4tools:g' -e 's:\.\/:/opt/i4tools/:' -i opt/apps/cn.${MY_PN}/run.sh || die
	default
}

src_install() {
	local OPD="opt/apps/cn.${MY_PN}"
	insinto /opt/${PN}
	doins -r ${OPD}/{AppRun,doc,files,lib*,package.cfg,qt.conf,resources,translations}

	insopts -m755
	doins -r ${OPD}/{CrashReport,${MY_PN},plugins}
	fperms +x /opt/${PN}/{libexec/QtWebEngineProcess,lib/ossl-modules/legacy.so}

	newbin ${OPD}/run.sh ${PN}
	newicon -s scalable ${OPD}/share/icons/hicolor/scalable/apps/cn.${MY_PN}.svg ${PN}.svg
	newicon ${OPD}/resources/logo.png ${PN}.png
	newmenu usr/share/applications/cn.${MY_PN}.desktop ${PN}.desktop
}
