# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{8..10} )

inherit distutils-r1 optfeature

DESCRIPTION="Core functionality for performing astrophysics with Python"
HOMEPAGE="https://astropy.org"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"
PROPERTIES="test_network"
# Doc build can't start without disabling network-sandbox
RESTRICT="test
	doc? ( network-sandbox )"

RDEPEND=">=dev-libs/expat-2.2.9:0=
	>=dev-python/numpy-1.18[${PYTHON_USEDEP}]
	>=dev-python/pyerfa-2.0[${PYTHON_USEDEP}]
	>=sci-astronomy/erfa-2.0:0=
	>=sci-astronomy/wcslib-7.7:0=
	>=sci-libs/cfitsio-4.1.0:0=
	>=dev-python/pyyaml-3.13[${PYTHON_USEDEP}]
	>=dev-python/packaging-19.0[${PYTHON_USEDEP}]
	sys-libs/zlib:0=
"
BDEPEND="${RDEPEND}
	dev-python/extension-helpers[${PYTHON_USEDEP}]
	>=dev-python/cython-0.29.28[${PYTHON_USEDEP}]
	>=dev-python/setuptools_scm-6.2[${PYTHON_USEDEP}]
	test? (
		dev-libs/libxml2
		dev-python/asdf[${PYTHON_USEDEP}]
		dev-python/beautifulsoup4[${PYTHON_USEDEP}]
		dev-python/bleach[${PYTHON_USEDEP}]
		dev-python/dask[${PYTHON_USEDEP}]
		dev-python/h5py[${PYTHON_USEDEP}]
		dev-python/ipython[${PYTHON_USEDEP}]
		>=dev-python/jplephem-2.15[${PYTHON_USEDEP}]
		dev-python/matplotlib[${PYTHON_USEDEP}]
		dev-python/objgraph[${PYTHON_USEDEP}]
		dev-python/pandas[${PYTHON_USEDEP}]
		dev-python/pytest-astropy[${PYTHON_USEDEP}]
		dev-python/pytest-mpl[${PYTHON_USEDEP}]
		dev-python/pytest-xdist[${PYTHON_USEDEP}]
		dev-python/scipy[${PYTHON_USEDEP}]
		dev-python/skyfield[${PYTHON_USEDEP}]
	)
	doc? (
		media-gfx/graphviz
		dev-python/sphinx-astropy[${PYTHON_USEDEP}]
		dev-python/sphinx-changelog[${PYTHON_USEDEP}]
		dev-python/scipy[${PYTHON_USEDEP}]
		dev-python/pytest[${PYTHON_USEDEP}]
	)
"

# TODO: Fix this
# NameError: name 'disabled_intersphinx_mapping' is not defined
#distutils_enable_sphinx docs \
#	dev-python/sphinx-astropy \
#	dev-python/pyyaml \
#	dev-python/scipy \
#	dev-python/pytest

distutils_enable_tests pytest

python_configure_all() {
	export ASTROPY_USE_SYSTEM_ALL=1
}

python_compile_all() {
	if use doc; then
		pushd docs || die
		VARTEXFONTS="${T}"/fonts MPLCONFIGDIR="${T}" PYTHONPATH="${BUILD_DIR}"/install/$(python_get_sitedir) \
			emake html
		popd || die
		cp docs/{_static/*,_build/html/_static} || die
		cp docs/{_static/*,_build/html/_images} || die
		HTML_DOCS=( docs/_build/html/. )
	fi
}

python_test() {
	pushd "${BUILD_DIR}/install/$(python_get_sitedir)" || die
	epytest --remote-data --run-slow
	popd || die
}

pkg_postinst() {
	optfeature "power a variety of features in several modules" ">=dev-python/scipy-1.3"
	optfeature "read/write Table objects from/to HDF5 files" dev-python/h5py
	optfeature "read Table objects from HTML files" dev-python/beautifulsoup
	optfeature "read Table objects from HTML files using the pandas reader" dev-python/html5lib
	optfeature "Used to sanitize text when disabling HTML escaping in the Table HTML writer" dev-python/bleach
	optfeature "validate VOTABLE XML files. This is a command line tool installed outside of Python" dev-libs/libxml2
	optfeature "convert Table objects from/to pandas DataFrame objects" dev-python/pandas
	optfeature "Faster SCEngine indexing engine with Table, although this may still be slower in some cases than the \
default indexing engine" dev-python/sortedcontainers
	optfeature "specify and convert between timezones" dev-python/pytz
	optfeature "retrieve JPL ephemeris of Solar System objects" dev-python/jplephem
	optfeature "provide plotting functionality that astropy.visualization enhances" ">dev-python/matplotlib-3.5.2"
	optfeature "discovery of entry points which are used to insert fitters into astropy.modeling.fitting" dev-python/setuptools
	optfeature "the ‘kraft-burrows-nousek’ interval in poisson_conf_interval" dev-python/mpmath
	optfeature "Enables the serialization of various Astropy classes into a portable, hierarchical, human-readable \
representation" ">=dev-python/asdf-2.10.0"
	optfeature "Improves the performance of sigma-clipping and other functionality that may require computing statistics \
on arrays with NaN values." dev-python/bottleneck
	optfeature "downloading files from HTTPS or FTP+TLS sites in case Python is not able to locate up-to-date root CA \
certificates on your system; this package is usually already included in many Python installations (e.g., as a dependency of \
the requests package)." dev-python/certifi
	optfeature "testing with Matplotlib figures" dev-python/pytest-mpl
	optfeature "code coverage measurements" dev-python/coverage
	optfeature "automate testing and documentation builds" dev-python/tox
	optfeature "testing Solar System coordinates" dev-python/skyfield
	optfeature "testing satellite positions" dev-python/sgp4
	optfeature "reading/writing Table objects from/to Parquet files." ">=dev-python/pyarrow-5.0.0"
}
