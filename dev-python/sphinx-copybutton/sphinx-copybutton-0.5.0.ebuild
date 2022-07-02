# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

#DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{8..10} )

inherit distutils-r1 optfeature

DESCRIPTION="Add a copy button to code blocks in Sphinx"
HOMEPAGE="https://sphinx-copybutton.readthedocs.io"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="code_style"

RDEPEND=">=dev-python/sphinx-1.8[${PYTHON_USEDEP}]
	code_style? ( dev-vcs/pre-commit )
"

distutils_enable_tests nose
# Doc build failed for nbclient>=0.6
distutils_enable_sphinx docs dev-python/myst_nb ">=dev-python/myst_parser-0.18.0" dev-python/sphinx-book-theme

pkg_postinst() {
	optfeature "extra rtd support" "dev-python/ipython dev-python/myst_nb dev-python/sphinx-book-theme dev-python/sphinx-examples"
}
