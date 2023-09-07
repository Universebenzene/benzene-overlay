# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

#DISTUTILS_USE_PEP517=setuptools
PYPI_NO_NORMALIZE=1
PYPI_PN="${PN}-2"
PYTHON_COMPAT=( python3_{10..11} )

inherit distutils-r1 pypi

DESCRIPTION="An MkDocs plugin to create a list of contributors on the page"
HOMEPAGE="https://github.com/ojacques/mkdocs-git-committers-plugin-2"
SRC_URI+=" https://github.com/ojacques/mkdocs-git-committers-plugin-2/raw/${PV}/requirements.txt -> ${P}-requirements.txt"

LICENSE="BSD"
SLOT="2"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-python/beautifulsoup4[${PYTHON_USEDEP}]
	dev-python/GitPython[${PYTHON_USEDEP}]
	dev-python/mkdocs[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
"

distutils_enable_tests nose

python_prepare_all() {
	cp {"${DISTDIR}"/${P}-,"${S}"/}requirements.txt || die

	distutils-r1_python_prepare_all
}
