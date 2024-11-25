# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{{10..13},13t} )

inherit distutils-r1 pypi

DESCRIPTION="Python extension for MurmurHash (MurmurHash3)"
HOMEPAGE="https://mmh3.readthedocs.io"
SRC_URI+=" test? ( https://github.com/hajimes/mmh3/raw/refs/tags/v${PV}/tests/helper.py -> ${P}-helper.py )"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

distutils_enable_tests pytest

python_prepare_all() {
	use test && { cp {"${DISTDIR}"/${P}-,"${S}"/tests/}helper.py || die ; }

	distutils-r1_python_prepare_all
}
