# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYPI_NO_NORMALIZE=1
PYPI_PN="${PN^}"
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1 pypi

DESCRIPTION="A browser-based particle visualization platform"
HOMEPAGE="https://github.com/ageller/Firefly"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"	# bidict pytest-benchmark no x86
RESTRICT="test"	# No usable test phases

RDEPEND="dev-python/numpy[${PYTHON_USEDEP}]
	dev-python/h5py[${PYTHON_USEDEP}]
	dev-python/pandas[${PYTHON_USEDEP}]
	dev-python/eventlet[${PYTHON_USEDEP}]
	dev-python/flask-socketio[${PYTHON_USEDEP}]
	dev-python/flask[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
	>=dev-python/abg-python-1.0.5[${PYTHON_USEDEP}]
"

#distutils_enable_tests nose
