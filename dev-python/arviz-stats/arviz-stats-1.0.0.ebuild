# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=flit
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1

DESCRIPTION="Statistical computation and diagnostics for ArviZ."
HOMEPAGE="https://python.arviz.org/projects/stats"
SRC_URI="https://github.com/arviz-devs/arviz-stats/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="numba +xarray"

RDEPEND=">=dev-python/numpy-2[${PYTHON_USEDEP}]
	>=dev-python/scipy-1.13[${PYTHON_USEDEP}]
	numba? ( dev-python/xarray-einstats[${PYTHON_USEDEP},einops,numba] )
	xarray? (
		>=dev-python/arviz-base-1.0[${PYTHON_USEDEP}]
		>=dev-python/xarray-2024.11.0[${PYTHON_USEDEP}]
		dev-python/xarray-einstats[${PYTHON_USEDEP}]
	)
"
BDEPEND="test? (
		dev-python/arviz-base[${PYTHON_USEDEP}]
		dev-python/einops[${PYTHON_USEDEP}]
		|| ( dev-python/h5netcdf[${PYTHON_USEDEP},h5py] dev-python/netcdf4[${PYTHON_USEDEP}] )
		dev-python/numba[${PYTHON_USEDEP}]
		dev-python/xarray-einstats[${PYTHON_USEDEP}]
	)
"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest
