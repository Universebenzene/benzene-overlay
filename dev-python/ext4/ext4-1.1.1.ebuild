# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..14} )

inherit distutils-r1 pypi

DESCRIPTION="Library for read only interactions with an ext4 filesystem"
HOMEPAGE="https://github.com/Eeems/python-ext4"
SRC_URI+=" test? ( https://github.com/Eeems/python-ext4/raw/refs/tags/v${PV}/test.py -> ${P}-test.py )"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND=">=dev-python/cachetools-6.0.0[${PYTHON_USEDEP}]
	>=dev-python/crcmod-1.7[${PYTHON_USEDEP}]
"

python_prepare_all() {
	if use test; then
		# https://github.com/Eeems/python-ext4/blob/main/test.sh
		install -Dm644 "${FILESDIR}"/${P}-test.txt "${T}"/txt_tmp/test.txt || die
		dd if=/dev/zero of=test.ext4.tmp count=1024 bs=1024 || die
		mkfs.ext4 test.ext4.tmp -d "${T}"/txt_tmp || die
		echo -n F > test.ext4 || die
		cat test.ext4.tmp >> test.ext4 || die
	fi

	distutils-r1_python_prepare_all
}

python_test() {
	${EPYTHON} "${DISTDIR}"/${P}-test.py || die "Tests failed with ${EPYTHON}"
}
