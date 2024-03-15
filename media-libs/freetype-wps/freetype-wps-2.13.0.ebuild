# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools flag-o-matic libtool

DESCRIPTION="High-quality and portable font engine"
HOMEPAGE="https://www.freetype.org/"
IUSE="X +adobe-cff brotli bzip2 +cleartype-hinting debug fontforge harfbuzz infinality +png svg utils"

MY_PN="freetype"
MY_P="${MY_PN}-${PV}"
MY_PREFIX="/opt/${PN}"
WPS_LIB_DIR="/opt/kingsoft/wps-office/office6"

if [[ "${PV}" != 9999 ]] ; then
	SRC_URI="mirror://sourceforge/freetype/${MY_P/_/}.tar.xz
		mirror://nongnu/freetype/${MY_P/_/}.tar.xz
		utils?	( mirror://sourceforge/freetype/ft2demos-${PV}.tar.xz
			mirror://nongnu/freetype/ft2demos-${PV}.tar.xz )
		doc?	( mirror://sourceforge/freetype/${MY_PN}-doc-${PV}.tar.xz
			mirror://nongnu/freetype/${MY_PN}-doc-${PV}.tar.xz )"
	KEYWORDS="~amd64"
	IUSE+=" doc"
else
	inherit git-r3
fi

LICENSE="|| ( FTL GPL-2+ )"
SLOT="2"

RDEPEND="
	>=sys-libs/zlib-1.2.8-r1
	brotli? ( app-arch/brotli )
	bzip2? ( >=app-arch/bzip2-1.0.6-r4 )
	harfbuzz? ( >=media-libs/harfbuzz-1.3.0[truetype] )
	png? ( >=media-libs/libpng-1.2.51:0= )
	utils? (
		svg? ( >=gnome-base/librsvg-2.46.0 )
		X? ( >=x11-libs/libX11-1.6.2 )
	)
"
DEPEND="${RDEPEND}"
BDEPEND="
	virtual/pkgconfig
"

PATCHES=(
)

_egit_repo_handler() {
	if [[ "${PV}" == 9999 ]] ; then
		local phase="${1}"
		case ${phase} in
			fetch|unpack)
				:;
			;;
			*)
				die "Please use this function with either \"fetch\" or \"unpack\""
			;;
		esac

		local EGIT_REPO_URI
		EGIT_REPO_URI="https://gitlab.freedesktop.org/freetype/freetype.git"
		git-r3_src_${phase}
		if use utils ; then
			EGIT_REPO_URI="https://gitlab.freedesktop.org/freetype/freetype-demos.git"
			local EGIT_CHECKOUT_DIR="${WORKDIR}/ft2demos-${PV}"
			git-r3_src_${phase}
		fi
	else
		default
	fi
}

pkg_pretend() {
	if use svg && ! use utils ; then
		einfo "The \"svg\" USE flag only has effect when the \"utils\" USE flag is also enabled."
	fi
}

src_fetch() {
	_egit_repo_handler ${EBUILD_PHASE}
}

src_unpack() {
	_egit_repo_handler ${EBUILD_PHASE}

	if [[ "${PV}" == 9999 ]] ; then
		# Need to copy stuff from dlg subproject (#758902)
		local dlg_inc_dir="${S}/subprojects/dlg/include/dlg"
		local dlg_src_dir="${S}/subprojects/dlg/src/dlg"
		local dlg_dest_dir="${S}/include"
		mkdir -p "${dlg_dest_dir}/dlg" || die
		cp "${dlg_inc_dir}"/{dlg,output}.h "${dlg_dest_dir}/dlg" || die
		cp "${dlg_src_dir}"/* "${dlg_dest_dir}" || die
	fi
	mv "${WORKDIR}/${MY_PN}-${PV}" "${WORKDIR}/${P}" || die
}

src_prepare() {
	if [[ "${PV}" == 9999 ]] ; then
		# Do NOT automagically mess with submodules!!!
		sed '/setup: copy_submodule/d' -i builds/toplevel.mk || die
		# inspired by shipped autogen.sh script
		eval $(sed -n \
			-e 's/^#define  *\(FREETYPE_MAJOR\)  *\([0-9][0-9]*\).*/\1=\2/p' \
			-e 's/^#define  *\(FREETYPE_MINOR\)  *\([0-9][0-9]*\).*/\1=\2/p' \
			-e 's/^#define  *\(FREETYPE_PATCH\)  *\([0-9][0-9]*\).*/\1=\2/p' \
			include/freetype/freetype.h || die)
		FREETYPE="${FREETYPE_MAJOR}.${FREETYPE_MINOR}"
		[[ "${FREETYPE_PATCH}" != 0 ]] && FREETYPE+=".${FREETYPE_PATCH}"
		pushd builds/unix &>/dev/null || die
		sed -e "s;@VERSION@;${FREETYPE};" \
			< configure.raw > configure.ac || die
		# eautoheader produces broken ftconfig.in
		AT_NOEAUTOHEADER="yes" AT_M4DIR="." eautoreconf
		unset FREETYPE_MAJOR FREETYPE_MINOR FREETYPE_PATCH FREETYPE
		popd &>/dev/null || die
	fi

	default

	pushd builds/unix &>/dev/null || die
	# eautoheader produces broken ftconfig.in
	AT_NOEAUTOHEADER="yes" AT_M4DIR="." eautoreconf
	popd &>/dev/null || die

	# This is the same as the 01 patch from infinality
	sed '/AUX_MODULES += \(gx\|ot\)valid/s@^# @@' -i modules.cfg || die

	enable_option() {
		sed -i -e "/#define $1/ { s:/\* ::; s: \*/:: }" \
			include/${MY_PN}/config/ftoption.h \
			|| die "unable to enable option $1"
	}

	disable_option() {
		sed -i -e "/#define $1/ { s:^:/* :; s:$: */: }" \
			include/${MY_PN}/config/ftoption.h \
			|| die "unable to disable option $1"
	}

	# Will be the new default for >=freetype-2.7.0
	disable_option "TT_CONFIG_OPTION_SUBPIXEL_HINTING  2"

	if use infinality && use cleartype-hinting ; then
		enable_option "TT_CONFIG_OPTION_SUBPIXEL_HINTING  ( 1 | 2 )"
	elif use infinality ; then
		enable_option "TT_CONFIG_OPTION_SUBPIXEL_HINTING  1"
	elif use cleartype-hinting ; then
		enable_option "TT_CONFIG_OPTION_SUBPIXEL_HINTING  2"
	fi

	# Can be disabled with FREETYPE_PROPERTIES="pcf:no-long-family-names=1"
	# via environment (new since v2.8)
	enable_option PCF_CONFIG_OPTION_LONG_FAMILY_NAMES

	# See https://freetype.org/patents.html (expired!)
	enable_option FT_CONFIG_OPTION_SUBPIXEL_RENDERING

	if ! use adobe-cff ; then
		enable_option CFF_CONFIG_OPTION_OLD_ENGINE
	fi

	if use debug ; then
		enable_option FT_DEBUG_LEVEL_TRACE
		enable_option FT_DEBUG_MEMORY
	fi

	if use utils ; then
		cd "${WORKDIR}/ft2demos-${PV}" || die
		# Disable tests needing X11 when USE="-X". (bug #177597)
		if ! use X ; then
			sed -i -e "/EXES\ +=\ ftdiff/ s:^:#:" Makefile || die
		fi
		cd "${S}" || die
	fi

	# bug #869803
	rm docs/reference/sitemap.xml.gz || die

	# we need non-/bin/sh to run configure
	if [[ -n ${CONFIG_SHELL} ]] ; then
		sed -i -e "1s:^#![[:space:]]*/bin/sh:#!${CONFIG_SHELL}:" \
			"${S}"/builds/unix/configure || die
	fi

	elibtoolize --patch-only
}

src_configure() {
	append-flags -fno-strict-aliasing
	type -P gmake &> /dev/null && export GNUMAKE=gmake

	local myeconfargs=(
		--disable-freetype-config
		--enable-shared
		--with-zlib
		--prefix=${MY_PREFIX}
		$(use_with brotli)
		$(use_with bzip2)
		$(use_with harfbuzz)
		$(use_with png)
		$(usex utils $(use_with svg librsvg) --without-librsvg)
	)

	ECONF_SOURCE="${S}" econf "${myeconfargs[@]}"
}

src_install()
{
	LIB_FILE="$(find "${S}" -type f -name 'libfreetype.so*')"
	LIB_FILENAME="$(basename "${LIB_FILE}")"
	insinto ${WPS_LIB_DIR}
	doins "${LIB_FILE}"
	dosym "${LIB_FILENAME}" "${WPS_LIB_DIR}/libfreetype.so.6"
	dosym "${LIB_FILENAME}" "${WPS_LIB_DIR}/libfreetype.so"
	fperms 755 "${WPS_LIB_DIR}/libfreetype.so.6" "${WPS_LIB_DIR}/libfreetype.so"
}
