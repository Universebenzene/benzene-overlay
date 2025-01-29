# Copyright 2020-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
PYPI_NO_NORMALIZE=1
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1 optfeature pypi

DESCRIPTION="BSD-licensed HEALPix for Astropy"
HOMEPAGE="http://astropy-healpix.readthedocs.io"
SRC_URI+=" doc? ( https://lambda.gsfc.nasa.gov/data/map/dr3/skymaps/5yr//wmap_band_imap_r9_5yr_K_v3.fits )"

LICENSE="BSD"
SLOT="0"
#KEYWORDS="~amd64 ~x86"
IUSE="doc"
RESTRICT="!test? ( test )"	# Test may abort while running

RDEPEND=">=dev-python/numpy-1.11[${PYTHON_USEDEP}]
	>=dev-python/astropy-2.0[${PYTHON_USEDEP}]
"
BDEPEND="dev-python/astropy-helpers[${PYTHON_USEDEP}]
	doc? (
		${RDEPEND}
		dev-python/sphinx-astropy[${PYTHON_USEDEP}]
	)
	test? (
		${RDEPEND}
		dev-python/pytest-astropy[${PYTHON_USEDEP}]
		dev-python/hypothesis[${PYTHON_USEDEP}]
	)
"

PATCHES=( "${FILESDIR}"/${P}-doc-use-local-fits.patch )

distutils_enable_tests setup.py

python_prepare_all() {
	sed -i -e '/auto_use/s/True/False/' setup.cfg || die
	export DISTUTILS_ARGS=( --offline )
	use doc && { cp "${DISTDIR}"/wmap_band_imap_r9_5yr_K_v3.fits "${S}"/docs || die ; }
	distutils-r1_python_prepare_all
}

python_compile() {
	distutils-r1_python_compile --use-system-libraries
}

python_compile_all() {
	use doc && esetup.py build_docs --no-intersphinx
}

python_install_all() {
	use doc && local HTML_DOCS=( docs/_build/html/. )
	distutils-r1_python_install_all
}

pkg_postinst() {
	optfeature "testing (not really required, and the tests may fail if healpy is installed)" dev-python/healpy
}
