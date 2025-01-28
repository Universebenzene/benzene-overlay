# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DISTUTILS_EXT=1
DISTUTILS_USE_SETUPTOOLS=rdepend
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1 xdg-utils optfeature pypi

DESCRIPTION="Core functionality for performing astrophysics with Python"
HOMEPAGE="https://www.astropy.org/"

LICENSE="BSD"
SLOT="0"
#KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="doc"
#RESTRICT="network-sandbox"
RESTRICT="!test? ( test )"

DEPEND="
	dev-libs/expat:0=
	>=sci-astronomy/erfa-1.4.0:0=
	>=sci-astronomy/wcslib-5.16:0=
	>=sci-libs/cfitsio-3.410:0=
	>=dev-python/jinja2-2.7[${PYTHON_USEDEP}]
	>=dev-python/numpy-1.9.0[${PYTHON_USEDEP}]
"
RDEPEND="${DEPEND}
	dev-python/h5py[${PYTHON_USEDEP}]
	<dev-python/pytest-4.0[${PYTHON_USEDEP}]
	dev-libs/libxml2[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]
	dev-python/scipy[${PYTHON_USEDEP}]
	sys-libs/zlib:0=
"
BDEPEND="
	~dev-python/astropy-helpers-2.0.11[${PYTHON_USEDEP}]
	>=dev-python/cython-0.29.13[${PYTHON_USEDEP}]
	virtual/pkgconfig
	doc? (
		${DEPEND}
		media-gfx/graphviz
		dev-python/pyyaml[${PYTHON_USEDEP}]
		dev-python/pytest[${PYTHON_USEDEP}]
		dev-python/pillow[${PYTHON_USEDEP},jpeg(+)]
		dev-python/scikit-image[${PYTHON_USEDEP}]
		<dev-python/sphinx-2.1[${PYTHON_USEDEP}]
		>=dev-python/sphinx-gallery-0.1.9[${PYTHON_USEDEP}]
	)
	test? (
		${DEPEND}
		<dev-python/pytest-3.7[${PYTHON_USEDEP}]
		dev-python/pytest-mpl[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests setup.py

python_prepare_all() {
	export mydistutilsargs=( --offline )
	rm -r ${PN}_helpers || die
	rm -r cextern/{expat,erfa,cfitsio,wcslib} || die
	sed -i -e '/auto_use/s/True/False/' setup.cfg || die
	cat >> setup.cfg <<-EOF

		[build]
		use_system_libraries=1
	EOF
	xdg_environment_reset
	distutils-r1_python_prepare_all
}

python_compile_all() {
	if use doc; then
		VARTEXFONTS="${T}"/fonts MPLCONFIGDIR="${T}" PYTHONPATH="${BUILD_DIR}"/lib \
			esetup.py build_docs
		HTML_DOCS=( docs/_build/html/. )
	fi
}

pkg_postinst() {
	optfeature "To read Table objects from HTML files"											dev-python/beautifulsoup4
	optfeature "Used to sanitize text when disabling HTML escaping in the Table HTML writer"	dev-python/bleach
	optfeature "To read/write Table objects from/to the Enhanced CSV ASCII table format"		dev-python/pyyaml
	optfeature "To read/write Table objects from/to pandas DataFrame objects"					dev-python/pandas
	optfeature "To specify and convert between timezones"										dev-python/pytz
	optfeature "To retrieve JPL ephemeris of Solar System objects"								dev-python/jplephem
	optfeature "To provide plotting functionality that astropy.visualization enhances"			dev-python/matplotlib
	optfeature "To downsample a data array in astropy.nddata.utils"								dev-python/scikit-image
	optfeature "Used for the ‘kraft-burrows-nousek’ interval in poisson_conf_interval"			dev-python/mpmath
	optfeature "Used only in tests to test for reference leaks"									dev-python/objgraph
#	optfeature	dev-python/ipython
#	optfeature	dev-python/configobj
}
