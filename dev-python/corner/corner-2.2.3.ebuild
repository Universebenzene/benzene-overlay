# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1 optfeature pypi

DESCRIPTION="Make scatter matrix corner plots"
HOMEPAGE="https://corner.readthedocs.io"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64"	# arviz no x86
IUSE="arviz"
RESTRICT="test"	# matplotlib.testing.exceptions.ImageComparisonFailure: images not close

RDEPEND=">=dev-python/matplotlib-2.1[${PYTHON_USEDEP}]
	arviz? ( >=dev-python/arviz-0.9[${PYTHON_USEDEP}] )"
BDEPEND="dev-python/hatch-vcs[${PYTHON_USEDEP}]
	test? (
		>=dev-python/arviz-0.9[${PYTHON_USEDEP}]
		dev-python/scipy[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest
distutils_enable_sphinx docs dev-python/sphinx-book-theme \
	dev-python/myst-nb \
	dev-python/arviz

pkg_postinst() {
	optfeature "optional dependency" dev-python/scipy
}
