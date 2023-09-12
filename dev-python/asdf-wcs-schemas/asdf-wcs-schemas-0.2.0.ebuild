# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..11} )

inherit distutils-r1 pypi

DESCRIPTION="World Coordinate System (WCS) ASDF schemas"
HOMEPAGE="https://github.com/asdf-format/asdf-wcs-schemas"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc intersphinx"
RESTRICT="intersphinx? ( network-sandbox )"
REQUIRED_USE="intersphinx? ( doc )"

RDEPEND=">=dev-python/asdf-standard-1.0.1[${PYTHON_USEDEP}]
	>=dev-python/asdf-transform-schemas-0.3.0[${PYTHON_USEDEP}]
	>=dev-python/asdf-unit-schemas-0.1.0[${PYTHON_USEDEP}]
	$(python_gen_cond_dep '
		>=dev-python/importlib-resources-3[${PYTHON_USEDEP}]
	' python3_8)"
BDEPEND=">=dev-python/setuptools-scm-3.4[${PYTHON_USEDEP}]
	doc? (
		${RDEPEND}
		dev-python/sphinx-astropy[${PYTHON_USEDEP}]
		dev-python/sphinx-asdf[${PYTHON_USEDEP}]
		dev-python/asdf[${PYTHON_USEDEP}]
	)
	test? (
		dev-python/asdf[${PYTHON_USEDEP}]
		dev-python/asdf-coordinates-schemas[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest
#distutils_enable_sphinx docs dev-python/sphinx-astropy dev-python/sphinx-asdf dev-python/asdf

python_compile_all() {
	if use doc; then
		VARTEXFONTS="${T}"/fonts MPLCONFIGDIR="${T}" PYTHONPATH="${BUILD_DIR}"/install/$(python_get_sitedir) \
			emake "SPHINXOPTS=$(usex intersphinx '' '-D disable_intersphinx=1')" -C docs html
		HTML_DOCS=( docs/_build/html/. )
	fi
}
