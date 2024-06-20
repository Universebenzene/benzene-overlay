# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1 pypi

DESCRIPTION="Python Socket.IO server and client"
HOMEPAGE="https://python-socketio.readthedocs.io"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"	# bidict pytest-benchmark no x86
IUSE="asyncio-client client"

RDEPEND=">=dev-python/bidict-0.21.0[${PYTHON_USEDEP}]
	>=dev-python/python-engineio-4.8.0[${PYTHON_USEDEP}]
	client? (
		>=dev-python/requests-2.21.0[${PYTHON_USEDEP}]
		>=dev-python/websocket-client-0.54.0[${PYTHON_USEDEP}]
	)
	asyncio-client? ( >=dev-python/aiohttp-3.4[${PYTHON_USEDEP}] )
"
BDEPEND="test? (
		dev-python/msgpack[${PYTHON_USEDEP}]
		dev-python/uvicorn[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest
distutils_enable_sphinx docs
