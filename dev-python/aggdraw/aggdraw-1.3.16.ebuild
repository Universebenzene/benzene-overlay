# Copyright 2022-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1

DESCRIPTION="High quality drawing interface for PIL"
HOMEPAGE="https://aggdraw.readthedocs.io"
SRC_URI="https://github.com/pytroll/aggdraw/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"

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
distutils_enable_sphinx doc/source

python_prepare_all() {
	use doc && { mkdir -p doc/source/_static || die ; \
#		sed -i "/language\ = /s/None/'en'/" doc/source/conf.py || die ; \
	}

	distutils-r1_python_prepare_all
}

python_test() {
	${EPYTHON} selftest.py || die "Tests failed with ${EPYTHON}"
}
