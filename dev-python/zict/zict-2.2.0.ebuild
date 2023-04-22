# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

#DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..11} )

inherit distutils-r1

DESCRIPTION="Mutable mapping tools"
HOMEPAGE="http://zict.readthedocs.io"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-python/heapdict[${PYTHON_USEDEP}]"
BDEPEND="test? (
		dev-python/lmdb[${PYTHON_USEDEP}]
		dev-python/psutil[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest
