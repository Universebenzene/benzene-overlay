# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# this could be a multiple python package
# but the way it is packaged makes it very time consuming.

PYTHON_COMPAT=( python3_{10..12} )

inherit toolchain-funcs python-single-r1

MYP=${PN}.net-${PV}

DESCRIPTION="Automated astrometric calibration programs and service"
HOMEPAGE="http://astrometry.net"
SRC_URI="https://github.com/dstndstn/astrometry.net/releases/download/${PV}/${MYP}.tar.gz"

LICENSE="BSD GPL-2 GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="examples +netpbm"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND="
	$(python_gen_cond_dep '
		dev-python/astropy[${PYTHON_USEDEP}]
		dev-python/fitsio[${PYTHON_USEDEP}]
		dev-python/numpy[${PYTHON_USEDEP}]
	')
	media-libs/libpng:0
	netpbm? ( media-libs/netpbm )
	sci-astronomy/wcslib:0=
	sci-libs/cfitsio:0=
	sci-libs/gsl:0=
	sys-libs/zlib:0=
	virtual/jpeg:0
	x11-libs/cairo
	${PYTHON_DEPS}"
DEPEND="${RDEPEND}
	dev-lang/swig:0
	virtual/pkgconfig
	netpbm? ( media-libs/netpbm )
"

S="${WORKDIR}/${MYP}"

PATCHES=(
	"${FILESDIR}"/${PN}-0.82-soname.patch
	"${FILESDIR}"/${PN}-0.82-dynlink.patch
)

src_prepare() {
	default
	# respect user compilation flags
	sed -e '/-O3/d' \
		-e '/-fomit-frame-pointer/d' \
		-i util/makefile.common || die

	# compile & link netpbm
	if ! use netpbm; then
		sed -e '/NETPBM_INC/c NETPBM_INC\ :=' \
			-e "/NETPBM_LIB/c NETPBM_LIB\ :=" \
			-i util/makefile.netpbm || die
	fi

	# fix underlinking
	sed -e "s|-lm|-lm $($(tc-getPKG_CONFIG) --libs wcslib gsl)|" \
		-i util/Makefile || die
	export SYSTEM_GSL=yes

	# fix for py3.12
	sed -e "/^from numpy/c import numpy" \
		-e 's/get_numpy_include_dirs()/[numpy.get_include()]/' \
		-i libkd/setup{,-min}.py setup-libkd.py || die
}

src_compile() {
	tc-export CC RANLIB AR
	# disable FLAG autoguessing
	export ARCH_FLAGS=""
	# fragile makefiles, build targets sequentially
	emake
	emake py
	emake extra
	emake report.txt
}

src_test() {
	emake test
	local d
	for d in util blind libkd; do
		pushd ${d} > /dev/null
		./test || die "failed tests in ${d}"
		popd > /dev/null
	done
}

ap_make() {
	emake \
		INSTALL_DIR="${ED%/}/usr" \
		DATA_INSTALL_DIR="${ED%/}/usr/share/astrometry" \
		LIB_INSTALL_DIR="${ED%/}/usr/$(get_libdir)" \
		ETC_INSTALL_DIR="${ED%/}/etc" \
		MAN1_INSTALL_DIR="${ED%/}/usr/share/man/man1" \
		DOC_INSTALL_DIR="${ED%/}/usr/share/doc/${PF}" \
		EXAMPLE_INSTALL_DIR="${ED%/}/usr/share/doc/${PF}/examples" \
		PY_BASE_INSTALL_DIR="${D}/$(python_get_sitedir)/astrometry" \
		PY_BASE_LINK_DIR="../$(python_get_sitedir | sed -e 's|/usr/||')/astrometry" \
		FINAL_DIR="${EPREFIX%/}/usr" \
		DATA_FINAL_DIR="${EPREFIX%/}/usr/share/astrometry" \
		$@
}

src_install() {
	ap_make install-core
	ap_make -C util install
	ap_make -C solver install-extra
	ap_make -C plot install-extra

	# remove duplicates and non installable libraries
	# cfitsio
	rm "${ED}"/usr/bin/{fitscopy,imcopy,listhead} || die
	# cfitsio utilities
	#rm "${ED}"/usr/bin/{fitsverify,imarith,imstat,liststruc,modhead,tablist,tabmerge} || die
	#rm "${ED}"/usr/$(get_libdir)/lib*.a || die
	#rm "${ED}"/usr/share/doc/${PF}/LICENSE || die

	if use examples; then
		docompress -x /usr/share/doc/${PF}/examples
	else
		rm -r "${ED}"/usr/share/doc/${PF}/examples || die
	fi
}
