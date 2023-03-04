# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

#DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{9..11} )

inherit distutils-r1

DESCRIPTION="Data storage buffer compression and transformation codecs"
HOMEPAGE="http://numcodecs.readthedocs.io"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="examples msgpack"
#RESTRICT="test"	# Fatal Python error: Aborted

RDEPEND=">=dev-python/numpy-1.7[${PYTHON_USEDEP}]
	dev-python/entrypoints[${PYTHON_USEDEP}]
	>=dev-python/typing-extensions-3.7.4[${PYTHON_USEDEP}]
	msgpack? ( dev-python/msgpack[${PYTHON_USEDEP}] )
"
BDEPEND=">dev-python/setuptools-scm-1.5.4[${PYTHON_USEDEP}]
	dev-python/cython[${PYTHON_USEDEP}]
	doc? ( dev-libs/zfp[python] )
	test? (
		dev-python/msgpack[${PYTHON_USEDEP}]
		dev-libs/zfp[python]
	)
"

distutils_enable_tests pytest
distutils_enable_sphinx docs dev-python/sphinx-issues dev-python/sphinx-rtd-theme dev-python/numpydoc

EPYTEST_DESELECT=(
	# Fatal Python error: Aborted
	numcodecs/tests/test_vlen_bytes.py::test_encode_none
)

python_compile_all() {
	use doc && { cp "${BUILD_DIR}"/lib/${PN}/*.cpython*so "${S}/${PN}" || die ; }

	sphinx_compile_all
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
	pushd "${BUILD_DIR}"/lib || die
	epytest
	popd || die
}
