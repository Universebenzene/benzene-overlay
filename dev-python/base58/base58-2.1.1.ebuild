# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..14} )

inherit distutils-r1 pypi

DESCRIPTION="Base58 and Base58Check implementation"
HOMEPAGE="https://github.com/keis/base58"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
BDEPEND="test? ( dev-python/pyhamcrest[${PYTHON_USEDEP}] )"

#https://gitlab.com/bitcoin/gentoo/-/blob/master/dev-python/base58/files/2.1.1-test-no-benchmark.patch
PATCHES=( "${FILESDIR}/${P}-test-no-benchmark.patch" )

distutils_enable_tests pytest
