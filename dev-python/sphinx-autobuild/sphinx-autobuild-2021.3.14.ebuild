# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=flit
PYPI_NO_NORMALIZE=1
PYTHON_COMPAT=( python3_{10..13} )

inherit distutils-r1 pypi

DESCRIPTION="Rebuild Sphinx documentation on changes, with live-reload in the browser"
HOMEPAGE="https://github.com/executablebooks/sphinx-autobuild"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-python/sphinx[${PYTHON_USEDEP}]
	dev-python/livereload[${PYTHON_USEDEP}]
	dev-python/colorama[${PYTHON_USEDEP}]
"

distutils_enable_tests pytest
distutils_enable_sphinx docs --no-autodoc
