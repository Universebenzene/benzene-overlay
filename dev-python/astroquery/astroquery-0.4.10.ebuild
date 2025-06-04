# Copyright 2020-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

#DISTUTILS_USE_SETUPTOOLS=bdepend
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1 optfeature pypi

DESCRIPTION="Collection of packages to access online astronomical resources"
HOMEPAGE="https://astroquery.readthedocs.io"
SRC_URI+=" doc? ( https://irsa.ipac.caltech.edu/data/SPITZER/Enhanced/SEIP/images/6/0095/60095931/4/60095931-14/60095931.60095931-14.IRAC.4.mosaic.fits )
	test? ( https://github.com/astropy/astroquery/raw/refs/tags/v0.4.10/conftest.py -> ${P}-conftest.py )
"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="all doc intersphinx"
PROPERTIES="test_network"
RESTRICT="test
	intersphinx? ( network-sandbox )"
REQUIRED_USE="intersphinx? ( doc )"

RDEPEND=">=dev-python/astropy-5.0[${PYTHON_USEDEP}]
	>=dev-python/beautifulsoup4-4.8[${PYTHON_USEDEP}]
	>=dev-python/html5lib-0.999[${PYTHON_USEDEP}]
	>=dev-python/keyring-15.0[${PYTHON_USEDEP}]
	>=dev-python/numpy-1.20[${PYTHON_USEDEP}]
	>=dev-python/pyvo-1.5[${PYTHON_USEDEP}]
	>=dev-python/requests-2.19[${PYTHON_USEDEP}]
	all? (
		dev-python/astropy-healpix[${PYTHON_USEDEP}]
		dev-python/boto3[${PYTHON_USEDEP}]
		>=dev-python/mocpy-0.12[${PYTHON_USEDEP}]
		>=dev-python/regions-0.5[${PYTHON_USEDEP}]
	)
"
BDEPEND=">=dev-python/astropy-helpers-4.0.1[${PYTHON_USEDEP}]
	doc? (
		${RDEPEND}
		>=dev-python/sphinx-astropy-1.2[${PYTHON_USEDEP}]
		dev-python/aiohttp[${PYTHON_USEDEP}]
		dev-python/fsspec[${PYTHON_USEDEP}]
		dev-python/scipy[${PYTHON_USEDEP}]
		media-gfx/graphviz
	)
	test? (
		dev-python/pytest-astropy[${PYTHON_USEDEP}]
		dev-python/pytest-dependency[${PYTHON_USEDEP}]
		dev-python/pytest-mock[${PYTHON_USEDEP}]
		dev-python/pytest-rerunfailures[${PYTHON_USEDEP}]
		dev-python/boto3[${PYTHON_USEDEP}]
		dev-python/flaky[${PYTHON_USEDEP}]
		dev-python/matplotlib[${PYTHON_USEDEP}]
		dev-python/mocpy[${PYTHON_USEDEP}]
		dev-python/moto[${PYTHON_USEDEP}]
		dev-python/photutils[${PYTHON_USEDEP}]
		dev-python/regions[${PYTHON_USEDEP}]
		net-misc/curl
	)
"

distutils_enable_tests pytest

EPYTEST_DESELECT=(
#	Stucked when network no good
	astroquery/cadc/tests/test_cadctap_remote.py::TestCadcClass::test_query
	"astroquery/esasky/tests/test_esasky_remote.py::TestESASky::test_esasky_get_images[Spitzer]"
	docs/cadc/cadc.rst::cadc.rst
	docs/esa/jwst/jwst.rst::jwst.rst
)

python_prepare_all() {
	sed -i -e '/auto_use/s/True/False/' setup.cfg || die
#	DISTUTILS_ARGS=( --offline )
	use doc && { use intersphinx || { eapply "${FILESDIR}"/${PN}-0.4.10-doc-irsa-offline.patch ; \
		cp "${DISTDIR}"/*.fits docs/ipac/irsa || die ; } ; }
	use test && { cp {"${DISTDIR}"/${P}-,${S}/}conftest.py || die ; }
	distutils-r1_python_prepare_all
}

#python_compile() {
#	distutils-r1_python_compile --use-system-libraries
#}

python_compile_all() {
	if use doc; then
		VARTEXFONTS="${T}"/fonts MPLCONFIGDIR="${T}" PYTHONPATH="${BUILD_DIR}"/lib \
			emake "SPHINXOPTS=$(usex intersphinx '' '-D disable_intersphinx=1')" -C docs html
		HTML_DOCS=( docs/_build/html/. )
	fi
}

python_test() {
	epytest --remote-data
}

pkg_postinst() {
	optfeature "running the tests" "dev-python/pytest-astropy net-misc/curl"
	optfeature "the full functionality of the mocserver, alma, and xmatch module" "dev-python/astropy-healpix dev-python/regions" ">=dev-python/mocpy-0.12"
	optfeature "the full functionality of the mast module"	dev-python/boto3
}
