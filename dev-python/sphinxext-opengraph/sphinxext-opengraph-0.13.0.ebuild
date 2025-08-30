# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=flit
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1 optfeature pypi

DESCRIPTION="Sphinx extension to generate unique OpenGraph metadata"
HOMEPAGE="https://sphinxext-opengraph.readthedocs.io"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="rtd social_cards"

RDEPEND=">=dev-python/sphinx-6.0[${PYTHON_USEDEP}]
	rtd? (
		>=dev-python/furo-2024[${PYTHON_USEDEP}]
		dev-python/sphinx-design[${PYTHON_USEDEP}]
	)
	social_cards? ( >=dev-python/matplotlib-3[${PYTHON_USEDEP}] )
"
BDEPEND="test? (
		dev-python/beautifulsoup4[${PYTHON_USEDEP}]
		dev-python/matplotlib[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest
distutils_enable_sphinx docs dev-python/sphinx-design dev-python/accessible-pygments \
	dev-python/furo dev-python/matplotlib

pkg_postinst() {
	optfeature "generating social cards" dev-python/matplotlib
}
