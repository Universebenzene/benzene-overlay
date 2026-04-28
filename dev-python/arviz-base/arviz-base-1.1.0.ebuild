# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=flit
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1

DESCRIPTION="Base ArviZ features and converters."
HOMEPAGE="https://python.arviz.org/projects/base"
SRC_URI="https://github.com/arviz-devs/arviz-base/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="h5netcdf netcdf4 zarr"

RDEPEND=">=dev-python/numpy-2[${PYTHON_USEDEP}]
	>=dev-python/lazy-loader-0.4[${PYTHON_USEDEP}]
	>=dev-python/typing-extensions-3.10[${PYTHON_USEDEP}]
	>=dev-python/xarray-2024.11.0[${PYTHON_USEDEP}]
	h5netcdf? ( dev-python/h5netcdf[${PYTHON_USEDEP},h5py] )
	netcdf4? ( dev-python/netcdf4[${PYTHON_USEDEP}] )
	zarr? ( dev-python/zarr[${PYTHON_USEDEP}] )
"
BDEPEND="test? ( || (
		dev-python/h5netcdf[${PYTHON_USEDEP},h5py]
		dev-python/netcdf4[${PYTHON_USEDEP}]
	) )
"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest
distutils_enable_sphinx docs/source dev-python/sphinx-copybutton \
	dev-python/sphinx-design \
	dev-python/sphinx-book-theme \
	dev-python/jupyter-sphinx \
	dev-python/myst-nb \
	dev-python/numpydoc \
	dev-python/h5netcdf \
	dev-python/h5py \
	dev-python/linkify-it-py \
	dev-python/tinycss2
