# Copyright 2020-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1 pypi

DESCRIPTION="Observation planning package for astronomers"
HOMEPAGE="https://astroplan.readthedocs.org"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc intersphinx plotting"
PROPERTIES="test_network"
RESTRICT="test
	intersphinx? ( network-sandbox )"
REQUIRED_USE="intersphinx? ( doc )"

RDEPEND=">=dev-python/astropy-4[${PYTHON_USEDEP}]
	dev-python/pytz[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]
	plotting? (
		dev-python/astroquery[${PYTHON_USEDEP}]
		>=dev-python/matplotlib-1.4[${PYTHON_USEDEP}]
	)
"
BDEPEND="dev-python/setuptools-scm[${PYTHON_USEDEP}]
	doc? (
		${RDEPEND}
		dev-python/sphinx-astropy[${PYTHON_USEDEP},confv2]
		dev-python/astroquery[${PYTHON_USEDEP}]
		media-gfx/graphviz
	)
	test? (
		dev-python/pytest-astropy-header[${PYTHON_USEDEP}]
		dev-python/pytest-doctestplus[${PYTHON_USEDEP}]
		dev-python/pytest-mpl[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest
#distutils_enable_sphinx docs dev-python/sphinx-astropy dev-python/astroquery

python_compile_all() {
	if use doc; then
		VARTEXFONTS="${T}"/fonts MPLCONFIGDIR="${T}" PYTHONPATH="${BUILD_DIR}"/install/$(python_get_sitedir) \
			emake "SPHINXOPTS=$(usex intersphinx '' '-D disable_intersphinx=1')" -C docs html
		HTML_DOCS=( docs/_build/html/. )
	fi
}
