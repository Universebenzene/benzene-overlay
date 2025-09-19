# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1 pypi

DESCRIPTION="Generalized World Coordinate System"
HOMEPAGE="https://gwcs.readthedocs.io"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc intersphinx"
RESTRICT="intersphinx? ( network-sandbox )"
REQUIRED_USE="intersphinx? ( doc )"

RDEPEND=">=dev-python/asdf-3.3.0[${PYTHON_USEDEP}]
	>=dev-python/asdf-wcs-schemas-0.5.0[${PYTHON_USEDEP}]
	>=dev-python/asdf-astropy-0.8.0[${PYTHON_USEDEP}]
	>=dev-python/astropy-6.0[${PYTHON_USEDEP}]
	>=dev-python/scipy-1.14.1[${PYTHON_USEDEP}]
"
BDEPEND=">=dev-python/setuptools-scm-3.4[${PYTHON_USEDEP}]
	doc? (
		${RDEPEND}
		dev-python/sphinx-astropy[${PYTHON_USEDEP},confv2]
		dev-python/sphinx-asdf[${PYTHON_USEDEP}]
		dev-python/sphinx-tabs[${PYTHON_USEDEP}]
		dev-python/furo[${PYTHON_USEDEP}]
		media-gfx/graphviz
	)
"

EPYTEST_PLUGINS=( pytest-doctestplus )
distutils_enable_tests pytest
#distutils_enable_sphinx docs dev-python/sphinx-astropy dev-python/sphinx-asdf

python_compile_all() {
	if use doc; then
		VARTEXFONTS="${T}"/fonts MPLCONFIGDIR="${T}" PYTHONPATH="${BUILD_DIR}"/install/$(python_get_sitedir) \
			emake "SPHINXOPTS=$(usex intersphinx '' '-D disable_intersphinx=1')" -C docs html
		HTML_DOCS=( docs/_build/html/. )
	fi
}
