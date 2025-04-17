# Copyright 2022-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..13} )

inherit distutils-r1 pypi

DESCRIPTION="Data storage buffer compression and transformation codecs"
HOMEPAGE="http://numcodecs.readthedocs.io"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="examples msgpack zfpy"

DEPEND=">=dev-python/numpy-1.7[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}
	msgpack? ( dev-python/msgpack[${PYTHON_USEDEP}] )
	zfpy? ( dev-libs/zfp[python] )
"
BDEPEND=">dev-python/setuptools-scm-6.2[${PYTHON_USEDEP}]
	dev-python/cython[${PYTHON_USEDEP}]
	dev-python/py-cpuinfo[${PYTHON_USEDEP}]
	doc? ( dev-libs/zfp[python] )
	test? (
		dev-libs/zfp[python]
		dev-python/importlib-metadata[${PYTHON_USEDEP}]
		dev-python/msgpack[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest
distutils_enable_sphinx docs dev-python/sphinx-issues dev-python/numpydoc dev-python/pydata-sphinx-theme

python_prepare_all() {
	use test && { sed -i "s/--cov=numcodecs --cov-report xml //" pyproject.toml || die ; }
	sed -i "/_zfpy = None/a import zfpy as _zfpy" ${PN}/zfpy.py || die

	distutils-r1_python_prepare_all
}

python_compile_all() {
#	ModuleNotFoundError: No module named 'numcodecs._shuffle'
	use doc && [[ -d ${PN} ]] && { mv {,_}${PN} || die ; }
	sphinx_compile_all
	[[ -d _${PN} ]] && { mv {_,}${PN} || die ; }
}

python_install_all() {
	if use examples; then
		docompress -x "/usr/share/doc/${PF}/notebooks"
		docinto notebooks
		dodoc -r notebooks/.
	fi

	distutils-r1_python_install_all
}

python_test() {
	epytest "${BUILD_DIR}"
}
