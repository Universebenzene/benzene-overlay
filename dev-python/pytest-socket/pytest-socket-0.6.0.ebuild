# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_{9..11} )

MY_PN=${PN/-/_}
MY_P=${MY_PN}-${PV}

inherit distutils-r1

DESCRIPTION="Pytest Plugin to disable socket calls during tests"
HOMEPAGE="https://github.com/miketheman/pytest-socket"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

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

S="${WORKDIR}/${MY_P}"

distutils_enable_tests pytest

EPYTEST_DESELECT=(
	# Fail in ebuild but pass outside
	tests/test_restrict_hosts.py::test_help_message
)
