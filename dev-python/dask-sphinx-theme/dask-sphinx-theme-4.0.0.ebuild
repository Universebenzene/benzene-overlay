# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1 pypi

DESCRIPTION="Sphinx theme for Dask documentation"
HOMEPAGE="https://github.com/dask/dask-sphinx-theme"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="test"	# No usable test phases

RDEPEND=">=dev-python/sphinx-7.0[${PYTHON_USEDEP}]
	dev-python/jsonschema[${PYTHON_USEDEP}]
	dev-python/numpydoc[${PYTHON_USEDEP}]
	dev-python/pyyaml[${PYTHON_USEDEP}]
	>=dev-python/sphinx-book-theme-1[${PYTHON_USEDEP}]
"
BDEPEND="dev-python/hatch-vcs[${PYTHON_USEDEP}]"

#distutils_enable_tests nose
distutils_enable_sphinx docs dev-python/sphinx-autosummary-accessors \
	dev-python/sphinx-click \
	dev-python/sphinx-copybutton \
	dev-python/sphinx-design \
	dev-python/sphinx-remove-toctrees \
	dev-python/sphinx-tabs
