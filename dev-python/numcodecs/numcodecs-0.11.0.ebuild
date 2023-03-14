# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{9..11} )

inherit distutils-r1 pypi

DESCRIPTION="Data storage buffer compression and transformation codecs"
HOMEPAGE="http://numcodecs.readthedocs.io"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="examples msgpack zfpy"
RESTRICT="test"	# Test phase runs with fails

RDEPEND=">=dev-python/numpy-1.7[${PYTHON_USEDEP}]
	dev-python/entrypoints[${PYTHON_USEDEP}]
	msgpack? ( dev-python/msgpack[${PYTHON_USEDEP}] )
	zfpy? ( dev-libs/zfp[python] )
"
BDEPEND=">dev-python/setuptools-scm-6.2[${PYTHON_USEDEP}]
	dev-python/cython[${PYTHON_USEDEP}]
	dev-python/py-cpuinfo[${PYTHON_USEDEP}]
	doc? ( dev-libs/zfp[python] )
	test? (
		dev-python/msgpack[${PYTHON_USEDEP}]
		dev-libs/zfp[python]
	)
"

distutils_enable_tests pytest
distutils_enable_sphinx docs dev-python/sphinx-issues dev-python/numpydoc

python_prepare_all() {
	use test && { sed -i "s/--cov=numcodecs --cov-report xml //" pyproject.toml || die ; }

	distutils-r1_python_prepare_all
}

python_compile_all() {
	use doc && { cp "${BUILD_DIR}"/install/$(python_get_sitedir)/${PN}/*.cpython*so "${S}/${PN}" || die ; }

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
	epytest "${BUILD_DIR}"
}
