# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYPI_NO_NORMALIZE=1
PYTHON_COMPAT=( python3_{10..11} )

inherit distutils-r1 desktop pypi virtualx xdg

DESCRIPTION="Linked Data Visualizations Across Multiple Files"
HOMEPAGE="http://glueviz.org"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"	# no x86 KEYWORD for pvextractor, spectral-cube, yt, glueviz
IUSE="all astronomy +qt recommended"
REQUIRED_USE="all? ( astronomy recommended )"

RDEPEND=">dev-python/numpy-1.17[${PYTHON_USEDEP}]
	>=dev-python/astropy-4.0[${PYTHON_USEDEP}]
	>=dev-python/dill-0.2[${PYTHON_USEDEP}]
	>=dev-python/echo-0.6[${PYTHON_USEDEP}]
	>=dev-python/h5py-2.10[${PYTHON_USEDEP}]
	>dev-python/ipykernel-5.1.0[${PYTHON_USEDEP}]
	>=dev-python/ipython-4.0[${PYTHON_USEDEP}]
	>=dev-python/matplotlib-3.2[${PYTHON_USEDEP}]
	>=dev-python/mpl-scatter-density-0.7[${PYTHON_USEDEP}]
	>=dev-python/openpyxl-3.0[${PYTHON_USEDEP}]
	>=dev-python/pandas-1.2[${PYTHON_USEDEP}]
	>=dev-python/pvextractor-0.2[${PYTHON_USEDEP}]
	>=dev-python/qtconsole-4.3[${PYTHON_USEDEP}]
	>=dev-python/QtPy-1.9[${PYTHON_USEDEP},designer,gui,testlib]
	>=dev-python/scipy-1.1[${PYTHON_USEDEP}]
	>=dev-python/setuptools-30.3.0[${PYTHON_USEDEP}]
	>=dev-python/xlrd-1.2[${PYTHON_USEDEP}]
	$(python_gen_cond_dep '
		>=dev-python/importlib-metadata-3.6[${PYTHON_USEDEP}]
	' python3_9)
	all? ( >dev-python/pillow-7.1.0[${PYTHON_USEDEP}] )
	astronomy? (
		dev-python/pyavm[${PYTHON_USEDEP}]
		dev-python/astrodendro[${PYTHON_USEDEP}]
		dev-python/spectral-cube[${PYTHON_USEDEP}]
	)
	qt? ( >=dev-python/PyQt5-5.14[${PYTHON_USEDEP}] )
	recommended? ( sci-libs/scikit-image[${PYTHON_USEDEP}] )
"
BDEPEND="dev-python/setuptools-scm[${PYTHON_USEDEP}]
	test? (
		dev-python/pytest-mpl[${PYTHON_USEDEP}]
		dev-python/astrodendro[${PYTHON_USEDEP}]
		dev-python/dask[${PYTHON_USEDEP}]
		dev-python/pyavm[${PYTHON_USEDEP}]
		sci-libs/scikit-image[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest
distutils_enable_sphinx doc dev-python/sphinx-automodapi \
	dev-python/sphinxcontrib-spelling \
	dev-python/sphinx-rtd-theme \
	dev-python/numpydoc

python_install_all() {
	distutils-r1_python_prepare_all
	doicon -s 256 glueviz.png
	domenu glueviz.desktop
}

python_test() {
	virtx epytest
}
