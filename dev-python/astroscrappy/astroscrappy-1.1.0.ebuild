# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{9..10} )

inherit distutils-r1

DESCRIPTION="Optimized cosmic ray annihilation astropy python module"
HOMEPAGE="https://astroscrappy.readthedocs.io"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"
KEYWORDS="~amd64 ~x86"

LICENSE="BSD"
SLOT="0"
IUSE="doc intersphinx"
RESTRICT="intersphinx? ( network-sandbox )"
REQUIRED_USE="intersphinx? ( doc )"

RDEPEND="dev-python/astropy[${PYTHON_USEDEP}]"
BDEPEND="dev-python/setuptools-scm[${PYTHON_USEDEP}]
	dev-python/cython[${PYTHON_USEDEP}]
	dev-python/numpy[${PYTHON_USEDEP}]
	dev-python/extension-helpers[${PYTHON_USEDEP}]
	test? (
		dev-python/pytest-doctestplus[${PYTHON_USEDEP}]
		dev-python/scipy[${PYTHON_USEDEP}]
	)
"

DOCS=( README.rst CHANGES.rst )

distutils_enable_tests pytest

python_compile_all() {
if use doc; then
	pushd docs || die
	VARTEXFONTS="${T}"/fonts MPLCONFIGDIR="${T}" PYTHONPATH="${BUILD_DIR}"/lib \
		emake "SPHINXOPTS=$(usex intersphinx '' '-D disable_intersphinx=1')" html
	popd || die
	HTML_DOCS=( docs/_build/html/. )
fi
}

python_test() {
	epytest "${BUILD_DIR}/lib"
}
