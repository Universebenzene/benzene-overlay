# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..13} )

inherit distutils-r1 pypi

DESCRIPTION="Python astronomy modules for image and coordinate manipulation"
HOMEPAGE="https://astlib.readthedocs.io"

SLOT="0"
KEYWORDS="~amd64 ~x86"
LICENSE="GPL-2 LGPL-2.1"

IUSE="doc examples"

DEPEND=">=dev-python/numpy-1.10[${PYTHON_USEDEP}]
	sci-astronomy/wcstools
"
RDEPEND="${DEPEND}
	>=dev-python/astropy-3.2[${PYTHON_USEDEP}]
	>=dev-python/matplotlib-3.0[${PYTHON_USEDEP}]
	>=dev-python/scipy-1.7[${PYTHON_USEDEP}]
"
BDEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
	dev-lang/swig
"

PATCHES=( "${FILESDIR}/${PN}-0.12.0-system-wcstools.patch" )

distutils_enable_tests pytest
## already built in pypi source
distutils_enable_sphinx docs dev-python/sphinx-epytext dev-python/readthedocs-sphinx-ext dev-python/sphinx-rtd-theme

python_prepare_all() {
	use doc && { mkdir -p docs/_static || die ; }

	distutils-r1_python_prepare_all
}

python_compile_all() {
#	cannot import name '*' from 'PyWCSTools
	use doc && [[ -d PyWCSTools ]] && { mv {,_}PyWCSTools || die ; }
	sphinx_compile_all
	[[ -d _PyWCSTools ]] && { mv {_,}PyWCSTools || die ; }
}

python_install_all() {
	dodoc CHANGE_LOG
	#use doc && HTML_DOCS=( docs/_build/html/. )
	if use examples; then
		docompress -x "/usr/share/doc/${PF}/examples"
		docinto examples
		dodoc -r examples/.
	fi

	distutils-r1_python_install_all
}

python_test() {
#	cannot import name '*' from 'PyWCSTools
	[[ -d PyWCSTools ]] && { mv {,_}PyWCSTools || die ; }
	epytest
	[[ -d _PyWCSTools ]] && { mv {_,}PyWCSTools || die ; }
}
