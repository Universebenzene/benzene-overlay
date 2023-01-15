# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{9..10} )

inherit distutils-r1

DESCRIPTION="Python Socket.IO server and client"
HOMEPAGE="https://python-socketio.readthedocs.io"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="asyncio-client client"

RDEPEND=">=dev-python/bidict-0.21.0[${PYTHON_USEDEP}]
	>=dev-python/python-engineio-4.3.0[${PYTHON_USEDEP}]
	client? (
		>=dev-python/requests-2.21.0[${PYTHON_USEDEP}]
		>=dev-python/websocket-client-0.54.0[${PYTHON_USEDEP}]
	)
	asyncio-client? ( >=dev-python/aiohttp-3.4[${PYTHON_USEDEP}] )
"

distutils_enable_tests nose
