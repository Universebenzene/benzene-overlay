# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

#DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{9..11} )

inherit distutils-r1 virtualx

DESCRIPTION="3-d data viewers for glue based on VisPy"
HOMEPAGE="http://docs.glueviz.org/en/stable/gui_guide/3d_viewers.html"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+qt"
RESTRICT="test"	# Test phase runs with fails

RDEPEND="dev-python/numpy[${PYTHON_USEDEP}]
	>=dev-python/astropy-4.0[${PYTHON_USEDEP}]
	>=dev-python/glue-core-1.0[${PYTHON_USEDEP}]
	dev-python/matplotlib[${PYTHON_USEDEP}]
	dev-python/pillow[${PYTHON_USEDEP}]
	dev-python/QtPy[${PYTHON_USEDEP},designer,gui]
	dev-python/scipy[${PYTHON_USEDEP}]
	>=dev-python/vispy-0.9.1[${PYTHON_USEDEP}]
	qt? ( >=dev-python/PyQt5-5.9[${PYTHON_USEDEP}] )
"
BDEPEND="test? (
		dev-python/imageio[${PYTHON_USEDEP}]
		dev-python/mock[${PYTHON_USEDEP}]
	)
"

PATCHES=( "${FILESDIR}"/${P}-fix-new-vispy.patch )

distutils_enable_tests pytest

python_prepare_all() {
	grep -rl 'echo.list' ${PN//-/_}/tests/data | xargs sed -i "/echo.list/s/echo.list.CallbackList/echo.CallbackList/" || die

	distutils-r1_python_prepare_all
}

python_test() {
	virtx epytest
}
