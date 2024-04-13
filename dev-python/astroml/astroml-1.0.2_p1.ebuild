# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYPI_NO_NORMALIZE=1
PYPI_PN="astroML"
PYTHON_COMPAT=( python3_{10..11} )

inherit distutils-r1 optfeature pypi

DESCRIPTION="Python Machine Learning library for astronomy"
HOMEPAGE="http://www.astroml.org"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="examples"
PROPERTIES="test_network"
RESTRICT="test"

RDEPEND=">=dev-python/numpy-1.13[${PYTHON_USEDEP}]
	>=dev-python/astropy-3.0[${PYTHON_USEDEP}]
	>=dev-python/matplotlib-3.0[${PYTHON_USEDEP}]
	>=dev-python/scipy-0.18[${PYTHON_USEDEP}]
	>=dev-python/scikit-learn-0.18[${PYTHON_USEDEP}]
"
BDEPEND="test? (
		dev-python/pytest-doctestplus[${PYTHON_USEDEP}]
		dev-python/pytest-remotedata[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest

python_prepare_all() {
	sed -i "s/ndimage.filters/ndimage/" astroML/datasets/tools/sdss_fits.py || die

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

python_test() {
	epytest ${PYPI_PN} --remote-data
}

pkg_postinst() {
	optfeature "provides an interface to the HEALPix pixelization scheme, as well as fast spherical harmonic transforms" dev-python/healpy
	optfeature "provides a nice interface for Markov-Chain Monte Carlo" "dev-python/pymc:3<3.11"
}
