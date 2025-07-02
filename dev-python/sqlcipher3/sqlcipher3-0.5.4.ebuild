# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{{11..14},{13..14}t} )
#PYTHON_COMPAT=( python3_{{11..12},{13..14}{,t}} )

inherit distutils-r1

DESCRIPTION="DB-API 2.0 interface for SQLCipher 3.x"
HOMEPAGE="https://github.com/coleifer/sqlcipher3"
SRC_URI="https://github.com/coleifer/sqlcipher3/archive/refs/tags/${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="ZLIB"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="dev-db/sqlcipher"
RDEPEND="${DEPEND}"

distutils_enable_tests unittest

python_prepare_all() {
	use test && { for tpy in $(ls tests/[a-z]*.py); do { mv tests/{,test_}${tpy#tests/} || die ; } ; done ; }
	distutils-r1_python_prepare_all
}

python_test() {
#	No module named 'sqlcipher3._sqlite3'
	[[ -d ${PN} ]] && { mv {,_}${PN} || die ; }
	eunittest
	[[ -d _${PN} ]] && { mv {_,}${PN} || die ; }
}
