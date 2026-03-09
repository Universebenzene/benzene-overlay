# Copyright 2022-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{{11..14},{13..14}t} )
#PYTHON_COMPAT=( python3_{{11..12},{13..14}{,t}} )

inherit distutils-r1 pypi

DESCRIPTION="Fast random access to zstd files"
HOMEPAGE="https://github.com/martinellimarco/indexed_zstd"
SRC_URI+=" test? ( https://github.com/martinellimarco/indexed_zstd/raw/refs/tags/v${PV}/tests/conftest.py -> ${P}-conftest.py )"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="app-arch/zstd"
BDEPEND="dev-python/cython[${PYTHON_USEDEP}]"

EPYTEST_PLUGINS=()
: ${EPYTEST_TIMEOUT:=180}
distutils_enable_tests pytest

python_prepare_all() {
	use test && { cp {"${DISTDIR}"/${P}-,"${S}"/tests/}conftest.py || die ; }

	distutils-r1_python_prepare_all
}

src_test() {
	$(tc-getCC) ${CFLAGS} indexed_zstd/libzstd-seek/tests/gen_seekable.c -o gen_seekable -lzstd || die
	GEN_SEEKABLE="${S}/gen_seekable" distutils-r1_src_test
}
