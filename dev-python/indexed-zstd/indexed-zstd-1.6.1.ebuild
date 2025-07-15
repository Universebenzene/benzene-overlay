# Copyright 2022-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{{11..14},{13..14}t} )
#PYTHON_COMPAT=( python3_{{11..12},{13..14}{,t}} )

inherit distutils-r1 pypi

DESCRIPTION="Fast random access to zstd files"
HOMEPAGE="https://github.com/martinellimarco/indexed_zstd"
SRC_URI+=" test? ( https://github.com/martinellimarco/indexed_zstd/raw/v${PV}/test/test.zst -> ${P}-test.zst )"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="app-arch/zstd"
BDEPEND="dev-python/cython[${PYTHON_USEDEP}]"

python_prepare_all() {
	use test && { cp {"${DISTDIR}"/${P}-,"${S}"/}test.zst || die ; }

	distutils-r1_python_prepare_all
}

python_test() {
	${EPYTHON} test/test.py || die "Tests failed with ${EPYTHON}"
}
