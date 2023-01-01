# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

#DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{8..10} )

H5PY_EXPV="3.7.0"

inherit distutils-r1

DESCRIPTION="h5py distributed - Python client library for HDF Rest API"
HOMEPAGE="https://github.com/HDFGroup/h5pyd"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND=">=dev-python/numpy-1.17.3[${PYTHON_USEDEP}]
	dev-python/adal[${PYTHON_USEDEP}]
	dev-python/cryptography[${PYTHON_USEDEP}]
	dev-python/google-api-python-client[${PYTHON_USEDEP}]
	dev-python/google-auth[${PYTHON_USEDEP}]
	dev-python/google-auth-oauthlib[${PYTHON_USEDEP}]
	dev-python/msrestazure[${PYTHON_USEDEP}]
	dev-python/pytz[${PYTHON_USEDEP}]
	dev-python/pyjwt[${PYTHON_USEDEP}]
	dev-python/requests-unixsocket[${PYTHON_USEDEP}]
"
BDEPEND="dev-python/pkgconfig[${PYTHON_USEDEP}]"

distutils_enable_tests pytest
# no docs dir since 0.12.4
#distutils_enable_sphinx docs dev-python/furo

python_prepare_all() {
	use test && eapply "${FILESDIR}"/${PN}-0.10.3-fix-h5type-test.patch

	distutils-r1_python_prepare_all
}
