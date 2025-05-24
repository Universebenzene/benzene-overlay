# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..14} )

inherit distutils-r1 pypi

DESCRIPTION="Simple retry client for aiohttp"
HOMEPAGE="https://github.com/inyutin/aiohttp_retry"
SRC_URI+=" test? ( ${HOMEPAGE}/raw/refs/tags/v${PV}/tests/app.py  -> ${P}-app.py )"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-python/aiohttp[${PYTHON_USEDEP}]"
BDEPEND="test? (
		dev-python/pytest-aiohttp[${PYTHON_USEDEP}]
		dev-python/pytest-asyncio[${PYTHON_USEDEP}]
	)
"

python_prepare_all() {
	use test && { cp {"${DISTDIR}"/${P}-,"${S}"/tests/}app.py || die ; }

	distutils-r1_python_prepare_all
}

distutils_enable_tests pytest
