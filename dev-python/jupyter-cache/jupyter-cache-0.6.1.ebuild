# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=flit
PYTHON_COMPAT=( python3_{10..11} )

inherit distutils-r1

DESCRIPTION="A defined interface for working with a cache of jupyter notebooks"
HOMEPAGE="https://jupyter-cache.readthedocs.io"
SRC_URI="https://github.com/executablebooks/jupyter-cache/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-python/attrs[${PYTHON_USEDEP}]
	dev-python/click[${PYTHON_USEDEP}]
	dev-python/importlib-metadata[${PYTHON_USEDEP}]
	dev-python/nbclient[${PYTHON_USEDEP}]
	dev-python/nbformat[${PYTHON_USEDEP}]
	dev-python/pyyaml[${PYTHON_USEDEP}]
	dev-python/sqlalchemy[${PYTHON_USEDEP}]
	dev-python/tabulate[${PYTHON_USEDEP}]
"
BDEPEND="test? ( dev-python/nbdime[${PYTHON_USEDEP}] )"

distutils_enable_tests pytest
# jupytext required
#distutils_enable_sphinx docs dev-python/python-sphinx-copybutton \
#	dev-python/python-sphinx-book-theme \
#	dev-python/python-myst-nb \
#	dev-python/python-jupytext \
#	dev-python/python-nbdime

EPYTEST_DESELECT=(
	# jupytext required
	tests/test_cache.py::test_execution_jupytext
)
