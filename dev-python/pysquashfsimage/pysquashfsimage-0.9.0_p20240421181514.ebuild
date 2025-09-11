# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..14} )

MY_PN="PySquashfsImage"
COMMIT="e637b26b3bc6268dd589fa1439fecf99e49a565b"

inherit distutils-r1

DESCRIPTION="Python library to read Squashfs image files"
HOMEPAGE="https://github.com/matteomattei/PySquashfsImage"
SRC_URI="https://github.com/matteomattei/${MY_PN}/archive/${COMMIT}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="GPL-3 LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"

BDEPEND="test? (
		dev-python/lz4[${PYTHON_USEDEP}]
		dev-python/python-lzo[${PYTHON_USEDEP}]
		dev-python/zstandard[${PYTHON_USEDEP}]
		sys-fs/squashfs-tools[lz4,lzma,lzo,zstd]
	)
"

S="${WORKDIR}/${MY_PN}-${COMMIT}"

distutils_enable_tests pytest
distutils_enable_sphinx docs --no-autodoc

python_prepare_all() {
	use doc && eapply "${FILESDIR}"/${PN}-0.9.0-fix-title-underline.patch

	distutils-r1_python_prepare_all
}
