# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1

DESCRIPTION="ADAL for Python"
HOMEPAGE="http://adal-python.readthedocs.io"
SRC_URI="https://github.com/AzureAD/azure-activedirectory-library-for-python/archive/refs/tags/${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
PROPERTIES="test_network"
RESTRICT="test"

RDEPEND="<dev-python/pyjwt-3[${PYTHON_USEDEP}]
	<dev-python/requests-3[${PYTHON_USEDEP}]
	<dev-python/python-dateutil-3[${PYTHON_USEDEP}]
	>=dev-python/cryptography-1.1.0[${PYTHON_USEDEP}]
"
BDEPEND="test? ( dev-python/httpretty[${PYTHON_USEDEP}] )"

S="${WORKDIR}/azure-activedirectory-library-for-python-${PV}"

distutils_enable_tests pytest
distutils_enable_sphinx docs/source dev-python/sphinx-rtd-theme

python_prepare_all() {
	use doc && { mkdir -p docs/source/_static || die ; \
#		sed -i "/language\ = /s/None/'en'/" docs/source/conf.py || die ; \
	}

	distutils-r1_python_prepare_all
}
