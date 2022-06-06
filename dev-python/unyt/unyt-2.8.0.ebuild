# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{8..10} )

inherit distutils-r1

DESCRIPTION="Handle, manipulate, and convert data with units in Python"
HOMEPAGE="https://unyt.readthedocs.io"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

RDEPEND=">=dev-python/numpy-1.13.0[${PYTHON_USEDEP}]
	>=dev-python/sympy-1.2[${PYTHON_USEDEP}]
"

BDEPEND="doc? ( dev-python/sphinx[${PYTHON_USEDEP}]
		${RDEPEND}
	)
	test? ( dev-python/matplotlib[${PYTHON_USEDEP}] )
"

distutils_enable_tests pytest
# No module named 'show_all_units'
#distutils_enable_sphinx docs

python_prepare_all() {
	use doc && { mkdir "${S}"/docs/extensions || die; \
		cp {"${FILESDIR}"/${P}-,"${S}"/docs/extensions/}show_all_units.py || die ; }
	use test && { mkdir "${S}"/${PN}/tests/data || die; \
		cp {"${FILESDIR}"/${P}-,"${S}"/${PN}/tests/data/}old_json_registry.txt || die ; }

	distutils-r1_python_prepare_all
}

python_compile_all() {
	if use doc; then
		pushd docs || die
		VARTEXFONTS="${T}"/fonts MPLCONFIGDIR="${T}" PYTHONPATH="${BUILD_DIR}"/install/$(python_get_sitedir) \
			emake html
		popd || die
		HTML_DOCS=( docs/_build/html/. )
	fi
}
