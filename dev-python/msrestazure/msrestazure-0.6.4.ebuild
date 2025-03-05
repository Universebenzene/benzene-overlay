# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

#DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1 pypi

DESCRIPTION="AutoRest swagger generator Python client runtime. Azure-specific module"
HOMEPAGE="https://github.com/Azure/msrestazure-for-python"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="<dev-python/msrest-2.0.0[${PYTHON_USEDEP}]
	<dev-python/adal-2.0.0[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]
"

BDEPEND="test? ( dev-python/pytest-asyncio[${PYTHON_USEDEP}]
		dev-python/httpretty[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest
