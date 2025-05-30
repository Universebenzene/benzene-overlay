# Copyright 2022-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1 pypi

DESCRIPTION="ASDF serialization support for astropy"
HOMEPAGE="https://asdf-astropy.readthedocs.io"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc intersphinx"
RESTRICT="intersphinx? ( network-sandbox )"
REQUIRED_USE="intersphinx? ( doc )"

RDEPEND=">=dev-python/asdf-2.14.4[${PYTHON_USEDEP}]
	>=dev-python/asdf-coordinates-schemas-0.3[${PYTHON_USEDEP}]
	>=dev-python/asdf-transform-schemas-0.5[${PYTHON_USEDEP}]
	>=dev-python/astropy-5.2.0[${PYTHON_USEDEP}]
	>=dev-python/numpy-1.24[${PYTHON_USEDEP}]
	>=dev-python/packaging-19[${PYTHON_USEDEP}]
"
BDEPEND=">=dev-python/setuptools-scm-3.4[${PYTHON_USEDEP}]
	doc? (
		${RDEPEND}
		dev-python/sphinx-asdf[${PYTHON_USEDEP}]
		dev-python/sphinx-astropy[${PYTHON_USEDEP}]
		dev-python/tomli[${PYTHON_USEDEP}]
		media-gfx/graphviz
	)
	test? (
		dev-python/pytest-astropy-header[${PYTHON_USEDEP}]
		dev-python/pytest-doctestplus[${PYTHON_USEDEP}]
		dev-python/scipy[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest
#distutils_enable_sphinx docs dev-python/sphinx-asdf dev-python/sphinx-astropy

python_compile_all() {
	if use doc; then
		VARTEXFONTS="${T}"/fonts MPLCONFIGDIR="${T}" PYTHONPATH="${BUILD_DIR}"/install/$(python_get_sitedir) \
			emake "SPHINXOPTS=$(usex intersphinx '' '-D disable_intersphinx=1')" -C docs html
		HTML_DOCS=( docs/_build/html/. )
	fi
}
