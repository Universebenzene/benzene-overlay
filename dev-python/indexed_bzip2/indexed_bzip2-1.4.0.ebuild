# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{8..11} )

inherit distutils-r1

DESCRIPTION="Fast random access to bzip2 files in Python"
HOMEPAGE="https://github.com/mxmlnkn/indexed_bzip2"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

BDEPEND=">=dev-python/cython-0.29.24[${PYTHON_USEDEP}]"

distutils_enable_tests nose
