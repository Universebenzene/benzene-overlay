# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..14} )

inherit distutils-r1 pypi

DESCRIPTION="Sphinx autosummary extension to properly format pandas or xarray accessors"
HOMEPAGE="https://sphinx-autosummary-accessors.readthedocs.io"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="test"	# No usable test phases

RDEPEND=">=dev-python/sphinx-5.3[${PYTHON_USEDEP}]
	dev-python/packaging[${PYTHON_USEDEP}]
"
BDEPEND=">=dev-python/setuptools-scm-7.0[${PYTHON_USEDEP}]"

#distutils_enable_tests nose
distutils_enable_sphinx docs dev-python/sphinx-rtd-theme
