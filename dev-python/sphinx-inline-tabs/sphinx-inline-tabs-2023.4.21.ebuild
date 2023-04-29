# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=flit
PYTHON_COMPAT=( python3_{10..11} )

inherit distutils-r1 pypi

DESCRIPTION="Add inline tabbed content to your Sphinx documentation"
HOMEPAGE="https://sphinx-inline-tabs.readthedocs.io"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND=">=dev-python/sphinx-3[${PYTHON_USEDEP}]"

distutils_enable_tests nose
distutils_enable_sphinx docs dev-python/furo dev-python/myst-parser

#python_prepare_all() {
#	use doc && { sed -i -e "/\"pypi\"/s/\"\"/\"\%s\"/" docs/conf.py || die ; }
#	distutils-r1_python_prepare_all
#}
