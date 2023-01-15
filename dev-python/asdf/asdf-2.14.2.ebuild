# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{9..10} )

inherit distutils-r1 optfeature

DESCRIPTION="Python library for the Advanced Scientific Data Format"
HOMEPAGE="https://asdf.readthedocs.io"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc intersphinx"
RESTRICT="intersphinx? ( network-sandbox )"
REQUIRED_USE="intersphinx? ( doc )"

RDEPEND=">=dev-python/numpy-1.18[${PYTHON_USEDEP}]
	>=dev-python/asdf-standard-1.0.1[${PYTHON_USEDEP}]
	>=dev-python/asdf_transform_schemas-0.2.2[${PYTHON_USEDEP}]
	>=dev-python/asdf_unit_schemas-0.1.0[${PYTHON_USEDEP}]
	>=dev-python/jsonschema-4.0.1[${PYTHON_USEDEP}]
	>=dev-python/jmespath-0.6.2[${PYTHON_USEDEP}]
	>=dev-python/packaging-16.0[${PYTHON_USEDEP}]
	>=dev-python/pyyaml-3.10[${PYTHON_USEDEP}]
	>=dev-python/semantic_version-2.8[${PYTHON_USEDEP}]
	$(python_gen_cond_dep '
		>=dev-python/importlib_metadata-3[${PYTHON_USEDEP}]
	' python3_9)
"
BDEPEND="dev-python/setuptools_scm[${PYTHON_USEDEP}]
	doc? (
		${RDEPEND}
		>=dev-python/sphinx-asdf-0.1.4[${PYTHON_USEDEP}]
		dev-python/tomli[${PYTHON_USEDEP}]
	)
	test? (
		dev-python/pytest-doctestplus[${PYTHON_USEDEP}]
		dev-python/pytest-remotedata[${PYTHON_USEDEP}]
		dev-python/pytest-openfiles[${PYTHON_USEDEP}]
		dev-python/astropy[${PYTHON_USEDEP}]
		dev-python/aiohttp[${PYTHON_USEDEP}]
		dev-python/fsspec[${PYTHON_USEDEP}]
		dev-python/lz4[${PYTHON_USEDEP}]
		dev-python/psutil[${PYTHON_USEDEP}]
		dev-python/requests[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest
#distutils_enable_sphinx docs ">=dev-python/sphinx-asdf-0.1.4" dev-python/tomli

python_compile_all() {
	if use doc; then
		pushd docs || die
		VARTEXFONTS="${T}"/fonts MPLCONFIGDIR="${T}" PYTHONPATH="${BUILD_DIR}"/install/$(python_get_sitedir) \
			emake "SPHINXOPTS=$(usex intersphinx '' '-D disable_intersphinx=1')" html
		popd || die
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
