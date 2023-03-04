# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{9..10} )

inherit distutils-r1 optfeature

MY_PN=${PN/-/_}
MY_P=${MY_PN}-${PV}

DESCRIPTION="BSD-licensed HEALPix for Astropy"
HOMEPAGE="http://astropy-healpix.readthedocs.io"
SRC_URI="mirror://pypi/${PN:0:1}/${MY_PN}/${MY_P}.tar.gz
	doc? ( https://lambda.gsfc.nasa.gov/data/map/dr3/skymaps/5yr//wmap_band_imap_r9_5yr_K_v3.fits )"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc intersphinx"
# healpy related tests run with fails
RESTRICT="test
	intersphinx? ( network-sandbox )"
REQUIRED_USE="intersphinx? ( doc )"

DEPEND=">=dev-python/numpy-1.11[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}
	>=dev-python/astropy-3[${PYTHON_USEDEP}]
"
BDEPEND="dev-python/setuptools-scm[${PYTHON_USEDEP}]
	dev-python/extension-helpers[${PYTHON_USEDEP}]
	doc? (
		${RDEPEND}
		dev-python/sphinx-astropy[${PYTHON_USEDEP}]
	)
	test? (
		dev-python/pytest-astropy-header[${PYTHON_USEDEP}]
		dev-python/pytest-doctestplus[${PYTHON_USEDEP}]
		dev-python/hypothesis[${PYTHON_USEDEP}]
		dev-python/healpy[${PYTHON_USEDEP}]
	)
"

S="${WORKDIR}/${MY_P}"

PATCHES=( "${FILESDIR}"/${PN}-0.5-doc-use-local-fits.patch )

distutils_enable_tests pytest
#distutils_enable_sphinx docs dev-python/sphinx-astropy dev-python/astropy

python_prepare_all() {
	use doc && { cp "${DISTDIR}"/wmap_band_imap_r9_5yr_K_v3.fits "${S}"/docs || die ; }
	distutils-r1_python_prepare_all
}

python_compile_all() {
	if use doc; then
		pushd docs || die
		VARTEXFONTS="${T}"/fonts MPLCONFIGDIR="${T}" PYTHONPATH="${BUILD_DIR}"/install/$(python_get_sitedir) \
			emake "SPHINXOPTS=$(usex intersphinx '' '-D disable_intersphinx=1')" html
		popd || die
		HTML_DOCS=( docs/_build/html/. )
	fi
}

python_test() {
	epytest "${BUILD_DIR}"
}

pkg_postinst() {
	optfeature "testing (not really required, and the tests may fail if healpy is installed)" dev-python/healpy
}
