# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..11} )

inherit distutils-r1

DESCRIPTION="Python Socket.IO server and client"
HOMEPAGE="https://python-socketio.readthedocs.io"
SRC_URI="https://github.com/miguelgrinberg/python-socketio/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"	# bidict pytest-benchmark no x86
IUSE="asyncio-client client examples"

RDEPEND=">=dev-python/bidict-0.21.0[${PYTHON_USEDEP}]
	>=dev-python/python-engineio-4.7.0[${PYTHON_USEDEP}]
	client? (
		>=dev-python/requests-2.21.0[${PYTHON_USEDEP}]
		>=dev-python/websocket-client-0.54.0[${PYTHON_USEDEP}]
	)
	asyncio-client? ( >=dev-python/aiohttp-3.4[${PYTHON_USEDEP}] )
"
BDEPEND="test? ( dev-python/msgpack[${PYTHON_USEDEP}] )"

distutils_enable_tests pytest
distutils_enable_sphinx docs

#python_prepare_all() {
#	use doc && { sed -i "/language\ = /s/None/'en'/" docs/conf.py || die ; }
#
#	distutils-r1_python_prepare_all
#}

python_install_all() {
	if use examples; then
		docompress -x "/usr/share/doc/${PF}/examples"
		docinto examples
		dodoc -r examples/.
	fi

	distutils-r1_python_install_all
}
