# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=flit
PYPI_NO_NORMALIZE=1
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1 optfeature pypi

DESCRIPTION="A lightweight example directive to make it easy to demonstrate code / results"
HOMEPAGE="https://ebp-sphinx-examples.readthedocs.io"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND=">dev-python/sphinx-4[${PYTHON_USEDEP}]
	dev-python/sphinx-design[${PYTHON_USEDEP}]"

distutils_enable_tests import-check

pkg_postinst() {
	optfeature "extra sphinx support" "dev-python/sphinx-book-theme dev-python/sphinx-copybutton dev-python/myst-parser \
		dev-python/sphinx-rtd-theme dev-python/furo"
}
