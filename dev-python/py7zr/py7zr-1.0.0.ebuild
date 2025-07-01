# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1 pypi

DESCRIPTION="Pure python 7-zip library"
HOMEPAGE="https://py7zr.readthedocs.io"

LICENSE="LGPL-2.1+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
PROPERTIES="test_network"
RESTRICT="test"

RDEPEND=">=app-arch/brotli-1.1.0[python,${PYTHON_USEDEP}]
	<dev-python/inflate64-1.1.0[${PYTHON_USEDEP}]
	>=dev-python/multivolumefile-0.2.3[${PYTHON_USEDEP}]
	dev-python/psutil[${PYTHON_USEDEP}]
	<dev-python/pybcj-1.1.0[${PYTHON_USEDEP}]
	>=dev-python/pycryptodomex-3.20.0[${PYTHON_USEDEP}]
	<dev-python/pyppmd-1.3.0[${PYTHON_USEDEP}]
	>=dev-python/pyzstd-0.16.1[${PYTHON_USEDEP}]
	dev-python/texttable[${PYTHON_USEDEP}]
"
BDEPEND=">=dev-python/setuptools-scm-7.0.5[${PYTHON_USEDEP}]
	test? (
		app-arch/p7zip
		dev-python/requests[${PYTHON_USEDEP}]
		dev-python/py-cpuinfo[${PYTHON_USEDEP}]
		dev-python/pytest-benchmark[${PYTHON_USEDEP}]
		dev-python/pytest-httpserver[${PYTHON_USEDEP}]
		dev-python/pytest-timeout[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest

python_test() {
	epytest -o tmp_path_retention_policy=all --run-slow
}
