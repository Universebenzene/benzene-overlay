# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYPI_NO_NORMALIZE=1
PYPI_PN=Flask-SocketIO
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1 pypi

DESCRIPTION="Socket.IO integration for Flask applications"
HOMEPAGE="http://flask-socketio.readthedocs.io"
SRC_URI+=" test? ( https://github.com/miguelgrinberg/Flask-SocketIO/raw/v${PV}/test_socketio.py -> ${P}-t-test_socketio.py )"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"	# bidict pytest-benchmark no x86

RDEPEND=">=dev-python/flask-0.9[${PYTHON_USEDEP}]
	>=dev-python/python-socketio-5.0.2[${PYTHON_USEDEP}]
"
BDEPEND="test? ( dev-python/redis[${PYTHON_USEDEP}] )"

distutils_enable_tests pytest

python_prepare_all() {
	use test && { cp {"${DISTDIR}"/${P}-t-,"${S}"/}test_socketio.py || die ; }

	distutils-r1_python_prepare_all
}

python_test() {
	epytest test_socketio.py
}
