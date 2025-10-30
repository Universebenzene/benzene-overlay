# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=flit
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1 optfeature

DESCRIPTION="A lightweight example directive to make it easy to demonstrate code / results"
HOMEPAGE="https://ebp-sphinx-examples.readthedocs.io"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="test"	# No usable test phases

RDEPEND=">dev-python/sphinx-4[${PYTHON_USEDEP}]
	dev-python/sphinx-design[${PYTHON_USEDEP}]"

#distutils_enable_tests nose

pkg_postinst() {
	optfeature "extra sphinx support" "dev-python/sphinx-book-theme dev-python/sphinx-copybutton dev-python/myst-parser \
		dev-python/sphinx-rtd-theme dev-python/furo"
}
