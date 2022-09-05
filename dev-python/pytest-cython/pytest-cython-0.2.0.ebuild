# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

#DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{8..11} )

inherit distutils-r1

DESCRIPTION="A plugin for testing Cython extension modules"
HOMEPAGE="https://github.com/lgpage/pytest-cython"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND=">=dev-python/pytest-4.6[${PYTHON_USEDEP}]"

distutils_enable_tests --install pytest
distutils_enable_sphinx docs dev-python/sphinx-py3doc-enhanced-theme

python_prepare_all() {
	use doc && { sed -i "/github/s/\#/\%s\#/" docs/conf.py || die ; }

	distutils-r1_python_prepare_all
}
