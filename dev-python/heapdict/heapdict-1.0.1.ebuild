# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

#DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{8..11} )

MY_PN=HeapDict
MY_P=${MY_PN}-${PV}

inherit distutils-r1

DESCRIPTION="Heap with decrease-key and increase-key operations"
HOMEPAGE="http://stutzbachenterprises.com"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"
RESTRICT="!test? ( test )"

S="${WORKDIR}/${MY_P}"

python_test() {
	${EPYTHON} test_heap.py || die
}
