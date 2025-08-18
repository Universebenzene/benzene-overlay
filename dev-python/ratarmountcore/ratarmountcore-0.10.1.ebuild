# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1 pypi

DESCRIPTION="Random Access Read-Only Tar Mount Library"
HOMEPAGE="https://pypi.org/project/ratarmountcore"
GIT_TEST_URI="https://github.com/mxmlnkn/ratarmount/raw/core-v${PV}/tests"
SRC_URI+=" test? (
		${GIT_TEST_URI}/chimera-tbz2-zip -> ${P}-t-chimera-tbz2-zip
		${GIT_TEST_URI}/encrypted-nested-tar.zip -> ${P}-t-encrypted-nested-tar.zip
		${GIT_TEST_URI}/encrypted-nested-tar.sqlar -> ${P}-t-encrypted-nested-tar.sqlar
		${GIT_TEST_URI}/encrypted-nested-tar.7z -> ${P}-t-encrypted-nested-tar.7z
		${GIT_TEST_URI}/packed-100-times.tar.gz -> ${P}-t-packed-100-times.tar.gz
		${GIT_TEST_URI}/packed-5-times.tar.gz -> ${P}-t-packed-5-times.tar.gz
		${GIT_TEST_URI}/compressed-100-times.gz -> ${P}-t-compressed-100-times.gz
		${GIT_TEST_URI}/compressed-100-times.tar.gz -> ${P}-t-compressed-100-times.tar.gz
		${GIT_TEST_URI}/double-compressed-nested-tar.tgz.tgz -> ${P}-t-double-compressed-nested-tar.tgz.tgz
		${GIT_TEST_URI}/folder-symlink.rar -> ${P}-t-folder-symlink.rar
		${GIT_TEST_URI}/folder-symlink.zip -> ${P}-t-folder-symlink.zip
		${GIT_TEST_URI}/folder-symlink.7z -> ${P}-t-folder-symlink.7z
		${GIT_TEST_URI}/nested-tar-compressed.sqlar -> ${P}-t-nested-tar-compressed.sqlar
		${GIT_TEST_URI}/nested-tar.index.sqlite -> ${P}-t-nested-tar.index.sqlite
		${GIT_TEST_URI}/nested-tar.sqlar -> ${P}-t-nested-tar.sqlar
		${GIT_TEST_URI}/nested-tar.tar -> ${P}-t-nested-tar.tar
		${GIT_TEST_URI}/nested-tar-1M.ext4.bz2 -> ${P}-t-nested-tar-1M.ext4.bz2
		${GIT_TEST_URI}/nested-tar-10M.ext4.bz2 -> ${P}-t-nested-tar-10M.ext4.bz2
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
		${GIT_TEST_URI}/triple-compressed-nested-tar.tgz.tgz.gz -> ${P}-t-triple-compressed-nested-tar.tgz.tgz.gz
		https://github.com/mxmlnkn/ratarmount/raw/core-v${PV}/core/tests/helpers.py -> ${P}-t-helpers.py
	)
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+7z +bzip2 colors ext4 +fat fsspec fsspec-backends full full-ssh git +gzip +rar sqlar squashfs +xz +zip +zstd"
REQUIRED_USE="full? ( 7z bzip2 fat fsspec-backends git gzip rar squashfs xz zip zstd )"

RDEPEND="sys-fs/fuse
	7z? (
		>=dev-python/libarchive-c-5.1[${PYTHON_USEDEP}]
		>=dev-python/py7zr-1.0[${PYTHON_USEDEP}]
	)
	bzip2? ( >=dev-python/rapidgzip-0.15.0[${PYTHON_USEDEP}] )
	colors? ( dev-python/rich[${PYTHON_USEDEP}] )
	ext4? ( >=dev-python/ext4-1.1[${PYTHON_USEDEP}] )
	fat? ( >=dev-python/pyfatfs-1.0[${PYTHON_USEDEP}] )
	fsspec? ( dev-python/fsspec[${PYTHON_USEDEP}] )
	fsspec-backends? (
		dev-python/aiohttp[${PYTHON_USEDEP}]
		dev-python/dropboxdrivefs[${PYTHON_USEDEP}]
		dev-python/fsspec[${PYTHON_USEDEP}]
		dev-python/ipfsspec[${PYTHON_USEDEP}]
		>=dev-python/pyopenssl-23[${PYTHON_USEDEP}]
		dev-python/requests[${PYTHON_USEDEP}]
		dev-python/s3fs[${PYTHON_USEDEP}]
		dev-python/sshfs[${PYTHON_USEDEP}]
		dev-python/smbprotocol[${PYTHON_USEDEP}]
		dev-python/webdav4[${PYTHON_USEDEP}]
	)
	full-ssh? (
		dev-python/sshfs[${PYTHON_USEDEP}]
		>=dev-python/bcrypt-3.1.3[${PYTHON_USEDEP}]
		>=dev-python/fido2-0.9.2[${PYTHON_USEDEP}]
		>=dev-python/gssapi-1.2.0[${PYTHON_USEDEP}]
		>=dev-python/libnacl-1.4.2[${PYTHON_USEDEP}]
		>=dev-python/pyopenssl-23.0.0[${PYTHON_USEDEP}]
		>=dev-python/python-pkcs11-0.7.0[${PYTHON_USEDEP}]
	)
	git? ( dev-python/pygit2[${PYTHON_USEDEP}] )
	gzip? (
		>=dev-python/indexed-gzip-1.7[${PYTHON_USEDEP}]
		>=dev-python/rapidgzip-0.15.0[${PYTHON_USEDEP}]
	)
	rar? ( >=dev-python/rarfile-4.0[${PYTHON_USEDEP}] )
	sqlar? (
		dev-python/cryptography[${PYTHON_USEDEP}]
		dev-python/sqlcipher3[${PYTHON_USEDEP}]
	)
	squashfs? (
		>=dev-python/isal-1.0[${PYTHON_USEDEP}]
		>=dev-python/pysquashfsimage-0.9.0[${PYTHON_USEDEP}]
		>=dev-python/python-lzo-1.0[${PYTHON_USEDEP}]
		>=dev-python/lz4-4.0.0[${PYTHON_USEDEP}]
		>=dev-python/zstandard-0.23.0[${PYTHON_USEDEP}]
	)
	xz? ( >=dev-python/python-xz-0.4.0[${PYTHON_USEDEP}] )
	zip? ( dev-python/fast-zip-decryption[${PYTHON_USEDEP}] )
	zstd? ( >=dev-python/indexed-zstd-1.2.2[${PYTHON_USEDEP}] )
"
BDEPEND="test? (
		app-arch/lrzip
		app-arch/lzop
		dev-python/ext4[${PYTHON_USEDEP}]
		dev-python/fsspec[${PYTHON_USEDEP}]
		dev-python/libarchive-c[${PYTHON_USEDEP}]
		dev-python/indexed-gzip[${PYTHON_USEDEP}]
		dev-python/indexed-zstd[${PYTHON_USEDEP}]
		dev-python/python-xz[${PYTHON_USEDEP}]
		dev-python/py7zr[${PYTHON_USEDEP}]
		dev-python/cryptography[${PYTHON_USEDEP}]
		dev-python/sqlcipher3[${PYTHON_USEDEP}]
		dev-python/rapidgzip[${PYTHON_USEDEP}]
		dev-python/rarfile[${PYTHON_USEDEP}]
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
