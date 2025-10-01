# Copyright 2022-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1 pypi

DESCRIPTION="Core library for the glue multidimensional data visualization project"
HOMEPAGE="http://glueviz.org"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"	# no x86 KEYWORD for spectral-cube, yt, glueviz
IUSE="all astronomy recommended"
REQUIRED_USE="all? ( astronomy recommended )"

RDEPEND=">=dev-python/numpy-1.17[${PYTHON_USEDEP}]
	>=dev-python/astropy-4.0[${PYTHON_USEDEP}]
	>=dev-python/dill-0.2[${PYTHON_USEDEP}]
	>=dev-python/echo-0.6[${PYTHON_USEDEP}]
	>=dev-python/fast-histogram-0.12[${PYTHON_USEDEP}]
	>=dev-python/h5py-2.10[${PYTHON_USEDEP}]
	>=dev-python/ipython-4.0[${PYTHON_USEDEP}]
	>=dev-python/matplotlib-3.2[${PYTHON_USEDEP}]
	>=dev-python/mpl-scatter-density-0.8[${PYTHON_USEDEP}]
	>=dev-python/openpyxl-3.0[${PYTHON_USEDEP}]
	>=dev-python/pandas-1.2[${PYTHON_USEDEP}]
	>=dev-python/scipy-1.1[${PYTHON_USEDEP}]
	>=dev-python/shapely-2.0[${PYTHON_USEDEP}]
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
	recommended? ( dev-python/scikit-image[${PYTHON_USEDEP}] )
"
BDEPEND="dev-python/setuptools-scm[${PYTHON_USEDEP}]
	test? (
		dev-python/astrodendro[${PYTHON_USEDEP}]
		dev-python/dask[${PYTHON_USEDEP}]
		dev-python/pyavm[${PYTHON_USEDEP}]
		dev-python/scikit-image[${PYTHON_USEDEP}]
	)
"

EPYTEST_PLUGINS=( pytest-mpl )
distutils_enable_tests pytest
distutils_enable_sphinx doc dev-python/sphinx-automodapi dev-python/sphinx-book-theme dev-python/numpydoc
