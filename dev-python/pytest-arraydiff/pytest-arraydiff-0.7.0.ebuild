# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1 pypi

DESCRIPTION="Pytest plugin to facilitate comparison of arrays"
HOMEPAGE="https://github.com/astropy/pytest-arraydiff"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RDEPEND="dev-python/numpy[${PYTHON_USEDEP}]
	>=dev-python/pytest-6.2[${PYTHON_USEDEP}]
"
DEPEND="${RDEPEND}"
BDEPEND="dev-python/setuptools-scm[${PYTHON_USEDEP}]
	test? ( dev-python/astropy[${PYTHON_USEDEP}] )
"

EPYTEST_PLUGIN_LOAD_VIA_ENV=1
EPYTEST_PLUGINS=( "${PN}" pytest-run-parallel )
distutils_enable_tests pytest

python_test() {
	PYTHONPATH="${BUILD_DIR}"/install/$(python_get_sitedir) epytest
}
