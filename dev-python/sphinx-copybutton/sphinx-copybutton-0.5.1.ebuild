# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

#DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{8..11} )

inherit distutils-r1

DESCRIPTION="Add a copy button to code blocks in Sphinx"
HOMEPAGE="https://sphinx-copybutton.readthedocs.io"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz
	doc? ( https://github.com/executablebooks/sphinx-copybutton/raw/v${PV}/CHANGELOG.md -> ${P}-CHANGELOG.md )"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="code_style rtd"

RDEPEND=">=dev-python/sphinx-1.8[${PYTHON_USEDEP}]
	code_style? ( dev-vcs/pre-commit )
	rtd? (
		dev-python/ipython[${PYTHON_USEDEP}]
		dev-python/myst_nb[${PYTHON_USEDEP}]
		dev-python/sphinx-book-theme[${PYTHON_USEDEP}]
		dev-python/sphinx-examples[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests nose
distutils_enable_sphinx docs dev-python/sphinx-book-theme \
	dev-python/sphinx-examples \
	dev-python/ipython \
	dev-python/myst_nb \
	">=dev-python/myst_parser-0.18.0"

python_prepare_all() {
	use doc && { cp {"${DISTDIR}"/${P}-,"${S}"/}CHANGELOG.md || die ; \
#		sed -i "/language\ = /s/None/'en'/" docs/conf.py || die ; \
	}

	distutils-r1_python_prepare_all
}
