# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{8..11} )

inherit distutils-r1

DESCRIPTION="Random Access Read-Only Tar Mount"
HOMEPAGE="https://github.com/mxmlnkn/ratarmount"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-python/ratarmountcore[${PYTHON_USEDEP}]
	dev-python/fusepy[${PYTHON_USEDEP}]
	>=dev-python/indexed_bzip2-1.3.1[${PYTHON_USEDEP}]
	>=dev-python/indexed_gzip-1.6.3[${PYTHON_USEDEP}]
	>=dev-python/indexed_zstd-1.2.2[${PYTHON_USEDEP}]
	>=dev-python/python-xz-0.4.0[${PYTHON_USEDEP}]
	>=dev-python/rarfile-4.0[${PYTHON_USEDEP}]
"

distutils_enable_tests nose
