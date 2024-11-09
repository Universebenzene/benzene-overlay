# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{{10..13},13t} )

inherit distutils-r1 pypi

DESCRIPTION="Read password protected Zips 100x faster"
HOMEPAGE="https://github.com/mxmlnkn/fast-zip-decryption"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RDEPEND="app-arch/zip"

distutils_enable_tests pytest
