# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
#DISTUTILS_USE_PEP517=setuptools
PYPI_NO_NORMALIZE=1
PYPI_PN="astLib"
PYTHON_COMPAT=( python3_{10..11} )

DOCS_BUILDER="sphinx"
DOCS_DEPEND="dev-python/sphinx-epytext
	dev-python/readthedocs-sphinx-ext
	dev-python/sphinx-rtd-theme
"
DOCS_DIR="docs"

inherit distutils-r1 pypi docs

DESCRIPTION="Python astronomy modules for image and coordinate manipulation"
HOMEPAGE="https://astlib.readthedocs.io"

SLOT="0"
KEYWORDS="~amd64 ~x86"
LICENSE="GPL-2 LGPL-2.1"

IUSE="examples"

DEPEND="sci-astronomy/wcstools"
RDEPEND="${DEPEND}
	>=dev-python/astropy-3.2.1[${PYTHON_USEDEP}]
	>=dev-python/matplotlib-3.1.1[${PYTHON_USEDEP}]
	>=dev-python/scipy-1.3.1[${PYTHON_USEDEP}]
"
BDEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
	dev-lang/swig
"

PATCHES=( "${FILESDIR}/${P}-system-wcstools.patch" )

distutils_enable_tests nose
# cannot import name '*' from 'PyWCSTools
#distutils_enable_sphinx docs dev-python/sphinx-epytext dev-python/readthedocs-sphinx-ext dev-python/sphinx-rtd-theme

python_prepare_all() {
	use doc && { mkdir -p docs/_static || die ; }

	distutils-r1_python_prepare_all
}

#python_compile_all() {
#	use doc && { cp "${BUILD_DIR}"/lib/PyWCSTools/*.cpython*so "${S}/PyWCSTools" || die ; }
#
#	sphinx_compile_all
#}

python_install_all() {
	dodoc CHANGE_LOG
	if use examples; then
		docompress -x "/usr/share/doc/${PF}/examples"
		docinto examples
		dodoc -r examples/.
	fi

	distutils-r1_python_install_all
}
