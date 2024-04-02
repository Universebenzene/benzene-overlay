# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=flit
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1 pypi

DESCRIPTION="Itertools and builtins for AsyncIO and mixed iterables"
HOMEPAGE="https://aioitertools.omnilib.dev"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND=">=dev-python/typing-extensions-4.0[${PYTHON_USEDEP}]"

PATCHES=( "${FILESDIR}/${P}-fix-doc-markdown-highlight.patch" )

distutils_enable_tests unittest
distutils_enable_sphinx docs dev-python/sphinx-mdinclude
