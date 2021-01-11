# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7..9} )

inherit distutils-r1 optfeature

DESCRIPTION="Core functionality for performing astrophysics with Python"
HOMEPAGE="https://astropy.org"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc test"

RESTRICT="doc? ( network-sandbox )"	# Doc build can't start without disabling network-sandbox

RDEPEND="
	>=dev-libs/expat-2.2.9:0=
	>=dev-python/numpy-1.17.0[${PYTHON_USEDEP}]
	>=dev-python/pyerfa-1.7[${PYTHON_USEDEP}]
	>=sci-astronomy/wcslib-7.3:0=
	>=sci-libs/cfitsio-3.490:0=
	sys-libs/zlib:0=
"
BDEPEND="${RDEPEND}
	dev-python/extension-helpers[${PYTHON_USEDEP}]
	dev-python/cython[${PYTHON_USEDEP}]
	dev-python/jinja[${PYTHON_USEDEP}]
	dev-python/setuptools_scm[${PYTHON_USEDEP}]
	test? (
		dev-libs/libxml2
		dev-python/h5py[${PYTHON_USEDEP}]
		dev-python/ipython[${PYTHON_USEDEP}]
		dev-python/matplotlib[${PYTHON_USEDEP}]
		dev-python/objgraph[${PYTHON_USEDEP}]
		dev-python/pytest-astropy[${PYTHON_USEDEP}]
		dev-python/pytest-xdist[${PYTHON_USEDEP}]
		dev-python/scipy[${PYTHON_USEDEP}]
	)
	doc? (
		media-gfx/graphviz
		dev-python/sphinx-astropy[${PYTHON_USEDEP}]
		dev-python/pyyaml[${PYTHON_USEDEP}]
		dev-python/scipy[${PYTHON_USEDEP}]
		dev-python/pytest[${PYTHON_USEDEP}]
	)
"

PATCHES=( "${FILESDIR}"/${P}-fix-doc-full-version.patch )

# TODO: Fix this
# NameError: name 'disabled_intersphinx_mapping' is not defined
#distutils_enable_sphinx docs \
#	dev-python/sphinx-astropy \
#	dev-python/pyyaml \
#	dev-python/scipy \
#	dev-python/pytest

python_configure_all() {
	export ASTROPY_USE_SYSTEM_ALL=1
}

# Doc build will fail at about 82%
python_compile_all() {
	if use doc; then
		pushd docs || die
		VARTEXFONTS="${T}"/fonts MPLCONFIGDIR="${T}" PYTHONPATH="${BUILD_DIR}"/lib \
			emake html
		popd || die
		cp docs/{_static/*,_build/html/_static} || die
		cp docs/{_static/*,_build/html/_images} || die
		HTML_DOCS=( docs/_build/html/. )
	fi
}

python_test() {
	esetup.py build_ext --inplace
	pytest -vv "${BUILD_DIR}/lib" || die "Tests fail with ${EPYTHON}"
}

pkg_postinst() {
	optfeature "To power a variety of features in several modules" ">=dev-python/scipy-1.1"
	optfeature "To read/write Table objects from/to HDF5 files" dev-python/h5py
	optfeature "To read Table objects from HTML files" dev-python/beautifulsoup
	optfeature "To read Table objects from HTML files using the pandas reader" dev-python/html5lib
	optfeature "Used to sanitize text when disabling HTML escaping in the Table HTML writer" dev-python/bleach
	optfeature "To read/write Table objects from/to the Enhanced CSV ASCII table format nd to serialize mixins \
for various formats" ">=dev-python/pyyaml-3.13"
	optfeature " To validate VOTABLE XML files. This is a command line tool installed outside of Python" dev-libs/libxml2
	optfeature "To convert Table objects from/to pandas DataFrame objects" dev-python/pandas
	optfeature "Faster SCEngine indexing engine with Table, although this may still be slower in some cases than the \
default indexing engine" dev-python/sortedcontainers
	optfeature "To specify and convert between timezones" dev-python/pytz
	optfeature "To retrieve JPL ephemeris of Solar System objects" dev-python/jplephem
	optfeature "To provide plotting functionality that astropy.visualization enhances" ">=dev-python/matplotlib-3.0"
	optfeature "Used for discovery of entry points which are used to insert fitters into \
astropy.modeling.fitting" dev-python/setuptools
	optfeature "Used for the ‘kraft-burrows-nousek’ interval in poisson_conf_interval" dev-python/mpmath
	optfeature "Enables the serialization of various Astropy classes into a portable, hierarchical, human-readable \
representation" ">=dev-python/asdf-2.6.0"
	optfeature "Improves the performance of sigma-clipping and other functionality that may require computing statistics \
on arrays with NaN values." dev-python/bottleneck
	optfeature "Used for testing with Matplotlib figures" dev-python/pytest-mpl
	optfeature "Used for code coverage measurements" dev-python/coverage
	optfeature "Used to automate testing and documentation builds" dev-python/tox
#	skyfield: Used for testing Solar System coordinates.
#	spgp4: Used for testing satellite positions.
}
