# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1 pypi

DESCRIPTION="Random Access Read-Only Tar Mount"
HOMEPAGE="https://github.com/mxmlnkn/ratarmount"
GIT_RAW_URI="https://github.com/mxmlnkn/ratarmount/raw/v${PV}"
SRC_URI+=" test? (
		${GIT_RAW_URI}/tests/absolute-file-incremental.tar -> ${P}-t-absolute-file-incremental.tar
		${GIT_RAW_URI}/tests/base64.gz -> ${P}-t-base64.gz
		${GIT_RAW_URI}/tests/concatenated.tar -> ${P}-t-concatenated.tar
		${GIT_RAW_URI}/tests/denormal-paths.tar -> ${P}-t-denormal-paths.tar
		${GIT_RAW_URI}/tests/denormal-paths.rar -> ${P}-t-denormal-paths.rar
		${GIT_RAW_URI}/tests/directly-nested-tar.tar -> ${P}-t-directly-nested-tar.tar
		${GIT_RAW_URI}/tests/double-compressed-nested-tar.tar.7z.7z -> ${P}-t-double-compressed-nested-tar.tar.7z.7z
		${GIT_RAW_URI}/tests/encrypted-nested-tar.rar -> ${P}-t-encrypted-nested-tar.rar
		${GIT_RAW_URI}/tests/encrypted-nested-tar.zip -> ${P}-t-encrypted-nested-tar.zip
		${GIT_RAW_URI}/tests/file-existing-as-non-link-and-link.tar -> ${P}-t-file-existing-as-non-link-and-link.tar
		${GIT_RAW_URI}/tests/file-in-non-existing-folder.7z -> ${P}-t-file-in-non-existing-folder.7z
		${GIT_RAW_URI}/tests/file-in-non-existing-folder.rar -> ${P}-t-file-in-non-existing-folder.rar
		${GIT_RAW_URI}/tests/folder-symlink.7z -> ${P}-t-folder-symlink.7z
		${GIT_RAW_URI}/tests/folder-symlink.rar -> ${P}-t-folder-symlink.rar
		${GIT_RAW_URI}/tests/folder-with-leading-dot-slash.tar -> ${P}-t-folder-with-leading-dot-slash.tar
		${GIT_RAW_URI}/tests/gnu-sparse-files.tar -> ${P}-t-gnu-sparse-files.tar
		${GIT_RAW_URI}/tests/hardlink.tar -> ${P}-t-hardlink.tar
		${GIT_RAW_URI}/tests/hello-world.warc -> ${P}-t-hello-world.warc
		${GIT_RAW_URI}/tests/incremental-backup.level.0.tar -> ${P}-t-incremental-backup.level.0.tar
		${GIT_RAW_URI}/tests/incremental-backup.level.1.tar -> ${P}-t-incremental-backup.level.1.tar
		${GIT_RAW_URI}/tests/nested-tar.tar -> ${P}-t-nested-tar.tar
		${GIT_RAW_URI}/tests/nested-directly-compressed.tar.bz2 -> ${P}-t-nested-directly-compressed.tar.bz2
		${GIT_RAW_URI}/tests/nested-symlinks.tar -> ${P}-t-nested-symlinks.tar
		${GIT_RAW_URI}/tests/nested-tar-with-overlapping-name.tar -> ${P}-t-nested-tar-with-overlapping-name.tar
		${GIT_RAW_URI}/tests/nested-with-symlink.7z -> ${P}-t-nested-with-symlink.7z
		${GIT_RAW_URI}/tests/simple.bz2 -> ${P}-t-simple.bz2
		${GIT_RAW_URI}/tests/simple.gz -> ${P}-t-simple.gz
		${GIT_RAW_URI}/tests/simple.lrz -> ${P}-t-simple.lrz
		${GIT_RAW_URI}/tests/simple.lz4 -> ${P}-t-simple.lz4
		${GIT_RAW_URI}/tests/simple.lzip -> ${P}-t-simple.lzip
		${GIT_RAW_URI}/tests/simple.lzma -> ${P}-t-simple.lzma
		${GIT_RAW_URI}/tests/simple.lzo -> ${P}-t-simple.lzo
		${GIT_RAW_URI}/tests/simple.xz -> ${P}-t-simple.xz
		${GIT_RAW_URI}/tests/simple.zlib -> ${P}-t-simple.zlib
		${GIT_RAW_URI}/tests/simple.zst -> ${P}-t-simple.zst
		${GIT_RAW_URI}/tests/simple.Z -> ${P}-t-simple.Z
		${GIT_RAW_URI}/tests/single-file.ar -> ${P}-t-single-file.ar
		${GIT_RAW_URI}/tests/single-file.bin.cpio -> ${P}-t-single-file.bin.cpio
		${GIT_RAW_URI}/tests/single-file.cab -> ${P}-t-single-file.cab
		${GIT_RAW_URI}/tests/single-file.crc.cpio -> ${P}-t-single-file.crc.cpio
		${GIT_RAW_URI}/tests/single-file.hpbin.cpio -> ${P}-t-single-file.hpbin.cpio
		${GIT_RAW_URI}/tests/single-file.hpodc.cpio -> ${P}-t-single-file.hpodc.cpio
		${GIT_RAW_URI}/tests/single-file.iso.bz2 -> ${P}-t-single-file.iso.bz2
		${GIT_RAW_URI}/tests/single-file.newc.cpio -> ${P}-t-single-file.newc.cpio
		${GIT_RAW_URI}/tests/single-file.tar -> ${P}-t-single-file.tar
		${GIT_RAW_URI}/tests/single-file.xar -> ${P}-t-single-file.xar
		${GIT_RAW_URI}/tests/single-file.odc.cpio -> ${P}-t-single-file.odc.cpio
		${GIT_RAW_URI}/tests/single-file-incremental-long-name.tar -> ${P}-t-single-file-incremental-long-name.tar
		${GIT_RAW_URI}/tests/single-file-incremental-long-name-mockup.tar -> ${P}-t-single-file-incremental-long-name-mockup.tar
		${GIT_RAW_URI}/tests/single-file-incremental-mockup.tar -> ${P}-t-single-file-incremental-mockup.tar
		${GIT_RAW_URI}/tests/single-file-with-leading-dot-slash.tar -> ${P}-t-single-file-with-leading-dot-slash.tar
		${GIT_RAW_URI}/tests/single-nested-file.tar -> ${P}-t-single-nested-file.tar
		${GIT_RAW_URI}/tests/single-nested-folder.tar -> ${P}-t-single-nested-folder.tar
		${GIT_RAW_URI}/tests/two-self-links-to-existing-file.tar -> ${P}-t-two-self-links-to-existing-file.tar
		${GIT_RAW_URI}/tests/updated-file.tar -> ${P}-t-updated-file.tar
		${GIT_RAW_URI}/tests/updated-file-implicitly-with-folder.tar -> ${P}-t-updated-file-implicitly-with-folder.tar
		${GIT_RAW_URI}/tests/updated-file-with-folder.tar -> ${P}-t-updated-file-with-folder.tar
		${GIT_RAW_URI}/tests/updated-folder-with-file.tar -> ${P}-t-updated-folder-with-file.tar
		${GIT_RAW_URI}/tests/zip.7z -> ${P}-t-zip.7z
	)
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="test"	# RuntimeError: Expected mount point but it isn't one!

RDEPEND=">=dev-python/ratarmountcore-0.7.0[${PYTHON_USEDEP}]
	dev-python/fusepy[${PYTHON_USEDEP}]
	>=dev-python/indexed-gzip-1.6.3[${PYTHON_USEDEP}]
	>=dev-python/indexed-zstd-1.2.2[${PYTHON_USEDEP}]
	>=dev-python/libarchive-c-5.1[${PYTHON_USEDEP}]
	>=dev-python/python-xz-0.4.0[${PYTHON_USEDEP}]
	>=dev-python/rapidgzip-0.13.1[${PYTHON_USEDEP}]
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
