# Copyright 2023-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1 pypi

DESCRIPTION="World Coordinate System (WCS) ASDF schemas"
HOMEPAGE="https://github.com/asdf-format/asdf-wcs-schemas"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc intersphinx"
RESTRICT="intersphinx? ( network-sandbox )"
REQUIRED_USE="intersphinx? ( doc )"

RDEPEND=">=dev-python/asdf-standard-1.1.0[${PYTHON_USEDEP}]
	>=dev-python/asdf-transform-schemas-0.6.0[${PYTHON_USEDEP}]
	>=dev-python/asdf-coordinates-schemas-0.4.0[${PYTHON_USEDEP}]
"
BDEPEND=">=dev-python/setuptools-scm-3.4[${PYTHON_USEDEP}]
	doc? (
		${RDEPEND}
		dev-python/sphinx-astropy[${PYTHON_USEDEP}]
		>=dev-python/sphinx-asdf-0.1.3[${PYTHON_USEDEP}]
		dev-python/furo[${PYTHON_USEDEP}]
		>=dev-python/astropy-5.0.4[${PYTHON_USEDEP}]
		dev-python/tomli[${PYTHON_USEDEP}]
		media-gfx/graphviz
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
