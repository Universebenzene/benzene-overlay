# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{14..15} )

inherit distutils-r1

DESCRIPTION="A library to perform runtime validation of Python objects using type hints"
HOMEPAGE="https://typing-validation.readthedocs.io"
SRC_URI="https://github.com/hashberg-io/typing-validation/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="LGPL-3+"
SLOT="0"
KEYWORDS="~amd64 ~x86"

BDEPEND="test? (
		dev-python/mypy[${PYTHON_USEDEP}]
		dev-python/numpy[${PYTHON_USEDEP}]
	)
"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest
distutils_enable_sphinx docs dev-python/sphinx-autodoc-typehints dev-python/sphinx-rtd-theme dev-python/numpy
