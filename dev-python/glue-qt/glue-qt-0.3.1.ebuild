# Copyright 2023-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

#DISTUTILS_USE_PEP517=setuptools
PYPI_NO_NORMALIZE=1
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1 desktop pypi virtualx xdg

DESCRIPTION="Multidimensional data visualization across files"
HOMEPAGE="http://glueviz.org"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"	# no x86 KEYWORD for pvextractor, spectral-cube, yt, glueviz
IUSE="+qt"

RDEPEND=">=dev-python/numpy-1.17[${PYTHON_USEDEP}]
	>=dev-python/astropy-4.0[${PYTHON_USEDEP}]
	>=dev-python/echo-0.6[${PYTHON_USEDEP}]
	>=dev-python/glue-core-1.15.0[${PYTHON_USEDEP}]
	>dev-python/ipykernel-5.1.0[${PYTHON_USEDEP}]
	>=dev-python/ipython-4.0[${PYTHON_USEDEP}]
	>=dev-python/matplotlib-3.2[${PYTHON_USEDEP}]
	>=dev-python/pvextractor-0.2[${PYTHON_USEDEP}]
	>dev-python/qtconsole-5.4.2[${PYTHON_USEDEP}]
	>=dev-python/QtPy-1.9[${PYTHON_USEDEP},designer,gui,testlib]
	>=dev-python/scipy-1.1[${PYTHON_USEDEP}]
	>=dev-python/setuptools-30.3.0[${PYTHON_USEDEP}]
	$(python_gen_cond_dep '
		>=dev-python/importlib-metadata-3.6[${PYTHON_USEDEP}]
	' python3_9)
	qt? ( >=dev-python/PyQt5-5.14[${PYTHON_USEDEP}] )
"
BDEPEND="dev-python/setuptools-scm[${PYTHON_USEDEP}]
	test? (
		dev-python/pytest-mpl[${PYTHON_USEDEP}]
		dev-python/pyarrow[${PYTHON_USEDEP}]
		dev-python/PyQt5[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest
distutils_enable_sphinx doc "<dev-python/sphinx-7.2" dev-python/sphinx-automodapi \
	dev-python/sphinxcontrib-spelling \
	dev-python/sphinx-book-theme \
	dev-python/numpydoc

python_install_all() {
	distutils-r1_python_prepare_all
	doicon -s 256 glueviz.png
	domenu glueviz.desktop
}

python_test() {
	virtx epytest
}
