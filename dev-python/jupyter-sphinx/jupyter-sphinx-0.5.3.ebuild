# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{10..13} )

inherit distutils-r1

DESCRIPTION="Sphinx extension for rendering of Jupyter interactive widgets"
HOMEPAGE="https://jupyter-sphinx.readthedocs.io"
SRC_URI="https://github.com/jupyter/jupyter-sphinx/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND=">=dev-python/sphinx-7[${PYTHON_USEDEP}]
	>=dev-python/ipykernel-4.5.1[${PYTHON_USEDEP}]
	>=dev-python/ipywidgets-7.0.0[${PYTHON_USEDEP}]
	>=dev-python/nbconvert-5.5[${PYTHON_USEDEP}]
	dev-python/nbformat[${PYTHON_USEDEP}]
"

distutils_enable_tests pytest
distutils_enable_sphinx doc/source dev-python/matplotlib
