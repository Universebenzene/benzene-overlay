# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{8..10} )

inherit distutils-r1

DESCRIPTION="World Coordinate System (WCS) ASDF schemas"
HOMEPAGE="https://github.com/asdf-format/asdf-wcs-schemas"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc intersphinx"
RESTRICT="intersphinx? ( network-sandbox )"
REQUIRED_USE="intersphinx? ( doc )"

RDEPEND="$(python_gen_cond_dep '
		>=dev-python/importlib_resources-3[${PYTHON_USEDEP}]
	' python3_8)"
BDEPEND="dev-python/setuptools_scm[${PYTHON_USEDEP}]
	doc? (
		${RDEPEND}
		dev-python/sphinx-astropy[${PYTHON_USEDEP}]
		dev-python/sphinx-asdf[${PYTHON_USEDEP}]
		dev-python/asdf[${PYTHON_USEDEP}]
	)
	test? (
		dev-python/pytest-openfiles[${PYTHON_USEDEP}]
	)
"
PDEPEND="dev-python/asdf[${PYTHON_USEDEP}]"

distutils_enable_tests pytest
#distutils_enable_sphinx docs dev-python/sphinx-astropy dev-python/sphinx-asdf dev-python/asdf

python_compile_all() {
	if use doc; then
		pushd docs || die
		VARTEXFONTS="${T}"/fonts MPLCONFIGDIR="${T}" PYTHONPATH="${BUILD_DIR}"/install/$(python_get_sitedir) \
			emake "SPHINXOPTS=$(usex intersphinx '' '-D disable_intersphinx=1')" html
		popd || die
		HTML_DOCS=( docs/_build/html/. )
	fi
}
