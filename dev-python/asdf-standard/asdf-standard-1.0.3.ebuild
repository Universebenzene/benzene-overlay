# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{9..11} )

inherit distutils-r1 pypi

DESCRIPTION="Standards document describing ASDF, Advanced Scientific Data Format"
HOMEPAGE="https://asdf-standard.readthedocs.io"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc intersphinx"
RESTRICT="intersphinx? ( network-sandbox )"
REQUIRED_USE="intersphinx? ( doc )"
#RESTRICT="test" # some tests failed for astropy>=5.1

RDEPEND="$(python_gen_cond_dep '
		>=dev-python/importlib-resources-3[${PYTHON_USEDEP}]
	' python3_8)"
BDEPEND="dev-python/setuptools-scm[${PYTHON_USEDEP}]
	doc? (
		${RDEPEND}
		>=dev-python/sphinx-asdf-0.1.4[${PYTHON_USEDEP}]
		media-gfx/graphviz
	)
	test? (
		~dev-python/astropy-5.0.4[${PYTHON_USEDEP}]
	)
"
PDEPEND="test? ( >=dev-python/asdf-2.8[${PYTHON_USEDEP}] )"

distutils_enable_tests pytest
#distutils_enable_sphinx docs/source '>=dev-python/sphinx-asdf-0.1.4'

python_compile_all() {
	if use doc; then
		pushd docs || die
		VARTEXFONTS="${T}"/fonts MPLCONFIGDIR="${T}" PYTHONPATH="${BUILD_DIR}"/install/$(python_get_sitedir) \
			emake "SPHINXOPTS=$(usex intersphinx '' '-D disable_intersphinx=1')" html
		popd || die
		HTML_DOCS=( docs/build/html/. )
	fi
}
