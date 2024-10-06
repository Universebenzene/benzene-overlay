# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1 pypi

DESCRIPTION="A browser-based particle visualization platform"
HOMEPAGE="https://github.com/ageller/Firefly"

LICENSE="AGPL-3"
SLOT="0"
KEYWORDS="~amd64"	# flask bidict no x86
RESTRICT="test"	# TypeError: value type <class 'bool'> does not match default value type <class 'dict'>

RDEPEND="dev-python/numpy[${PYTHON_USEDEP}]
	dev-python/h5py[${PYTHON_USEDEP}]
	dev-python/pandas[${PYTHON_USEDEP}]
	dev-python/eventlet[${PYTHON_USEDEP}]
	dev-python/flask-socketio[${PYTHON_USEDEP}]
	dev-python/flask[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
	>=dev-python/abg-python-1.1.1[${PYTHON_USEDEP}]
"

distutils_enable_tests pytest

python_prepare_all() {
	use test && { sed -i 's/Default/default/g' src/firefly/tests/test_settings.py || die ; }

	distutils-r1_python_prepare_all
}
