# Copyright 2021-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1 pypi

DATA_COM="404adbc"
DATA_URI="https://github.com/sunpy/data/raw/${DATA_COM}/sunpy/v1"

DESCRIPTION="An interative animation framework for matplotlib"
HOMEPAGE="https://sunpy.org"
SRC_URI+=" doc? (
		${DATA_URI}/AIA20110607_063302_0171_lowres.fits -> ${PN}-${DATA_COM}-d-AIA20110607_063302_0171_lowres.fits
		${DATA_URI}/AIA20110607_063307_0193_lowres.fits -> ${PN}-${DATA_COM}-d-AIA20110607_063307_0193_lowres.fits
	)
"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="wcs"

RDEPEND=">=dev-python/matplotlib-3.5.0[${PYTHON_USEDEP}]
	wcs? ( >=dev-python/astropy-5.3.0[${PYTHON_USEDEP}] )
"
BDEPEND="${RDEPEND}
	>=dev-python/setuptools-scm-8.0.0[${PYTHON_USEDEP}]
	doc? ( media-gfx/graphviz )
	test? (
		dev-python/pytest-doctestplus[${PYTHON_USEDEP}]
		dev-python/pytest-mpl[${PYTHON_USEDEP}]
		dev-python/astropy[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest
distutils_enable_sphinx docs dev-python/sphinx-automodapi dev-python/sphinx-changelog dev-python/sphinx-gallery \
	dev-python/sunpy-sphinx-theme \
	dev-python/scipy \
	dev-python/sunpy

python_prepare_all() {
	use doc && { eapply "${FILESDIR}"/${PN}-1.2.1-examples-use-local-fits.patch ; \
		for edat in "${DISTDIR}"/*-d-*; do { cp ${edat} "${S}"/examples/${edat##*-d-} || die ; } ; done ; }

	distutils-r1_python_prepare_all
}

#python_install() {
#	rm -r "${BUILD_DIR}"/install/$(python_get_sitedir)/{docs,examples,licenses} || die
#	distutils-r1_python_install
#}
