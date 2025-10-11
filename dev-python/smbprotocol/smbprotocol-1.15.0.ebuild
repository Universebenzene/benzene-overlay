# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..14} )

inherit distutils-r1 pypi

DESCRIPTION="Interact with a server using the SMB 2/3 Protocol"
HOMEPAGE="https://github.com/jborean93/smbprotocol"
SRC_URI+=" test? ( ${HOMEPAGE}/raw/refs/tags/v${PV}/tests/conftest.py  -> ${P}-conftest.py )"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND=">=dev-python/cryptography-2.0[${PYTHON_USEDEP}]
	dev-python/pyspnego[${PYTHON_USEDEP}]
"

EPYTEST_PLUGINS=( pytest-mock )
distutils_enable_tests pytest

python_prepare_all() {
	use test && { cp {"${DISTDIR}"/${P}-,"${S}"/tests/}conftest.py || die ; }

	distutils-r1_python_prepare_all
}
