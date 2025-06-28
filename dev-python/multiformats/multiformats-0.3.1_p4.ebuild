# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..14} )

inherit distutils-r1 optfeature pypi

DESCRIPTION="Python implementation of multiformats protocols"
HOMEPAGE="https://multiformats.readthedocs.io"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND=">=dev-python/typing-extensions-4.6.0[${PYTHON_USEDEP}]
	>=dev-python/typing-validation-1.1.0[${PYTHON_USEDEP}]
	>=dev-python/bases-0.3.0[${PYTHON_USEDEP}]
	>=dev-python/multiformats-config-0.3.0[${PYTHON_USEDEP}]
"
BDEPEND=">=dev-python/setuptools-scm-6.2[${PYTHON_USEDEP}]
	test? (
		dev-python/blake3[${PYTHON_USEDEP}]
		dev-python/mmh3[${PYTHON_USEDEP}]
		dev-python/pyskein[${PYTHON_USEDEP}]
		dev-python/pycryptodomex[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest
distutils_enable_sphinx docs dev-python/sphinx-rtd-theme

pkg_postinst() {
	optfeature "the blake3 hash function" dev-python/blake3
	optfeature "the skein hash functions" dev-python/pyskein
	optfeature "the murmur3 hash functions" dev-python/mmh3
	optfeature "the ripemd-160 hash function, the kangarootwelve hash function, the keccak hash functions and the sha2-512-224/sha2-512-256 hash functions" dev-python/pycryptodomex
}
