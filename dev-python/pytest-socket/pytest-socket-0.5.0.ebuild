# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYPI_NO_NORMALIZE=1
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1 pypi

DESCRIPTION="Pytest Plugin to disable socket calls during tests"
HOMEPAGE="https://github.com/miketheman/pytest-socket"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
PROPERTIES="test_network"
RESTRICT="test"
RDEPEND=">=dev-python/pytest-3.6.3[${PYTHON_USEDEP}]"
BDEPEND="test? (
		dev-python/asynctest[${PYTHON_USEDEP}]
		dev-python/httpx[${PYTHON_USEDEP}]
		dev-python/pytest-httpbin[${PYTHON_USEDEP}]
		dev-python/requests[${PYTHON_USEDEP}]
		dev-python/starlette[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests --install pytest

EPYTEST_DESELECT=(
	# Connection reset by peer
	tests/test_combinations.py::test_parametrize_with_socket_enabled_and_allow_hosts
	# Fail in ebuild but pass outside
	tests/test_restrict_hosts.py::test_help_message
)
