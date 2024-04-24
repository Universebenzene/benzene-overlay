# Copyright 2022-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..11} )

inherit distutils-r1

DESCRIPTION="Exploratory analysis of Bayesian models with Python"
HOMEPAGE="https://python.arviz.org"
SRC_URI="https://github.com/arviz-devs/arviz/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE="all examples"
PROPERTIES="test_network"
RESTRICT="test"

RDEPEND=">=dev-python/numpy-1.23.0[${PYTHON_USEDEP}]
	|| ( >=dev-python/dm-tree-0.1.8[${PYTHON_USEDEP}] >=dev-python/dm-tree-bin-0.1.8[${PYTHON_USEDEP}] )
	>=dev-python/h5netcdf-1.0.2[${PYTHON_USEDEP}]
	>=dev-python/matplotlib-3.5[${PYTHON_USEDEP}]
	dev-python/packaging[${PYTHON_USEDEP}]
	>=dev-python/pandas-1.5.0[${PYTHON_USEDEP}]
	>=dev-python/scipy-1.9.0[${PYTHON_USEDEP}]
	>=dev-python/setuptools-60.0.0[${PYTHON_USEDEP}]
	>=dev-python/typing-extensions-4.1.0[${PYTHON_USEDEP}]
	>=dev-python/xarray-2022.6.0[${PYTHON_USEDEP}]
	>=dev-python/xarray-einstats-0.3[${PYTHON_USEDEP}]
	all? (
		<dev-python/bokeh-3.0[${PYTHON_USEDEP}]
		dev-python/contourpy[${PYTHON_USEDEP}]
		dev-python/netcdf4[${PYTHON_USEDEP}]
		dev-python/numba[${PYTHON_USEDEP}]
		dev-python/ujson[${PYTHON_USEDEP}]
		dev-python/distributed[${PYTHON_USEDEP}]
		dev-python/xarray-datatree[${PYTHON_USEDEP}]
		>=dev-python/zarr-2.5.0[${PYTHON_USEDEP}]
	)
"
BDEPEND="test? (
		dev-python/bokeh[${PYTHON_USEDEP}]
		dev-python/cloudpickle[${PYTHON_USEDEP}]
		dev-python/cmdstanpy[${PYTHON_USEDEP}]
		dev-python/emcee[${PYTHON_USEDEP}]
		dev-python/netcdf4[${PYTHON_USEDEP}]
		dev-python/numba[${PYTHON_USEDEP}]
		dev-python/xarray-datatree[${PYTHON_USEDEP}]
		dev-python/zarr[${PYTHON_USEDEP}]
		media-video/ffmpeg
	)
"

distutils_enable_tests pytest

EPYTEST_IGNORE=(
	# ValueError: no option named 'save'
	arviz/tests/base_tests/test_plots_matplotlib.py
)

python_install_all() {
	if use examples; then
		docompress -x "/usr/share/doc/${PF}/examples"
		docinto examples
		dodoc -r examples/.
	fi

	distutils-r1_python_install_all
}
