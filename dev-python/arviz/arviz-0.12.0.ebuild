# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{8..10} )

inherit distutils-r1

DESCRIPTION="Exploratory analysis of Bayesian models with Python"
HOMEPAGE="https://python.arviz.org"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="all examples"
PROPERTIES="test_network"
RESTRICT="test"	# missing tests data

RDEPEND=">=dev-python/numpy-1.12[${PYTHON_USEDEP}]
	dev-python/netcdf4-python[${PYTHON_USEDEP}]
	dev-python/packaging[${PYTHON_USEDEP}]
	>=dev-python/pandas-0.23[${PYTHON_USEDEP}]
	>=dev-python/scipy-0.19[${PYTHON_USEDEP}]
	>=dev-python/setuptools-38.4[${PYTHON_USEDEP}]
	>=dev-python/matplotlib-3.0[${PYTHON_USEDEP}]
	>=dev-python/typing-extensions-3.7.4.3[${PYTHON_USEDEP}]
	>=dev-python/xarray-0.16.1[${PYTHON_USEDEP}]
	all? (
		<dev-python/bokeh-3.0[${PYTHON_USEDEP}]
		dev-python/cmdstanpy[${PYTHON_USEDEP}]
		dev-python/numba[${PYTHON_USEDEP}]
		dev-python/ujson[${PYTHON_USEDEP}]
		dev-python/distributed[${PYTHON_USEDEP}]
		>=dev-python/zarr-2.5.0[${PYTHON_USEDEP}]
	)
"
BDEPEND="test? (
		dev-python/bokeh[${PYTHON_USEDEP}]
		dev-python/cloudpickle[${PYTHON_USEDEP}]
		dev-python/numba[${PYTHON_USEDEP}]
		dev-python/ujson[${PYTHON_USEDEP}]
		media-video/ffmpeg
	)
"

distutils_enable_tests pytest

EPYTEST_IGNORE=(
	# PyMC3 unusable now
	arviz/tests/external_tests/test_data_pymc.py
)
