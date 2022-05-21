# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{8..10} )

inherit distutils-r1

DESCRIPTION="For multi-dimensional contiguious and non-contiguious coordinate aware arrays"
HOMEPAGE="https://docs.sunpy.org/projects/ndcube"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="plotting reproject"

RDEPEND=">dev-python/numpy-1.17[${PYTHON_USEDEP}]
	>=dev-python/astropy-4.2[${PYTHON_USEDEP}]
	>=dev-python/gwcs-0.15[${PYTHON_USEDEP}]
"
BDEPEND="dev-python/setuptools_scm[${PYTHON_USEDEP}]
	plotting? (
		>=dev-python/matplotlib-3.2[${PYTHON_USEDEP}]
		>=dev-python/mpl-animators-1.0[${PYTHON_USEDEP}]
	)
	reproject? (
		>=dev-python/reproject-0.7.1[${PYTHON_USEDEP}]
	)
	doc? (
		media-gfx/graphviz
	)
	test? (
		dev-python/pytest-doctestplus[${PYTHON_USEDEP}]
		dev-python/mpl-animators[${PYTHON_USEDEP}]
		dev-python/reproject[${PYTHON_USEDEP}]
		dev-python/sunpy[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest
distutils_enable_sphinx docs dev-python/sphinx-automodapi \
	dev-python/sphinx-changelog \
	dev-python/sunpy-sphinx-theme \
	dev-python/matplotlib \
	dev-python/mpl-animators \
	dev-python/pytest-doctestplus

#EPYTEST_DESELECT=(
#	# astropy<=5.0.4 may not compatible with pillow>=9.1.0, which will cause the following test failed:
#	docs/visualization.rst::visualization.rst
#)

python_prepare_all() {
	use doc && { mkdir -p changelog || die ; }

	distutils-r1_python_prepare_all
}
