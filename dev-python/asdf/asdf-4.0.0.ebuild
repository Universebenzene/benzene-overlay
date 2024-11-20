# Copyright 2019-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1 optfeature pypi

DESCRIPTION="Python library for the Advanced Scientific Data Format"
HOMEPAGE="https://asdf.readthedocs.io"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="all doc intersphinx"
RESTRICT="intersphinx? ( network-sandbox )"
REQUIRED_USE="intersphinx? ( doc )"

RDEPEND=">=dev-python/numpy-1.22[${PYTHON_USEDEP}]
	>=dev-python/attrs-22.2.0[${PYTHON_USEDEP}]
	>=dev-python/asdf-standard-1.1.0[${PYTHON_USEDEP}]
	>=dev-python/asdf-transform-schemas-0.3[${PYTHON_USEDEP}]
	>=dev-python/jmespath-0.6.2[${PYTHON_USEDEP}]
	>=dev-python/packaging-19.0[${PYTHON_USEDEP}]
	>=dev-python/pyyaml-5.4.1[${PYTHON_USEDEP}]
	>=dev-python/semantic-version-2.8[${PYTHON_USEDEP}]
	$(python_gen_cond_dep '
		>=dev-python/importlib-metadata-4.11.4[${PYTHON_USEDEP}]
	' python3_10)
	all? ( >=dev-python/lz4-0.10[${PYTHON_USEDEP}] )
"
BDEPEND=">=dev-python/setuptools-scm-3.4[${PYTHON_USEDEP}]
	doc? (
		${RDEPEND}
		>=dev-python/sphinx-asdf-0.2.2[${PYTHON_USEDEP}]
		dev-python/sphinx-inline-tabs[${PYTHON_USEDEP}]
		>=dev-python/mistune-3[${PYTHON_USEDEP}]
		$(python_gen_cond_dep '
			dev-python/tomli[${PYTHON_USEDEP}]
		' python3_10)
		media-gfx/graphviz
	)
	test? (
		dev-python/pytest-remotedata[${PYTHON_USEDEP}]
		dev-python/aiohttp[${PYTHON_USEDEP}]
		dev-python/fsspec[${PYTHON_USEDEP}]
		dev-python/lz4[${PYTHON_USEDEP}]
		dev-python/psutil[${PYTHON_USEDEP}]
		dev-python/requests[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest
#distutils_enable_sphinx docs ">=dev-python/sphinx-asdf-0.2.2" dev-python/tomli

python_compile_all() {
	if use doc; then
		VARTEXFONTS="${T}"/fonts MPLCONFIGDIR="${T}" PYTHONPATH="${BUILD_DIR}"/install/$(python_get_sitedir) \
			emake "SPHINXOPTS=$(usex intersphinx '' '-D disable_intersphinx=1')" -C docs html
		HTML_DOCS=( docs/_build/html/. )
	fi
}

python_test() {
	epytest --remote-data
}

pkg_postinst() {
	optfeature "units, time, transform, wcs, or running the tests" ">=dev-python/astropy-3.0"
	optfeature "lz4 compression" ">=dev-python/lz4-0.10"
}
