# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..13} )

inherit distutils-r1 pypi

DESCRIPTION="Random Access Read-Only Tar Mount"
HOMEPAGE="https://github.com/mxmlnkn/ratarmount"
GIT_RAW_URI="https://github.com/mxmlnkn/ratarmount/raw/v${PV}"
SRC_URI+=" test? (
		${GIT_RAW_URI}/tests/encrypted-nested-tar.rar -> ${P}-t-encrypted-nested-tar.rar
		${GIT_RAW_URI}/tests/encrypted-nested-tar.zip -> ${P}-t-encrypted-nested-tar.zip
	)
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="test"	# RuntimeError: Expected mount point but it isn't one!

RDEPEND="<dev-python/ratarmountcore-0.7.0[${PYTHON_USEDEP}]
	dev-python/fusepy[${PYTHON_USEDEP}]
	>=dev-python/indexed-bzip2-1.3.1[${PYTHON_USEDEP}]
	>=dev-python/indexed-gzip-1.6.3[${PYTHON_USEDEP}]
	>=dev-python/indexed-zstd-1.2.2[${PYTHON_USEDEP}]
	>=dev-python/python-xz-0.4.0[${PYTHON_USEDEP}]
	>=dev-python/rapidgzip-0.10.0[${PYTHON_USEDEP}]
	>=dev-python/rarfile-4.0[${PYTHON_USEDEP}]
"

distutils_enable_tests pytest

src_unpack() {
	unpack ${P}.tar.gz
}

python_prepare_all() {
	use test && { for tdata in "${DISTDIR}"/*-t-*; do { cp ${tdata} "${S}"/tests/${tdata##*-t-} || die ; } ; done ; }

	distutils-r1_python_prepare_all
}
