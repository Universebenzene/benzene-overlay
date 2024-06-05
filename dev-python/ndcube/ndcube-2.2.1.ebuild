# Copyright 2022-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1 pypi

DESCRIPTION="For multi-dimensional contiguious and non-contiguious coordinate aware arrays"
HOMEPAGE="https://docs.sunpy.org/projects/ndcube"
SRC_URI+=" doc? ( http://www.astropy.org/astropy-data/tutorials/FITS-images/HorseHead.fits )"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="examples plotting reproject"

RDEPEND=">dev-python/numpy-1.23.0[${PYTHON_USEDEP}]
	>=dev-python/astropy-5.0.6[${PYTHON_USEDEP}]
	>=dev-python/gwcs-0.18[${PYTHON_USEDEP}]
	plotting? (
		>=dev-python/matplotlib-3.5.0[${PYTHON_USEDEP}]
		>=dev-python/mpl-animators-1.0[${PYTHON_USEDEP}]
	)
	reproject? ( >=dev-python/reproject-0.7.1[${PYTHON_USEDEP}] )
"
BDEPEND="dev-python/setuptools-scm[${PYTHON_USEDEP}]
	doc? ( media-gfx/graphviz )
	test? (
		dev-python/pytest-doctestplus[${PYTHON_USEDEP}]
		dev-python/pytest-mpl[${PYTHON_USEDEP}]
		dev-python/pytest-remotedata[${PYTHON_USEDEP}]
		dev-python/dask[${PYTHON_USEDEP}]
		dev-python/mpl-animators[${PYTHON_USEDEP}]
		dev-python/reproject[${PYTHON_USEDEP}]
		dev-python/sunpy[${PYTHON_USEDEP}]
	)
"
PDEPEND="test? ( dev-python/specutils[${PYTHON_USEDEP}] )"

distutils_enable_tests pytest
distutils_enable_sphinx docs dev-python/sphinx-automodapi \
	">=dev-python/sphinx-changelog-1.1.0" \
	dev-python/sphinx-gallery \
	dev-python/sphinxext-opengraph \
	dev-python/sunpy-sphinx-theme \
	">=dev-python/pytest-doctestplus-0.9.0" \
	">=dev-python/mpl-animators-1.0" \
	">=dev-python/sunpy-5.0.0"

python_prepare_all() {
	use doc && { eapply "${FILESDIR}"/${PN}-2.1.0-doc-use-local-fits.patch ; \
		cp "${DISTDIR}"/*.fits* examples || die ; }

	distutils-r1_python_prepare_all
}

python_install_all() {
	if use examples; then
		docompress -x "/usr/share/doc/${PF}/examples"
		docinto examples
		dodoc -r examples/.
	fi

	distutils-r1_python_install_all
}
