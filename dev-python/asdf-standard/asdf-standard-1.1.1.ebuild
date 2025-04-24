# Copyright 2022-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..13} )

inherit distutils-r1 pypi

DESCRIPTION="Standards document describing ASDF, Advanced Scientific Data Format"
HOMEPAGE="https://asdf-standard.readthedocs.io"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc intersphinx"
RESTRICT="intersphinx? ( network-sandbox )"
REQUIRED_USE="intersphinx? ( doc )"

BDEPEND="dev-python/setuptools-scm[${PYTHON_USEDEP}]
	doc? (
		${RDEPEND}
		>=dev-python/sphinx-asdf-0.1.4[${PYTHON_USEDEP}]
		media-gfx/graphviz
	)
	test? ( >=dev-python/packaging-16.0[${PYTHON_USEDEP}] )
"
PDEPEND="test? ( >=dev-python/asdf-3.0.0[${PYTHON_USEDEP}] )"

distutils_enable_tests pytest
#distutils_enable_sphinx docs/source '>=dev-python/sphinx-asdf-0.1.4'

python_compile_all() {
	if use doc; then
		VARTEXFONTS="${T}"/fonts MPLCONFIGDIR="${T}" PYTHONPATH="${BUILD_DIR}"/install/$(python_get_sitedir) \
			emake "SPHINXOPTS=$(usex intersphinx '' '-D disable_intersphinx=1')" -C docs html
		HTML_DOCS=( docs/build/html/. )
	fi
}
