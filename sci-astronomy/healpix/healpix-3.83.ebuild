# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools toolchain-funcs java-pkg-opt-2

MYP="Healpix_${PV}"
MYPD=${MYP}_2024Nov13

DESCRIPTION="Hierarchical Equal Area isoLatitude Pixelization of a sphere"
HOMEPAGE="http://healpix.sourceforge.net https://healpix.jpl.nasa.gov"
SRC_URI="https://downloads.sourceforge.net/healpix/${MYP}/${MYPD}.tar.gz"

LICENSE="GPL-2"
SLOT="0/0-4"	# subslot = libchealpix/libhealpix_cxx.so soname version
KEYWORDS="~amd64 ~x86"

# might add fortran in the future if requested
IUSE="cxx doc idl java openmp static-libs test"
RESTRICT="!test? ( test )"

RDEPEND="
	>=sci-libs/cfitsio-3.440:=
	cxx? ( sci-libs/libsharp:= )
	idl? (
		dev-lang/gdl
		sci-astronomy/idlastro
	)
	java? ( >=virtual/jre-1.8:* )
"

BDEPEND="${RDEPEND}
	virtual/pkgconfig
	java? (
		>=dev-java/ant-1.10.14-r3
		>=virtual/jdk-1.8:*
	)
"
#	java? ( >=virtual/jdk-1.8:* test? ( dev-java/ant-junit4:0 ) )

S="${WORKDIR}/${MYP}"

pkg_pretend() {
	use cxx && use openmp && [[ $(tc-getCXX)$ == *g++* ]] && [[ ${MERGE_TYPE} != binary ]] && tc-check-openmp
}

pkg_setup() {
	use cxx && use openmp && [[ $(tc-getCXX)$ == *g++* ]] && [[ ${MERGE_TYPE} != binary ]] && tc-check-openmp
	java-pkg-opt-2_pkg_setup
}

src_prepare() {
	pushd src/C/autotools > /dev/null
	eautoreconf
	popd > /dev/null
	# why was static-libtool-libs forced?
	if use cxx; then
		pushd src/cxx > /dev/null
		eautoreconf
		popd > /dev/null
	fi
	# duplicate of idlastro (in rdeps)
	rm -r src/idl/zzz_external/astron || die
	mv src/idl/zzz_external/README src/idl/README.external || die
	java-pkg-opt-2_src_prepare
	default
}

src_configure() {
	pushd src/C/autotools > /dev/null
	econf $(use_enable static-libs static)
	popd > /dev/null
	if use cxx; then
		pushd src/cxx > /dev/null
		econf \
			--disable-native-optimizations \
			$(use_enable openmp) \
			$(use_enable static-libs static)
		popd > /dev/null
	fi
}

src_compile() {
	pushd src/C/autotools > /dev/null
	emake
	popd > /dev/null
	if use cxx; then
		pushd src/cxx > /dev/null
		emake
		popd > /dev/null
	fi
	if use java; then
		pushd src/java > /dev/null
		eant dist-notest
		popd > /dev/null
	fi
}

src_test() {
	pushd src/C/autotools > /dev/null
	emake check
	popd > /dev/null
	if use cxx; then
		pushd src/cxx > /dev/null
		emake check
		popd > /dev/null
	fi
#	if use java; then
#		pushd src/java > /dev/null
#		EANT_GENTOO_CLASSPATH="ant-junit4" ANT_TASKS="ant-junit4" eant test
#		popd > /dev/null
#	fi
}

src_install() {
	dodoc READ_Copyrights_Licenses.txt
	pushd src/C/autotools > /dev/null
	emake install DESTDIR="${D}"
	popd > /dev/null
	if use cxx; then
		pushd src/cxx > /dev/null
		emake install DESTDIR="${D}"
		popd > /dev/null
	fi
	use static-libs || find "${ED}" -name '*.la' -delete || die
	if use idl; then
		pushd src/idl > /dev/null
		insinto /usr/share/gnudatalanguage/healpix
		doins -r examples fits interfaces misc toolkit visu zzz_external
		doins HEALPix_startup
		docinto idl
		dodoc README.*
		popd > /dev/null
	fi
	if use java; then
		pushd src/java > /dev/null
		java-pkg_dojar dist/*.jar
		docinto java
		dodoc README CHANGES
		popd > /dev/null
	fi
	use doc && dodoc -r doc/html
}
