# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..14} )

MY_PN="hdf5-json"

inherit distutils-r1

DESCRIPTION="Specification and tools for representing HDF5 in JSON"
HOMEPAGE="https://support.hdfgroup.org/documentation/hdf5-json/latest"
SRC_URI="https://github.com/HDFGroup/${MY_PN}/archive/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND=">=dev-python/numpy-2.0[${PYTHON_USEDEP}]
	>=dev-python/h5py-3.10[${PYTHON_USEDEP}]
	>=dev-python/jsonschema-4.4.0[${PYTHON_USEDEP}]
	dev-python/pytz[${PYTHON_USEDEP}]
"

S="${WORKDIR}/${MY_PN}-${PV}"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest
distutils_enable_sphinx docs dev-python/sphinx-copybutton dev-python/sphinx-book-theme dev-python/myst-parser

python_prepare_all() {
	use test && { sed -i -e 's:../../src:src:g' -e 's:"..", "..":".":' test/integ/*_test.py || die ; }

	distutils-r1_python_prepare_all
}

python_test() {
	mkdir -p test/unit/out test/integ/{h5,json}_out || die
	epytest
}
