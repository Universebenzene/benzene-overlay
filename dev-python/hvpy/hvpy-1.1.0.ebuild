# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1 optfeature pypi

DESCRIPTION="Helioviewer Python API Wrapper"
HOMEPAGE="https://hvpy.readthedocs.io"
KEYWORDS="~amd64 ~x86"

LICENSE="BSD-2"
SLOT="0"
PROPERTIES="test_network"
RESTRICT="test"

RDEPEND=">=dev-python/pydantic-2.0.0[${PYTHON_USEDEP}]
	>=dev-python/pydantic-settings-2.0.0[${PYTHON_USEDEP}]
	>=dev-python/requests-2.27.0[${PYTHON_USEDEP}]
"
BDEPEND="dev-python/setuptools-scm[${PYTHON_USEDEP}]
	doc? ( media-gfx/graphviz )
	test? ( dev-python/pytest-doctestplus[${PYTHON_USEDEP}] )
"

distutils_enable_tests pytest
distutils_enable_sphinx docs dev-python/sphinx-automodapi dev-python/sphinx-autodoc-typehints dev-python/sphinx-book-theme
