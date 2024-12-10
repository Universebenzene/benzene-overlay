# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1 virtualx pypi

DESCRIPTION="Matplotlib helpers to make density scatter plots"
HOMEPAGE="https://github.com/astrofrog/mpl-scatter-density"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="examples"

RDEPEND="dev-python/numpy[${PYTHON_USEDEP}]
	>=dev-python/matplotlib-3.0[${PYTHON_USEDEP}]
	>=dev-python/fast-histogram-0.3[${PYTHON_USEDEP}]
"
BDEPEND="dev-python/setuptools-scm[${PYTHON_USEDEP}]
	test? (
		dev-python/pytest-mpl[${PYTHON_USEDEP}]
		dev-python/astropy[${PYTHON_USEDEP}]
		>=dev-python/matplotlib-3.5.2[${PYTHON_USEDEP},qt5]
	)
"

PATCHES=( "${FILESDIR}/${P}-test-fix-new-matplotlib.patch" )

distutils_enable_tests pytest

python_install_all() {
	if use examples; then
		DOCS+=( README.rst images/ )
		docompress -x "/usr/share/doc/${PF}/examples"
		docinto examples
		dodoc -r examples/.
	fi

	distutils-r1_python_install_all
}

python_test() {
	virtx epytest
}
