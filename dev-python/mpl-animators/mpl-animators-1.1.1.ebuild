# Copyright 2021-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1 optfeature pypi

DESCRIPTION="An interative animation framework for matplotlib"
HOMEPAGE="https://sunpy.org"
KEYWORDS="~amd64 ~x86"

LICENSE="BSD"
SLOT="0"
IUSE="all"

RDEPEND=">=dev-python/matplotlib-3.5.0[${PYTHON_USEDEP}]
	all? ( >=dev-python/astropy-5.0.6[${PYTHON_USEDEP}] )
"
BDEPEND="${RDEPEND}
	dev-python/setuptools-scm[${PYTHON_USEDEP}]
	doc? ( media-gfx/graphviz )
	test? (
		dev-python/pytest-mpl[${PYTHON_USEDEP}]
		dev-python/astropy[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest
distutils_enable_sphinx docs dev-python/sphinx-automodapi dev-python/sunpy-sphinx-theme dev-python/astropy

pkg_postinst() {
	optfeature "WCS support" ">=dev-python/astropy-5.0.6"
}
