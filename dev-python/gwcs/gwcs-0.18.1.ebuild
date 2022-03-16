# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{8..10} )

inherit distutils-r1

DESCRIPTION="Generalized World Coordinate System"
HOMEPAGE="https://gwcs.readthedocs.io"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc intersphinx"
RESTRICT="intersphinx? ( network-sandbox )"
REQUIRED_USE="intersphinx? ( doc )"

RDEPEND=">=dev-python/asdf-2.8.1[${PYTHON_USEDEP}]
	dev-python/asdf_wcs_schemas[${PYTHON_USEDEP}]
	>=dev-python/asdf-astropy-0.2.0[${PYTHON_USEDEP}]
	>=dev-python/astropy-4.1[${PYTHON_USEDEP}]
	dev-python/scipy[${PYTHON_USEDEP}]
"

BDEPEND="dev-python/setuptools_scm[${PYTHON_USEDEP}]
	doc? (
		${RDEPEND}
		dev-python/sphinx-astropy[${PYTHON_USEDEP}]
		dev-python/sphinx-asdf[${PYTHON_USEDEP}]
		media-gfx/graphviz
	)
	test? (
		dev-python/pytest-doctestplus[${PYTHON_USEDEP}]
		dev-python/pytest-remotedata[${PYTHON_USEDEP}]
		dev-python/typeguard[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest
#distutils_enable_sphinx docs dev-python/sphinx-astropy dev-python/sphinx-asdf

EPYTEST_IGNORE=(
	# some modules only available for astropy>=5.0
	gwcs/converters/tests/test_transforms.py
	gwcs/tests/test_geometry.py
)

python_compile_all() {
	if use doc; then
		pushd docs || die
		VARTEXFONTS="${T}"/fonts MPLCONFIGDIR="${T}" PYTHONPATH="${BUILD_DIR}"/install/$(python_get_sitedir) \
			emake "SPHINXOPTS=$(usex intersphinx '' '-D disable_intersphinx=1')" html
		popd || die
		HTML_DOCS=( docs/_build/html/. )
	fi
}
