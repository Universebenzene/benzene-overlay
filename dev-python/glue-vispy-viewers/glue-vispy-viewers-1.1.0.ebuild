# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

#DISTUTILS_USE_PEP517=setuptools
PYPI_NO_NORMALIZE=1
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1 pypi virtualx

DESCRIPTION="3-d data viewers for glue based on VisPy"
HOMEPAGE="http://docs.glueviz.org/en/stable/gui_guide/3d_viewers.html"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="all +qt"

RDEPEND="dev-python/numpy[${PYTHON_USEDEP}]
	>=dev-python/echo-0.6[${PYTHON_USEDEP}]
	>=dev-python/glue-core-1.13.1[${PYTHON_USEDEP}]
	>=dev-python/glue-qt-0.1.0[${PYTHON_USEDEP}]
	dev-python/matplotlib[${PYTHON_USEDEP}]
	dev-python/pyopengl[${PYTHON_USEDEP}]
	dev-python/qtpy[${PYTHON_USEDEP},designer,gui]
	dev-python/scipy[${PYTHON_USEDEP}]
	>=dev-python/vispy-0.9.1[${PYTHON_USEDEP}]
	all? ( dev-python/imageio[${PYTHON_USEDEP}] )
	qt? ( >=dev-python/pyqt5-5.9[${PYTHON_USEDEP}] )
"
BDEPEND="test? ( dev-python/mock[${PYTHON_USEDEP}] )"

distutils_enable_tests pytest

python_test() {
	virtx epytest
}
