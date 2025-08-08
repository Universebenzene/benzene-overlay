# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1 pypi

DESCRIPTION="Readonly implementation of fsspec for IPFS"
HOMEPAGE="https://github.com/fsspec/ipfsspec"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
PROPERTIES="test_network"
RESTRICT="test"	# IPFS Gateway could not be found!

RDEPEND="dev-python/aiohttp[${PYTHON_USEDEP}]
	dev-python/aiohttp-retry[${PYTHON_USEDEP}]
	>=dev-python/dag-cbor-0.2.2[${PYTHON_USEDEP}]
	>=dev-python/fsspec-2024.12.0[${PYTHON_USEDEP}]
	>=dev-python/typing-validation-1.1.0[${PYTHON_USEDEP}]
	dev-python/multiformats[${PYTHON_USEDEP}]
	>=dev-python/pure-protobuf-2.1.0[${PYTHON_USEDEP}]
	<dev-python/pure-protobuf-3[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
"
BDEPEND=">=dev-python/setuptools-scm-8[${PYTHON_USEDEP}]
	test? ( dev-python/pytest-asyncio[${PYTHON_USEDEP}] )
"

distutils_enable_tests pytest
