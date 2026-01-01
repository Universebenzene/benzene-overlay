# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
DISTUTILS_OPTIONAL=1
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{{11..14},{13..14}t} )
#PYTHON_COMPAT=( python3_{{11..12},{13..14}{,t}} )

inherit distutils-r1 multiprocessing

DESCRIPTION="DB-API 2.0 interface for SQLCipher 3.x"
HOMEPAGE="https://github.com/coleifer/sqlcipher3"
SRC_URI="https://github.com/coleifer/sqlcipher3/archive/refs/tags/${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="ZLIB"
SLOT="0"
KEYWORDS="~amd64 ~x86"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

DEPEND="dev-db/sqlcipher"
RDEPEND="${DEPEND}
	${PYTHON_DEPS}
"
BDEPEND="${DISTUTILS_DEPS}"

distutils_enable_tests unittest

src_prepare() {
	default
	use test && { for tpy in $(ls tests/[a-z]*.py); do { mv tests/{,test_}${tpy#tests/} || die ; } ; done ; }
	distutils-r1_src_prepare
}

src_compile() {
	python_foreach_impl esetup.py build_system -j $(makeopts_jobs "${MAKEOPTS}")
}

src_install() {
	python_foreach_impl esetup.py install --root="${ED}"
	python_foreach_impl python_optimize
}

python_test() {
#	No module named 'sqlcipher3._sqlite3'
	cp "build/lib.linux-${ARCH/amd64/x86_64}-c${EPYTHON/3./-3}/${PN}"/*.c${EPYTHON/3./-3}*.so "${PN}" || die
	eunittest
	rm "${PN}"/*.c${EPYTHON/3./-3}*.so || die
}

src_test() {
	distutils-r1_src_test
}
