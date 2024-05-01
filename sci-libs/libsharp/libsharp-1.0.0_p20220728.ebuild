# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools toolchain-funcs

HEALPV="3.82"
MYP="Healpix_${HEALPV}"
MYPD=${MYP}_2022Jul28

DESCRIPTION="Library for fast spherical harmonic transforms"
HOMEPAGE="https://github.com/Libsharp/libsharp https://healpix.jpl.nasa.gov"
SRC_URI="https://downloads.sourceforge.net/healpix/${MYP}/${MYPD}.tar.gz"

LICENSE="GPL-2"
SLOT="0/2"
KEYWORDS="~amd64 ~x86"
IUSE="openmp static-libs test"
RESTRICT="!test? ( test )"

BDEPEND="virtual/pkgconfig"

S="${WORKDIR}/${MYP}/src/common_libraries/${PN}"

pkg_pretend() {
	[[ ${MERGE_TYPE} != binary ]] && use openmp && tc-check-openmp
}

pkg_setup() {
	[[ ${MERGE_TYPE} != binary ]] && use openmp && tc-check-openmp
}

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	econf \
		$(use_enable openmp) \
		$(use_enable static-libs static)
}

src_test() {
	emake check
}

src_install() {
	default
	use static-libs || find "${ED}" -name '*.la' -delete || die
}
