# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit unpacker xdg optfeature

MY_PV="$(ver_cut 4)"
MY_P="${PN}_${PV}"
MUI_PV="$(ver_cut 1-3).8865"

DESCRIPTION="WPS Office is an office productivity suite"
HOMEPAGE="http://www.wps.cn/product/wpslinux/ http://wps-community.org/"

KEYWORDS="~amd64"

SRC_URI="http://wdl1.pcfg.cache.wpscdn.com/wpsdl/wpsoffice/download/linux/${MY_PV}/${MY_P}.XA_amd64.deb
	https://wdl1.cache.wps.cn/wps/download/ep/Linux2019/${MY_PV}/${MY_P}_amd64.deb
	https://github.com/gromko/wps-office-mui/archive/${MUI_PV}.tar.gz -> ${PN}-mui-${MUI_PV}.tar.gz
"

SLOT="0"
RESTRICT="strip mirror bindist" # mirror as explained at bug #547372
LICENSE="WPS-EULA"
IUSE="cn +mime l10n_zh-CN"
LANGS="de-DE en-GB es-ES es-MX fr fr-CA ja pl pt-BR pt-PT ru th uk zh-HK zh-MO zh-TW"
for X in ${LANGS}; do
	IUSE="${IUSE} l10n_${X}"
done

# Deps got from this (listed in order):
# rpm -qpR wps-office-10.1.0.5707-1.a21.x86_64.rpm
# ldd /opt/kingsoft/wps-office/office6/wps
# ldd /opt/kingsoft/wps-office/office6/wpp
RDEPEND="
	app-arch/bzip2:0
	app-arch/xz-utils
	app-arch/lz4

	dev-libs/atk

	dev-libs/expat
	dev-libs/glib:2
	dev-libs/libbsd
	|| ( dev-libs/libffi:0/7 dev-libs/libffi-compat:7 )
	dev-libs/libgcrypt:0
	dev-libs/libgpg-error
	dev-libs/libpcre:3

	dev-libs/libxslt

	dev-libs/nspr
	dev-libs/nss

	media-libs/fontconfig:1.0
	media-libs/freetype:2
	media-libs/flac
	media-libs/libogg
	media-libs/libsndfile
	media-libs/libvorbis
	media-libs/libpng:0
	media-sound/pulseaudio
	net-libs/libasyncns
	net-print/cups
	sys-apps/attr
	sys-apps/util-linux
	sys-apps/dbus
	sys-apps/tcp-wrappers
	sys-libs/libcap
	sys-libs/zlib:0

	x11-libs/cairo
	x11-libs/gdk-pixbuf:2
	x11-libs/gtk+:2

	x11-libs/libICE
	x11-libs/libSM
	x11-libs/libX11

	x11-libs/libXScrnSaver

	x11-libs/libXau

	x11-libs/libXcomposite
	x11-libs/libXcursor

	x11-libs/libXdmcp
	x11-libs/libXext
	x11-libs/libXrender
	x11-libs/libXtst

	x11-libs/libXv

	x11-libs/libxcb

	x11-libs/pango

	virtual/glu
"
DEPEND=""
BDEPEND="app-arch/p7zip"

S="${WORKDIR}"

src_unpack() {
	mkdir ${PN} ${PN}-cn || die
	pushd ${PN} || die
	unpack ${MY_P}.XA_amd64.deb
	unpack ./data.tar.*
	popd || die

	pushd ${PN}-cn || die
	unpack ${MY_P}_amd64.deb
	unpack ./data.tar.*
	popd || die

	unpack ${PN}-mui-${MUI_PV}.tar.gz
	pushd ${PN}-mui-${MUI_PV}/mui || die
	for zs in *.7z; do unpack_7z ${zs}; done
	popd || die
}

src_install() {
	local WS="${S}/${PN}$(usex cn '-cn' '')"

	exeinto /usr/bin
	exeopts -m0755
	doexe ${WS}/usr/bin/*

	insinto /usr/share
	doins -r ${WS}/usr/share/{applications,desktop-directories,icons,fonts,templates}
	use mime && doins -r ${WS}/usr/share/mime

	for _file in ${WS}/usr/share/icons/hicolor/*; do
		if [ -e ${_file}/mimetypes/wps-office2019-etmain.png ]; then
			insinto /usr/share/icons/hicolor/${_file##/*/}/apps
			doins ${_file}/mimetypes/wps-office2019*
		fi
	done

	insinto /opt/kingsoft/wps-office
	rm ${WS}/opt/kingsoft/wps-office/office6/libdbus-1.so* || die
	doins -r ${WS}/opt/kingsoft/wps-office/{office6,templates}

	insinto /etc/xdg/menus/applications-merged
	doins ${WS}/etc/xdg/menus/applications-merged/wps-office.menu

	fperms 0755 /opt/kingsoft/wps-office/office6/{wps,wpp,et,wpspdf,wpsoffice,wpsd,parsecloudfiletool,promecefpluginhost,transerr}

	local MUIDIR="opt/kingsoft/wps-office/office6/mui"

	if use cn; then
		use l10n_zh-CN || { rm -r "${ED%/}/${MUIDIR}"/{en_US/resource/help,zh_CN} || die "remove zh_CN support from cn version failed!" ; }
	else
		insinto /${MUIDIR}/en_US/resource
		use l10n_zh-CN && doins -r "${S}/${PN}-cn/${MUIDIR}/en_US/resource/help"
		insinto /${MUIDIR}
		use l10n_zh-CN && doins -r "${S}/${PN}-cn/${MUIDIR}/zh_CN"
	fi

	insinto /${MUIDIR}
	LANGF="de-DE en-GB es-ES es-MX fr-CA pt-BR pt-PT zh-HK zh-MO zh-TW"
	LANGG="fr pl ru th"
	for LU in ${LANGF}; do
		use l10n_${LU} && doins -r "${S}/${PN}-mui-${MUI_PV}/mui/${LU/-/_}"
	done
	for LU in ${LANGG}; do
		use l10n_${LU} && doins -r "${S}/${PN}-mui-${MUI_PV}/mui/${LU}_${LU^^}"
	done
	use l10n_ja && doins -r "${S}/${PN}-mui-${MUI_PV}/mui/ja_JP"
	use l10n_uk && doins -r "${S}/${PN}-mui-${MUI_PV}/mui/uk_UA"
}

pkg_postinst() {
	xdg_pkg_postinst

	elog
	elog "From the version 11.1.0.10702 it's getting harder to switch languages inside the WPS softwares"
	elog "For multi-language users (especially for non en_US or zh_CN users) you need to change the locale outside WPS to switch languages"
	elog "e.g. for Russian users, if you didn't set your system locale as Russian, you can run in the command line:"
	elog "  LANG=ru_RU.UTF-8 wps"
	elog "then you'll get Russian support in WPS Writer."
	elog
	optfeature "FZ TTF fonts provided by wps community " media-fonts/wps-office-fonts
}
