# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYPI_NO_NORMALIZE=1
PYTHON_COMPAT=( python3_{10..13} )

inherit distutils-r1 pypi

DESCRIPTION="Microsoft Azure Core Library for Python"
HOMEPAGE="https://github.com/Azure/azure-sdk-for-python/tree/main/sdk/core/azure-core"
SRC_URI="$(pypi_sdist_url --no-normalize ${PN} ${PV} .zip)"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="aio examples doc"
PROPERTIES="test_network"
RESTRICT="test"

RDEPEND=">=dev-python/requests-2.18.4[${PYTHON_USEDEP}]
	>=dev-python/six-1.11.0[${PYTHON_USEDEP}]
	>=dev-python/typing-extensions-4.0.1[${PYTHON_USEDEP}]
	aio? ( >=dev-python/aiohttp-3.0[${PYTHON_USEDEP}] )
"
BDEPEND="app-arch/unzip
	test? (
		dev-python/pytest-asyncio[${PYTHON_USEDEP}]
		dev-python/aiohttp[${PYTHON_USEDEP}]
		dev-python/trio[${PYTHON_USEDEP}]
	)
"

DOCS=( {CHANGELOG,CLIENT_LIBRARY_DEVELOPER,README}.md )

distutils_enable_tests pytest

python_install_all() {
	use doc && DOCS+=( doc/* )
	if use examples; then
		docompress -x "/usr/share/doc/${PF}/samples"
		docinto samples
		dodoc -r samples/.
	fi

	distutils-r1_python_install_all
}

EPYTEST_IGNORE=(
	# No module named 'devtools_testutils'
	tests/test_connection_string_parsing.py
)
