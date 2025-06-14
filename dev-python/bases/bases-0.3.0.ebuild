# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..14} )

inherit distutils-r1 pypi

DESCRIPTION="Python library for general Base-N encodings"
HOMEPAGE="https://bases.readthedocs.io"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND=">=dev-python/typing-extensions-4.6.0[${PYTHON_USEDEP}]
	>=dev-python/typing-validation-1.1.0[${PYTHON_USEDEP}]
"
BDEPEND=">=dev-python/setuptools-scm-6.2[${PYTHON_USEDEP}]
	test? ( dev-python/base58[${PYTHON_USEDEP}] )
"

distutils_enable_tests pytest
distutils_enable_sphinx docs dev-python/sphinx-rtd-theme
