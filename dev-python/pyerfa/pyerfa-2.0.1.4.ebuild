# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..11} )

inherit distutils-r1 pypi

DESCRIPTION="Python bindings for ERFA"
HOMEPAGE="https://pyerfa.readthedocs.io"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc intersphinx"
RESTRICT="intersphinx? ( network-sandbox )"
REQUIRED_USE="intersphinx? ( doc )"

RDEPEND=">=sci-astronomy/erfa-2.0.1:0=
	>=dev-python/numpy-1.19[${PYTHON_USEDEP}]
"
DEPEND="${RDEPEND}"
BDEPEND="${RDEPEND}
	>=dev-python/setuptools-scm-6.2[${PYTHON_USEDEP}]
	>=dev-python/jinja-2.10.3[${PYTHON_USEDEP}]
	doc? (
		${RDEPEND}
		>=dev-python/sphinx-astropy-1.3[${PYTHON_USEDEP}]
		media-gfx/graphviz
	)
	test? ( >=dev-python/pytest-doctestplus-0.7[${PYTHON_USEDEP}] )
"

distutils_enable_tests pytest
#distutils_enable_sphinx docs dev-python/sphinx-astropy

python_configure_all() {
	export PYERFA_USE_SYSTEM_LIBERFA=1
}

python_compile_all() {
	if use doc; then
		VARTEXFONTS="${T}"/fonts MPLCONFIGDIR="${T}" PYTHONPATH="${BUILD_DIR}"/install/$(python_get_sitedir) \
			emake "SPHINXOPTS=$(usex intersphinx '' '-D disable_intersphinx=1')" -C docs html
		HTML_DOCS=( docs/_build/html/. )
	fi
}

python_test() {
	epytest "${BUILD_DIR}"
}
