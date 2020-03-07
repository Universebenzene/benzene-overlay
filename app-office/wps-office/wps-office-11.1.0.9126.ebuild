# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit xdg eutils

MY_PV="$(ver_cut 4)"
MY_P="${PN}_${PV}"
MUI_PV="$(ver_cut 1-3).9080"

DESCRIPTION="WPS Office is an office productivity suite"
HOMEPAGE="http://www.wps.cn/product/wpslinux/ http://wps-community.org/"

KEYWORDS="~amd64"

SRC_URI="http://wdl1.pcfg.cache.wpscdn.com/wpsdl/wpsoffice/download/linux/${MY_PV}/${MY_P}.XA_amd64.deb
	https://wdl1.cache.wps.cn/wps/download/ep/Linux2019/${MY_PV}/${MY_P}_amd64.deb
	https://github.com/timxx/wps-office-mui/archive/${MUI_PV}.tar.gz -> ${PN}-mui-${MUI_PV}.tar.gz
"

SLOT="0"
RESTRICT="strip mirror" # mirror as explained at bug #547372
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
	x11-libs/libICE
	x11-libs/libSM
	x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXrender
	x11-libs/libxcb
	media-libs/fontconfig:1.0
	media-libs/freetype:2
	dev-libs/glib:2
	sys-libs/zlib:0
	net-print/cups
	media-libs/libpng-compat:1.2
	virtual/glu

	dev-libs/libpcre:3
	dev-libs/libffi
	media-sound/pulseaudio
	app-arch/bzip2:0
	media-libs/libpng:0
	dev-libs/expat
	sys-apps/util-linux
	dev-libs/libbsd
	x11-libs/libXau
	x11-libs/libXdmcp
	sys-apps/dbus
	x11-libs/libXtst
	sys-apps/tcp-wrappers
	media-libs/libsndfile
	net-libs/libasyncns
	dev-libs/libgcrypt:0
	app-arch/xz-utils
	app-arch/lz4
	sys-libs/libcap
	media-libs/flac
	media-libs/libogg
	media-libs/libvorbis
	dev-libs/libgpg-error
	sys-apps/attr
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
	pushd ${PN}-mui-${MUI_PV} || die
	unpack mui/*.7z
	popd || die
}

src_install() {
	use cn && export WS="${S}/${PN}-cn" || export WS="${S}/${PN}"

	exeinto /usr/bin
	exeopts -m0755
	doexe "${WS}"/usr/bin/wps
	doexe "${WS}"/usr/bin/wpp
	doexe "${WS}"/usr/bin/et
	doexe "${WS}"/usr/bin/wpspdf

	insinto /usr/share
	doins -r "${WS}"/usr/share/{applications,desktop-directories,icons,fonts,templates}
	use mime && doins -r "${WS}"/usr/share/mime

	for _file in ${WS}/usr/share/icons/hicolor/*; do
		if [ -e ${_file}/mimetypes/wps-office2019-etmain.png ]; then
			insinto /usr/share/icons/hicolor/${_file##/*/}/apps
			doins ${_file}/mimetypes/wps-office2019*
		fi
	done

	insinto /opt/kingsoft/wps-office
	doins -r "${WS}"/opt/kingsoft/wps-office/{office6,templates}

	insinto /etc/xdg/menus/applications-merged
	doins "${WS}"/etc/xdg/menus/applications-merged/wps-office.menu

	fperms 0755 /opt/kingsoft/wps-office/office6/{wps,wpp,et,wpspdf,wpsoffice,wpsd,parsecloudfiletool,promecefpluginhost,transerr}

	export MUIDIR="opt/kingsoft/wps-office/office6/mui"

	if use cn; then
		use l10n_zh-CN || ( rm -r "${ED%/}/${MUIDIR}"/{en_US/resource/help,zh_CN} || die "remove zh_CN support from cn version failed!" )
	else
		insinto /"${MUIDIR}"/en_US/resource
		use l10n_zh-CN && doins -r "${S}/${PN}-cn/${MUIDIR}"/en_US/resource/help
		insinto /"${MUIDIR}"
		use l10n_zh-CN && doins -r "${S}/${PN}-cn/${MUIDIR}"/zh_CN
	fi

	insinto /"${MUIDIR}"
	LANGF="de-DE en-GB es-ES es-MX fr-CA pt-BR pt-PT zh-HK zh-MO zh-TW"
	LANGG="fr pl ru th"
	for LU in ${LANGF}; do
		use l10n_${LU} && doins -r "${S}/${PN}-mui-${MUI_PV}"/"${LU/-/_}"
	done
	for LU in ${LANGG}; do
		use l10n_${LU} && doins -r "${S}/${PN}-mui-${MUI_PV}"/"${LU}_${LU^^}"
	done
	use l10n_ja && doins -r "${S}/${PN}-mui-${MUI_PV}"/ja_JP
	use l10n_uk && doins -r "${S}/${PN}-mui-${MUI_PV}"/uk_UA
}

pkg_postinst() {
	xdg_pkg_postinst
	optfeature "FZ TTF fonts provided by wps community "	media-fonts/wps-office-fonts
}
