# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1 pypi

DESCRIPTION="Random Access Read-Only Tar Mount Library"
HOMEPAGE="https://pypi.org/project/ratarmountcore"
GIT_TEST_URI="https://github.com/mxmlnkn/ratarmount/raw/core-v${PV}/tests"
SRC_URI+=" test? (
		${GIT_TEST_URI}/chimera-tbz2-zip -> ${P}-t-chimera-tbz2-zip
		${GIT_TEST_URI}/encrypted-nested-tar.zip -> ${P}-t-encrypted-nested-tar.zip
		${GIT_TEST_URI}/packed-100-times.tar.gz -> ${P}-t-packed-100-times.tar.gz
		${GIT_TEST_URI}/packed-5-times.tar.gz -> ${P}-t-packed-5-times.tar.gz
		${GIT_TEST_URI}/compressed-100-times.gz -> ${P}-t-compressed-100-times.gz
		${GIT_TEST_URI}/compressed-100-times.tar.gz -> ${P}-t-compressed-100-times.tar.gz
		${GIT_TEST_URI}/double-compressed-nested-tar.tgz.tgz -> ${P}-t-double-compressed-nested-tar.tgz.tgz
		${GIT_TEST_URI}/folder-symlink.rar -> ${P}-t-folder-symlink.rar
		${GIT_TEST_URI}/folder-symlink.zip -> ${P}-t-folder-symlink.zip
		${GIT_TEST_URI}/folder-symlink.7z -> ${P}-t-folder-symlink.7z
		${GIT_TEST_URI}/single-file.tar -> ${P}-t-single-file.tar
		${GIT_TEST_URI}/simple.bz2 -> ${P}-t-simple.bz2
		${GIT_TEST_URI}/simple.gz -> ${P}-t-simple.gz
		${GIT_TEST_URI}/simple.lrz -> ${P}-t-simple.lrz
		${GIT_TEST_URI}/simple.lz4 -> ${P}-t-simple.lz4
		${GIT_TEST_URI}/simple.lzip -> ${P}-t-simple.lzip
		${GIT_TEST_URI}/simple.lzma -> ${P}-t-simple.lzma
		${GIT_TEST_URI}/simple.lzo -> ${P}-t-simple.lzo
		${GIT_TEST_URI}/simple.zst -> ${P}-t-simple.zst
		${GIT_TEST_URI}/simple.xz -> ${P}-t-simple.xz
		${GIT_TEST_URI}/simple.Z -> ${P}-t-simple.Z
		${GIT_TEST_URI}/2k-recursive-tars.tar.bz2 -> ${P}-t-2k-recursive-tars.tar.bz2
		${GIT_TEST_URI}/tar-with-300-folders-with-1000-files-0B-files.tar.bz2 -> ${P}-t-tar-with-300-folders-with-1000-files-0B-files.tar.bz2
		${GIT_TEST_URI}/two-large-files-32Ki-lines-each-1023B.7z -> ${P}-t-two-large-files-32Ki-lines-each-1023B.7z
		https://github.com/mxmlnkn/ratarmount/raw/core-v${PV}/core/tests/helpers.py -> ${P}-t-helpers.py
	)
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+7z +bzip2 +full +gzip +rar +xz +zstd"
REQUIRED_USE="full? ( 7z bzip2 gzip rar xz zstd )"

RDEPEND="7z? ( >=dev-python/libarchive-c-5.1[${PYTHON_USEDEP}] )
	bzip2? ( >=dev-python/rapidgzip-0.13.1[${PYTHON_USEDEP}] )
	gzip? ( >=dev-python/indexed-gzip-1.6.3[${PYTHON_USEDEP}] )
	rar? ( >=dev-python/rarfile-4.0[${PYTHON_USEDEP}] )
	xz? ( >=dev-python/python-xz-0.4.0[${PYTHON_USEDEP}] )
	zstd? ( >=dev-python/indexed-zstd-1.2.2[${PYTHON_USEDEP}] )
"
BDEPEND="test? (
		app-arch/lrzip
		app-arch/lzop
		dev-python/libarchive-c[${PYTHON_USEDEP}]
		dev-python/indexed-gzip[${PYTHON_USEDEP}]
		dev-python/indexed-zstd[${PYTHON_USEDEP}]
		dev-python/python-xz[${PYTHON_USEDEP}]
		dev-python/rapidgzip[${PYTHON_USEDEP}]
		dev-python/rarfile[${PYTHON_USEDEP}]
		dev-python/zstandard[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest

src_unpack() {
	unpack ${P}.tar.gz
}

python_prepare_all() {
	use test && { for tdata in "${DISTDIR}"/*-t-*; do { cp ${tdata} "${S}"/tests/${tdata##*-t-} || die ; } ; done ; }

	distutils-r1_python_prepare_all
}
