# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{{11..14},{13..14}t} )
#PYTHON_COMPAT=( python3_{{11..12},{13..14}{,t}} )

inherit distutils-r1 pypi

DESCRIPTION="Ctypes bindings for the high-level API in libfuse 2 and 3"
HOMEPAGE="https://github.com/mxmlnkn/mfusepy"
SRC_URI+=" test? (
		https://github.com/mxmlnkn/mfusepy/raw/refs/tags/v${PV}/examples/loopback.py -> ${P}-t-loopback.py
		https://github.com/mxmlnkn/mfusepy/raw/refs/tags/v${PV}/examples/memory.py -> ${P}-t-memory.py
		https://github.com/mxmlnkn/mfusepy/raw/refs/tags/v${PV}/examples/memory_nullpath.py -> ${P}-t-memory_nullpath.py
	)
"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="|| ( sys-fs/fuse:0 sys-fs/fuse:3 )"
RDEPEND="${DEPEND}"
BDEPEND="test? ( dev-python/ioctl-opt[${PYTHON_USEDEP}] )"
PROPERTIES="test_privileged"
RESTRICT="test"

distutils_enable_tests pytest

python_prepare_all() {
	if use test; then
		for tpy in "${DISTDIR}"/*-t-*; do { cp ${tpy} "${S}"/${tpy##*-t-} || die ; } ; done
		has_version sys-fs/fuse:3 && { sed -i "s/fusermount/fusermount3/" tests/test_memory.py || die ; }
	fi
	distutils-r1_python_prepare_all
}

python_test() {
	addwrite /dev/fuse
	epytest
}
