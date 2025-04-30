# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..13} )

inherit distutils-r1 pypi virtualx

DESCRIPTION="3-d data viewers for glue based on VisPy"
HOMEPAGE="http://docs.glueviz.org/en/stable/gui_guide/3d_viewers.html"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="pyqt pyside"

RDEPEND="dev-python/numpy[${PYTHON_USEDEP}]
	>=dev-python/echo-0.6[${PYTHON_USEDEP}]
	>=dev-python/glue-core-1.13.1[${PYTHON_USEDEP}]
	dev-python/glfw[${PYTHON_USEDEP}]
	dev-python/imageio[${PYTHON_USEDEP}]
	dev-python/matplotlib[${PYTHON_USEDEP}]
	dev-python/pyopengl[${PYTHON_USEDEP}]
	dev-python/scipy[${PYTHON_USEDEP}]
	>=dev-python/vispy-0.12.0[${PYTHON_USEDEP}]
	pyqt? (
		>=dev-python/glue-qt-0.1.0[${PYTHON_USEDEP}]
		dev-python/pyqt6[${PYTHON_USEDEP}]
		dev-python/qtpy[${PYTHON_USEDEP},designer,gui]
	)
	pyside? (
		>=dev-python/glue-qt-0.1.0[${PYTHON_USEDEP}]
		dev-python/pyside:6[${PYTHON_USEDEP}]
		dev-python/qtpy[${PYTHON_USEDEP},designer,gui]
	)
"

distutils_enable_tests pytest

python_test() {
	virtx epytest
}
