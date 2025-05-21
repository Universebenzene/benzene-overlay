# Copyright 2022-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..14} )

inherit distutils-r1 pypi

#MY_PV=$(pypi_translate_version ${PV})

DESCRIPTION="High quality drawing interface for PIL"
HOMEPAGE="https://aggdraw.readthedocs.io"
SRC_URI+=" test? ( https://github.com/pytroll/aggdraw/raw/v${PV}/selftest.py -> ${P}-selftest.py )"
#SRC_URI+=" test? ( https://github.com/pytroll/aggdraw/raw/v${MY_PV}/selftest.py -> ${P}-selftest.py )"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="media-libs/freetype:2"
RDEPEND="${DEPEND}"
BDEPEND="test? (
		dev-python/numpy[${PYTHON_USEDEP}]
		dev-python/pillow[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest

python_prepare_all() {
	use test && { cp {"${DISTDIR}"/${P}-,"${S}"/test_}selftest.py || die ; }

	distutils-r1_python_prepare_all
}
