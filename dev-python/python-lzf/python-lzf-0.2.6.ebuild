# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{{11..14},{13..14}t} )
#PYTHON_COMPAT=( python3_{{11..12},{13..14}{,t}} )

inherit distutils-r1 pypi

DESCRIPTION="python bindings to liblzf, a speed demon compression library "
HOMEPAGE="https://github.com/teepark/python-lzf"
SRC_URI+=" test? ( https://github.com/teepark/python-lzf/raw/refs/tags/release-${PV}/tests.py -> ${P}-test.py )"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="dev-libs/liblzf:="
RDEPEND="${DEPEND}"

PATCHES=( "${FILESDIR}/${P}-devendor.patch" )

distutils_enable_tests unittest

python_prepare_all() {
	rm lzf_?.c lzf*h || die
	use test && { cp {"${DISTDIR}"/${P}-,"${S}"/}test.py || die ; }

	distutils-r1_python_prepare_all
}
