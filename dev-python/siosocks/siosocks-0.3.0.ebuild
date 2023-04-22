# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

#DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..11} )

inherit distutils-r1

DESCRIPTION="Sans-io socks proxy client/server with couple io backends"
HOMEPAGE="https://sans-io.readthedocs.io https://github.com/pohmelie/siosocks"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~x86"
IUSE="trio"

RDEPEND="trio? ( dev-python/trio[${PYTHON_USEDEP}] )"
BDEPEND="test? (
		dev-python/pytest-asyncio[${PYTHON_USEDEP}]
		dev-python/pytest-trio[${PYTHON_USEDEP}]
		dev-python/trio[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest
