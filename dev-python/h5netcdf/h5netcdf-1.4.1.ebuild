# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1 pypi

DESCRIPTION="Pythonic interface to netCDF4 via h5py"
HOMEPAGE="https://h5netcdf.org"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-python/h5py[${PYTHON_USEDEP}]
	dev-python/packaging[${PYTHON_USEDEP}]
"
BDEPEND=">=dev-python/setuptools-scm-7.0[${PYTHON_USEDEP}]
	test? (
		dev-python/netcdf4[${PYTHON_USEDEP}]
		dev-python/h5pyd[${PYTHON_USEDEP}]
		>=sci-libs/hdf5-1.12.1
	)
"

distutils_enable_tests pytest
distutils_enable_sphinx doc dev-python/sphinx-book-theme

python_prepare_all() {
	use doc && { sed -i '/Type/s:   :   core.:g' doc/api.rst || die ; }

	distutils-r1_python_prepare_all
}
