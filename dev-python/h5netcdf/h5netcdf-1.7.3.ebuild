# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1 optfeature pypi

DESCRIPTION="Pythonic interface to netCDF4 via h5py"
HOMEPAGE="https://h5netcdf.org"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+h5py h5pyd pyfive"

RDEPEND="dev-python/packaging[${PYTHON_USEDEP}]
	h5py? ( dev-python/h5py[${PYTHON_USEDEP}] )
	h5pyd? ( dev-python/h5pyd[${PYTHON_USEDEP}] )
	pyfive? ( >=dev-python/pyfive-1.0.0[${PYTHON_USEDEP}] )
"
BDEPEND=">=dev-python/setuptools-scm-7.0[${PYTHON_USEDEP}]
	test? (
		dev-python/netcdf4[${PYTHON_USEDEP}]
		dev-python/h5py[${PYTHON_USEDEP}]
		dev-python/h5pyd[${PYTHON_USEDEP}]
		>=dev-python/pyfive-1.0.0[${PYTHON_USEDEP}]
		>=sci-libs/hdf5-1.12.1
	)
"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest
distutils_enable_sphinx doc dev-python/sphinx-book-theme dev-python/h5py

python_prepare_all() {
	use doc && { sed -i '/Type/s:   :   core.:g' doc/api.rst || die ; }

	distutils-r1_python_prepare_all
}

pkg_postinst() {
	optfeature "h5py backend support (default)" dev-python/h5py
	optfeature "h5pyd backend support" dev-python/h5pyd
	optfeature "pyfive backend support (pure Python HDF5 reading chain)" dev-python/pyfive
}
