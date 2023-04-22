# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

#DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..11} )

inherit distutils-r1

DESCRIPTION="Ftp client/server for asyncio"
HOMEPAGE="https://aioftp.readthedocs.io"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
IUSE="socks"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"

RDEPEND="socks? ( >=dev-python/siosocks-0.2.0[${PYTHON_USEDEP}] )"
BDEPEND="test? (
		dev-python/pytest-asyncio[${PYTHON_USEDEP}]
		>=dev-python/async-timeout-4.0.2[${PYTHON_USEDEP}]
		dev-python/trustme[${PYTHON_USEDEP}]
		dev-python/siosocks[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest
