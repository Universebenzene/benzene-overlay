# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..13} )

inherit distutils-r1 pypi

DESCRIPTION="ABlog for blogging with Sphinx"
HOMEPAGE="https://parfive.readthedocs.io"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="markdown notebook"

RDEPEND=">=dev-python/docutils-0.18[${PYTHON_USEDEP}]
	>=dev-python/feedgen-0.9.0[${PYTHON_USEDEP}]
	>=dev-python/invoke-1.6.0[${PYTHON_USEDEP}]
	>=dev-python/packaging-19.0[${PYTHON_USEDEP}]
	>=dev-python/python-dateutil-2.8.2[${PYTHON_USEDEP}]
	>=dev-python/sphinx-6.2.0[${PYTHON_USEDEP}]
	>=dev-python/watchdog-2.1.0[${PYTHON_USEDEP}]
	markdown? ( >=dev-python/myst-parser-0.17.0[${PYTHON_USEDEP}] )
	notebook? (
		>=dev-python/ipython-7.30.0[${PYTHON_USEDEP}]
		>=dev-python/nbsphinx-0.8.0[${PYTHON_USEDEP}]
	)
"

BDEPEND="dev-python/setuptools-scm[${PYTHON_USEDEP}]
	doc? (
		media-gfx/graphviz
		virtual/pandoc
	)
"

distutils_enable_tests pytest
distutils_enable_sphinx docs dev-python/sphinx-automodapi dev-python/myst-parser dev-python/nbsphinx

python_test() {
	PYTHONPATH="${BUILD_DIR}"/install/$(python_get_sitedir) epytest
}
