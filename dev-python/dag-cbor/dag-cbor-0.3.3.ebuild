# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYPI_NO_NORMALIZE=1
PYTHON_COMPAT=( python3_{10..13} )

inherit distutils-r1 pypi

DESCRIPTION="Python implementation of the DAG-CBOR codec"
HOMEPAGE="https://dag-cbor.readthedocs.io"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND=">=dev-python/typing-extensions-4.6.0[${PYTHON_USEDEP}]
	>=dev-python/typing-validation-1.1.0[${PYTHON_USEDEP}]
	>=dev-python/multiformats-0.3.1[${PYTHON_USEDEP}]
"
BDEPEND=">=dev-python/setuptools-scm-6.2[${PYTHON_USEDEP}]
	test? ( dev-python/cbor2[${PYTHON_USEDEP}] )
"

distutils_enable_tests pytest
distutils_enable_sphinx docs dev-python/sphinx-rtd-theme

python_prepare_all() {
	use test && { sed -i -e "/cbor2.decoder/a import cbor2._decoder as _cbor2" \
		-e 's/cbor2.CBORTag/_cbor2.CBORTag/' test/test_02_decode_eq_cbor2_decode.py || die ; }

	distutils-r1_python_prepare_all
}
