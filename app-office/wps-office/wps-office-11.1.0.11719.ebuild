# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit unpacker desktop xdg optfeature

MY_PV="$(ver_cut 4)"
MY_P="${PN}_${PV}"
MUI_PV="$(ver_cut 1-3).8865"

DESCRIPTION="WPS Office is an office productivity suite"
HOMEPAGE="https://www.wps.com/office/linux https://www.wps.cn/product/wpslinux http://wps-community.org"

KEYWORDS="~amd64"

SRC_URI="fetch+https://wdl1.pcfg.cache.wpscdn.com/wpsdl/wpsoffice/download/linux/${MY_PV}/${MY_P}.XA_amd64.deb
	fetch+https://github.com/gromko/wps-office-mui/archive/${MUI_PV}.tar.gz -> ${PN}-mui-${MUI_PV}.tar.gz
	cn? ( https://wps-linux-personal.wpscdn.cn/wps/download/ep/Linux2019/${MY_PV}/${MY_P}_amd64.deb )
	l10n_zh-CN? ( https://wps-linux-personal.wpscdn.cn/wps/download/ep/Linux2019/${MY_PV}/${MY_P}_amd64.deb )
"

SLOT="0"
RESTRICT="bindist strip mirror
	cn? ( fetch ) l10n_zh-CN? ( fetch )" # mirror as explained at bug #547372
LICENSE="WPS-EULA"
IUSE="cn +mime libsystemd l10n_zh-CN"
LANGS="de en-GB es-ES es-MX fr fr-CA ja pl pt-BR pt-PT ru th uk zh-HK zh-MO zh-TW"
for X in ${LANGS}; do
	IUSE="${IUSE} l10n_${X}"
done

# Deps got from this (listed in order):
# rpm -qpR wps-office-10.1.0.5707-1.a21.x86_64.rpm
# ldd /opt/kingsoft/wps-office/office6/wps
# ldd /opt/kingsoft/wps-office/office6/wpp
RDEPEND="
	app-arch/bzip2:0
	app-arch/lz4
	app-arch/xz-utils
	dev-libs/expat
	dev-libs/glib:2
	dev-libs/libbsd
	dev-libs/libffi:0/8
	dev-libs/libgcrypt:0
	dev-libs/libgpg-error
	dev-libs/libpcre:3

	dev-qt/qtnetwork:5
	dev-qt/qtwidgets:5

	media-libs/fontconfig:1.0
	media-libs/freetype:2
	media-libs/flac:0/10-12
	media-libs/libogg
	media-libs/libpulse
	media-libs/libsndfile
	media-libs/libvorbis
	media-libs/tiff-compat:4
	net-libs/libasyncns
	net-print/cups
	sys-apps/attr
	sys-apps/tcp-wrappers
	sys-apps/util-linux
	sys-libs/libcap
	libsystemd? ( virtual/libsystemd )
	sys-libs/libcxx
	sys-libs/zlib:0
	virtual/glu
	x11-libs/gtk+:2
	x11-libs/libICE
	x11-libs/libSM
	x11-libs/libX11
	x11-libs/libXau
	x11-libs/libxcb
	x11-libs/libXdmcp
	x11-libs/libXext
	x11-libs/libXrender
	x11-libs/libXtst
"
BDEPEND="app-arch/p7zip"

S="${WORKDIR}"

PATCHES=( "${FILESDIR}/${PN}-11.1.0.11664-fix-wps-python-parse.patch" )

QA_PREBUILT="opt/kingsoft/${PN}/office6/*"
QA_FLAGS_IGNORED="opt/kingsoft/${PN}/office6/*"

_get_source_url_amd64() {
	url="https://wps-linux-personal.wpscdn.cn/wps/download/ep/Linux2019/${MY_PV}/${MY_P}_amd64.deb"
	uri="${url#https://wps-linux-personal.wpscdn.cn}"
	secrityKey='7f8faaaa468174dc1c9cd62e5f218a5b'
	timestamp10=$(date '+%s')
	md5hash=$(echo -n "${secrityKey}${uri}${timestamp10}" | md5sum)
	url+="?t=${timestamp10}&k=${md5hash%% *}"
	echo "$url"
}

pkg_nofetch() {
	ewarn
	ewarn "Downloading url of CN version package cannot be used directly (will get 403 error)."
	ewarn "You need to download it manually from https://www.wps.cn/product/wpslinux website"
	ewarn "and place it in your DISTDIR directory."
	ewarn "Alternatively you can get the source url via the following link:"
	ewarn "$(_get_source_url_amd64)"
	ewarn "And don't forget to rename it as ${MY_P}_amd64.deb then place it in the DISTDIR directory."
	ewarn
}

src_unpack() {
	mkdir ${PN} ${PN}-cn || die
	pushd ${PN} || die
	unpack ${MY_P}.XA_amd64.deb
	unpack ./data.tar.*
	popd || die

	if use cn || use l10n_zh-CN; then
		pushd ${PN}-cn || die
		unpack ${MY_P}_amd64.deb
		unpack ./data.tar.*
		popd || die
	fi

	unpack ${PN}-mui-${MUI_PV}.tar.gz
	pushd ${PN}-mui-${MUI_PV}/mui || die
	for zs in *.7z; do unpack_7z ${zs}; done
	popd || die

	xz -cd "${FILESDIR}/${PN}-11.1.0.11711-lang_list_community.json.xz" > "${S}/lang_list_community.json" || die
}

src_prepare() {
	use cn && PATCHES+=( "${FILESDIR}/${PN}-cn-11.1.0.11664-fix-wps-python-parse.patch" )
	default
}

src_install() {
	local WS="${S}/${PN}$(usev cn '-cn')"

	exeinto /usr/bin
	exeopts -m0755
	doexe ${WS}/usr/bin/*

	insinto /usr/share
	doins -r ${WS}/usr/share/{applications,desktop-directories,icons,fonts,templates}
	use mime && doins -r ${WS}/usr/share/mime

	for _file in ${WS}/usr/share/icons/hicolor/*; do
		if [ -e ${_file}/mimetypes/wps-office2019-etmain.png ]; then
			doicon -s ${_file##/*x} ${_file}/mimetypes/wps-office2019*
		fi
	done

	insinto /opt/kingsoft/wps-office
	use libsystemd || { rm ${WS}/opt/kingsoft/wps-office/office6/libdbus-1.so* || die ; }
	# Fix for icu>=71.1
	rm ${WS}/opt/kingsoft/wps-office/office6/libstdc++.so* || die
	doins -r ${WS}/opt/kingsoft/wps-office/{office6,templates}

	insinto /etc/xdg/menus/applications-merged
	doins ${WS}/etc/xdg/menus/applications-merged/wps-office.menu

	fperms 0755 /opt/kingsoft/wps-office/office6/{wps,wpp,et,wpspdf,wpsoffice,wpsd,promecefpluginhost,transerr,ksolaunch,wpscloudsvr}

	local MUIDIR="opt/kingsoft/wps-office/office6/mui"

	if use cn; then
		use l10n_zh-CN || { rm -r "${ED%/}/${MUIDIR}"/{en_US/resource/help,zh_CN} || die "remove zh_CN support from cn version failed!" ; }
	else
		insinto /${MUIDIR}/en_US/resource
		use l10n_zh-CN && doins -r "${S}/${PN}-cn/${MUIDIR}/en_US/resource/help"
		insinto /${MUIDIR}
		use l10n_zh-CN && doins -r "${S}/${PN}-cn/${MUIDIR}/zh_CN"
	fi
	use l10n_ru || { rm -r "${ED%/}/${MUIDIR}"/ru_RU || die "remove ru_RU support failed!" ; }

	insinto /${MUIDIR}
	LANGF="en-GB es-ES es-MX fr-CA pt-BR pt-PT zh-HK zh-MO zh-TW"
	LANGG="de fr pl th"
	for LU in ${LANGF}; do
		use l10n_${LU} && doins -r "${S}/${PN}-mui-${MUI_PV}/mui/${LU/-/_}"
	done
	for LU in ${LANGG}; do
		use l10n_${LU} && doins -r "${S}/${PN}-mui-${MUI_PV}/mui/${LU}_${LU^^}"
	done
	use l10n_ja && doins -r "${S}/${PN}-mui-${MUI_PV}/mui/ja_JP"
	use l10n_uk && doins -r "${S}/${PN}-mui-${MUI_PV}/mui/uk_UA"

	insinto /${MUIDIR}/lang_list
	doins lang_list_community.json
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
