# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

#DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..13} )

inherit distutils-r1 pypi

DESCRIPTION="AutoRest swagger generator Python client runtime"
HOMEPAGE="https://github.com/Azure/msrest-for-python"
SRC_URI="$(pypi_sdist_url ${PN} ${PV} .zip)"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="async"

RDEPEND=">=dev-python/requests-oauthlib-0.5.0[${PYTHON_USEDEP}]
	>=dev-python/isodate-0.6.0[${PYTHON_USEDEP}]
	>=dev-python/certifi-2017.4.17[${PYTHON_USEDEP}]
	>=dev-python/azure-core-1.24.0[${PYTHON_USEDEP}]
	async? (
		>=dev-python/aiohttp-3.0[${PYTHON_USEDEP}]
		dev-python/aiodns[${PYTHON_USEDEP}]
	)
"

BDEPEND="app-arch/unzip
	test? (
		dev-python/pytest-asyncio[${PYTHON_USEDEP}]
		dev-python/aiohttp[${PYTHON_USEDEP}]
		dev-python/httpretty[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest

EPYTEST_IGNORE=(
	# ImportError
	tests/asynctests/test_pipeline.py
	tests/asynctests/test_universal_http.py
)
