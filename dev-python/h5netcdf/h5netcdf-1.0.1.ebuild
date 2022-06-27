# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..10} )

DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1

DESCRIPTION="Pythonic interface to netCDF4 via h5py"
HOMEPAGE="https://h5netcdf.org"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="test"	# Test phase runs with fails

RDEPEND="dev-python/h5py[${PYTHON_USEDEP}]
	dev-python/packaging[${PYTHON_USEDEP}]
"
BDEPEND="dev-python/setuptools_scm_git_archive[${PYTHON_USEDEP}]
	test? (
		dev-python/netcdf4-python[${PYTHON_USEDEP}]
		dev-python/h5pyd[${PYTHON_USEDEP}]
		>=sci-libs/hdf5-1.12.1
	)
"

distutils_enable_tests pytest
distutils_enable_sphinx doc dev-python/sphinx-book-theme

python_prepare_all() {
	sed -i -e "/GH/s/GH/GH\%s/" -e "/PR/s/PR/PR\%s/" doc/conf.py || die
	distutils-r1_python_prepare_all
}
