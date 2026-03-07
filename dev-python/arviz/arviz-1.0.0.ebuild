# Copyright 2022-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=flit
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1

DESCRIPTION="Exploratory analysis of Bayesian models with Python"
HOMEPAGE="https://python.arviz.org"
SRC_URI="https://github.com/arviz-devs/arviz/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE="bokeh h5netcdf matplotlib netcdf4 plotly zarr"

RDEPEND=">=dev-python/arviz-base-1.0.0[${PYTHON_USEDEP},h5netcdf?,netcdf4?,zarr?]
	>=dev-python/arviz-plots-1.0.0[${PYTHON_USEDEP},bokeh?,matplotlib?,plotly?]
	>=dev-python/arviz-stats-1.0.0[${PYTHON_USEDEP},xarray]
"
BDEPEND="test? (
		dev-python/ipython[${PYTHON_USEDEP}]
		dev-python/matplotlib[${PYTHON_USEDEP}]
		|| ( dev-python/h5netcdf[${PYTHON_USEDEP},h5py] dev-python/netcdf4[${PYTHON_USEDEP}] )
	)
"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest
