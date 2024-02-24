# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..11} )

inherit distutils-r1 pypi

DESCRIPTION="Random Access Read-Only Tar Mount Library"
HOMEPAGE="https://pypi.org/project/ratarmountcore"
GIT_TEST_URI="https://github.com/mxmlnkn/ratarmount/raw/core-v${PV}/tests"
SRC_URI+=" test? (
		${GIT_TEST_URI}/packed-100-times.tar.gz -> ${P}-t-packed-100-times.tar.gz
		${GIT_TEST_URI}/packed-5-times.tar.gz -> ${P}-t-packed-5-times.tar.gz
		${GIT_TEST_URI}/compressed-100-times.gz -> ${P}-t-compressed-100-times.gz
		${GIT_TEST_URI}/compressed-100-times.tar.gz -> ${P}-t-compressed-100-times.tar.gz
		${GIT_TEST_URI}/single-file.tar -> ${P}-t-single-file.tar
		${GIT_TEST_URI}/2k-recursive-tars.tar.bz2 -> ${P}-t-2k-recursive-tars.tar.bz2
		${GIT_TEST_URI}/tar-with-300-folders-with-1000-files-0B-files.tar.bz2 -> ${P}-t-tar-with-300-folders-with-1000-files-0B-files.tar.bz2
	)
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+bzip2 +full +gzip +rar +xz +zstd"
REQUIRED_USE="full? ( bzip2 gzip rar xz zstd )"

RDEPEND="bzip2? ( >=dev-python/indexed-bzip2-1.3.1[${PYTHON_USEDEP}] )
	full? ( >=dev-python/rapidgzip-0.10.0[${PYTHON_USEDEP}] )
	gzip? ( >=dev-python/indexed-gzip-1.6.3[${PYTHON_USEDEP}] )
	rar? ( >=dev-python/rarfile-4.0[${PYTHON_USEDEP}] )
	xz? ( >=dev-python/python-xz-0.4.0[${PYTHON_USEDEP}] )
	zstd? ( >=dev-python/indexed-zstd-1.2.2[${PYTHON_USEDEP}] )
"
BDEPEND="test? (
		dev-python/indexed-bzip2[${PYTHON_USEDEP}]
		dev-python/indexed-gzip[${PYTHON_USEDEP}]
		dev-python/python-xz[${PYTHON_USEDEP}]
		dev-python/indexed-zstd[${PYTHON_USEDEP}]
		dev-python/zstandard[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest

python_prepare_all() {
	use test && { for tdata in "${DISTDIR}"/*-t-*; do { cp ${tdata} "${S}"/tests/${tdata##*-t-} || die ; } ; done ; }

	distutils-r1_python_prepare_all
}
