# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=flit
PYTHON_COMPAT=( python3_{10..13} )

inherit distutils-r1

DESCRIPTION="A defined interface for working with a cache of jupyter notebooks"
HOMEPAGE="https://jupyter-cache.readthedocs.io"
SRC_URI="https://github.com/executablebooks/jupyter-cache/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="cli code_style rtd"

RDEPEND="dev-python/attrs[${PYTHON_USEDEP}]
	dev-python/click[${PYTHON_USEDEP}]
	dev-python/importlib-metadata[${PYTHON_USEDEP}]
	>=dev-python/nbclient-0.2[${PYTHON_USEDEP}]
	dev-python/nbformat[${PYTHON_USEDEP}]
	dev-python/pyyaml[${PYTHON_USEDEP}]
	dev-python/sqlalchemy[${PYTHON_USEDEP}]
	dev-python/tabulate[${PYTHON_USEDEP}]
	cli? ( dev-python/click-log[${PYTHON_USEDEP}] )
	code_style? ( >=dev-vcs/pre-commit-2.12 )
	rtd? (
		dev-python/ipykernel[${PYTHON_USEDEP}]
		dev-python/jupytext[${PYTHON_USEDEP}]
		dev-python/nbdime[${PYTHON_USEDEP}]
	)
"
BDEPEND="test? (
		dev-python/jupytext[${PYTHON_USEDEP}]
		dev-python/nbdime[${PYTHON_USEDEP}]
	)
"
PDEPEND="rtd? (
		dev-python/myst-nb[${PYTHON_USEDEP}]
		dev-python/sphinx-book-theme[${PYTHON_USEDEP}]
		dev-python/sphinx-copybutton[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest
distutils_enable_sphinx docs dev-python/sphinx-copybutton \
	dev-python/sphinx-book-theme \
	dev-python/myst-nb \
	dev-python/jupytext \
	dev-python/nbdime
