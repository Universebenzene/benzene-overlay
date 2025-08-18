# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1 pypi

DESCRIPTION="Sweet and creamy print debugging"
HOMEPAGE="https://github.com/gruns/icecream"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND=">=dev-python/asttokens-2.0.1[${PYTHON_USEDEP}]
	>=dev-python/colorama-0.3.9[${PYTHON_USEDEP}]
	>=dev-python/executing-2.1.0[${PYTHON_USEDEP}]
	>=dev-python/pygments-2.2.0[${PYTHON_USEDEP}]
"
BDEPEND="test? ( dev-python/sympy[${PYTHON_USEDEP}] )"

distutils_enable_tests pytest
