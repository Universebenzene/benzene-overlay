# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{9..10} )

MY_PN=Flask-SocketIO
MY_P=${MY_PN}-${PV}

inherit distutils-r1

DESCRIPTION="Socket.IO integration for Flask applications"
HOMEPAGE="http://flask-socketio.readthedocs.io"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND=">=dev-python/flask-0.9[${PYTHON_USEDEP}]
	>=dev-python/python-socketio-5.0.2[${PYTHON_USEDEP}]
"

S="${WORKDIR}/${MY_P}"

distutils_enable_tests nose
