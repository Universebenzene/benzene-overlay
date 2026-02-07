# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1 pypi

DESCRIPTION="Interstellar Dust Extinction Models"
HOMEPAGE="https://dust-extinction.readthedocs.io"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-python/astropy[${PYTHON_USEDEP}]
	dev-python/scipy[${PYTHON_USEDEP}]
"
BDEPEND=">=dev-python/setuptools-scm-8.0.0[${PYTHON_USEDEP}]
	doc? ( media-gfx/graphviz )
	test? ( dev-python/matplotlib[${PYTHON_USEDEP}] )
"

EPYTEST_PLUGINS=( pytest-{astropy-header,doctestplus} )
distutils_enable_tests pytest
distutils_enable_sphinx docs dev-python/sphinx-automodapi dev-python/matplotlib

python_test() {
	use doc && local EPYTEST_IGNORE=( docs/_build )
	epytest
}
