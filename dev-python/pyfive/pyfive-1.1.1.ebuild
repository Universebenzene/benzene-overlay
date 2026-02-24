# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYPI_VERIFY_REPO=https://github.com/NCAS-CMS/pyfive
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1 pypi

DESCRIPTION="A pure python HDF5 reader"
HOMEPAGE="https://pyfive.readthedocs.io"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
PROPERTIES="test_network"
RESTRICT="test"

RDEPEND=">=dev-python/numpy-2[${PYTHON_USEDEP}]"
BDEPEND=">=dev-python/setuptools-scm-8[${PYTHON_USEDEP}]
	test? (
		dev-python/dask[${PYTHON_USEDEP}]
		dev-python/flask-cors[${PYTHON_USEDEP}]
		dev-python/h5netcdf[${PYTHON_USEDEP}]
		dev-python/h5py[${PYTHON_USEDEP}]
		dev-python/moto[${PYTHON_USEDEP}]
		dev-python/netcdf4[${PYTHON_USEDEP}]
		dev-python/python-neo-lzf[${PYTHON_USEDEP}]
		dev-python/s3fs[${PYTHON_USEDEP}]
	)
"

EPYTEST_RERUNS=5
EPYTEST_PLUGINS=()
distutils_enable_tests pytest
distutils_enable_sphinx doc dev-python/sphinx-rtd-theme dev-python/autodocsumm "<dev-python/sphinx-9"

python_prepare_all() {
	sed -i -e "/--cov/d" -e "/--html/d" pyproject.toml || die
	sed -e '/stringtochar(months)/s:(months):(months, encoding="ascii"):' \
		-e '/stringtochar(months_m)/s:(months_m):(months_m, encoding="ascii"):' \
		-e '/stringtochar(numbers)/s:(numbers):(numbers, encoding="ascii"):' \
		-e '/stringtochar(np/s:S8"):S8"), encoding="ascii":' -i tests/test_vlen_str.py || die
	use doc && { sed -i "s/intersphinx/disabled_intersphinx/" doc/gensidebar.py || die ; }

	distutils-r1_python_prepare_all
}
