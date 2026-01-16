# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=flit
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1 pypi

DESCRIPTION="Handle, manipulate, and convert data with units in Python"
HOMEPAGE="https://unyt.readthedocs.io"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND=">=dev-python/numpy-1.21.3[${PYTHON_USEDEP}]
	>=dev-python/sympy-1.9.0[${PYTHON_USEDEP}]
	>dev-python/packaging-20.9[${PYTHON_USEDEP}]
"
BDEPEND="test? (
		dev-python/astropy[${PYTHON_USEDEP}]
		dev-python/dask[${PYTHON_USEDEP}]
		dev-python/h5py[${PYTHON_USEDEP}]
		dev-python/jinja2[${PYTHON_USEDEP}]
		dev-python/matplotlib[${PYTHON_USEDEP}]
	)
"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest
#distutils_enable_sphinx docs dev-python/dask

#python_prepare_all() {
#	use doc && { ln -rs "${S}"/{docs/extensions/show_all_units.py,} || die ; }
#
#	distutils-r1_python_prepare_all
#}
