# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYPI_NO_NORMALIZE=1
PYTHON_COMPAT=( python3_{11..14} )

inherit distutils-r1 pypi

DESCRIPTION="Pytest plugin for filtering based on sub-packages"
HOMEPAGE="https://github.com/astropy/pytest-filter-subpackage"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND=">=dev-python/pytest-4.6[${PYTHON_USEDEP}]
	dev-python/packaging[${PYTHON_USEDEP}]
"
DEPEND="${RDEPEND}"
BDEPEND="dev-python/setuptools-scm[${PYTHON_USEDEP}]
	test? ( dev-python/pytest-doctestplus[${PYTHON_USEDEP}] )
"

distutils_enable_tests pytest
