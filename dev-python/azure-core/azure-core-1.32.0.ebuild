# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..13} )

inherit distutils-r1 pypi

DESCRIPTION="Microsoft Azure Core Library for Python"
HOMEPAGE="https://github.com/Azure/azure-sdk-for-python/tree/main/sdk/core/azure-core"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="aio examples doc"
PROPERTIES="test_network"
RESTRICT="test"

RDEPEND=">=dev-python/requests-2.21.0[${PYTHON_USEDEP}]
	>=dev-python/six-1.11.0[${PYTHON_USEDEP}]
	>=dev-python/typing-extensions-4.6.0[${PYTHON_USEDEP}]
	aio? ( >=dev-python/aiohttp-3.0[${PYTHON_USEDEP}] )
"
BDEPEND="test? (
		dev-python/pytest-asyncio[${PYTHON_USEDEP}]
		dev-python/pytest-trio[${PYTHON_USEDEP}]
		dev-python/aiohttp[${PYTHON_USEDEP}]
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
