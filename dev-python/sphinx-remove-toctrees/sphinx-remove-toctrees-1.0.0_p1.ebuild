# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1 pypi

DESCRIPTION="Reduce your documentation build size by selectively removing toctrees from pages"
HOMEPAGE="https://github.com/executablebooks/sphinx-remove-toctrees"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND=">=dev-python/sphinx-5[${PYTHON_USEDEP}]"
BDEPEND="test? (
		dev-python/myst-parser[${PYTHON_USEDEP}]
		dev-python/sphinx-book-theme[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest
distutils_enable_sphinx docs dev-python/sphinx-book-theme dev-python/myst-parser

#python_prepare_all() {
#	use doc && { sed -i "/language\ = /s/None/'en'/" docs/conf.py || die ; }
#
#	distutils-r1_python_prepare_all
#}
