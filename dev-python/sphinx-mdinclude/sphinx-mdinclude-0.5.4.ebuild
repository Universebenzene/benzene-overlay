# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=flit
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1 pypi

DESCRIPTION="Markdown extension for Sphinx"
HOMEPAGE="https://sphinx-mdinclude.readthedocs.io"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND=">=dev-python/mistune-2.0.4[${PYTHON_USEDEP}]
	<dev-python/mistune-3.0[${PYTHON_USEDEP}]
	<dev-python/docutils-1.0[${PYTHON_USEDEP}]
	>=dev-python/pygments-2.8[${PYTHON_USEDEP}]
"
BDEPEND="test? ( dev-python/sphinx[${PYTHON_USEDEP}] )"

distutils_enable_tests pytest
distutils_enable_sphinx docs
