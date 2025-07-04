# Copyright 2020-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1 pypi

DESCRIPTION="Optimized cosmic ray annihilation astropy python module"
HOMEPAGE="https://astroscrappy.readthedocs.io"
KEYWORDS="~amd64 ~x86"

LICENSE="BSD"
SLOT="0"
IUSE="doc intersphinx"
RESTRICT="intersphinx? ( network-sandbox )"
REQUIRED_USE="intersphinx? ( doc )"

DEPEND="dev-python/numpy:=[${PYTHON_USEDEP}]"
RDEPEND="dev-python/astropy[${PYTHON_USEDEP}]"
BDEPEND=">=dev-python/setuptools-scm-6.2[${PYTHON_USEDEP}]
	>=dev-python/cython-3.0[${PYTHON_USEDEP}]
	>=dev-python/extension-helpers-1[${PYTHON_USEDEP}]
	doc? (
		${RDEPEND}
		dev-python/sphinx-astropy[${PYTHON_USEDEP}]
	)
	test? (
		dev-python/pytest-doctestplus[${PYTHON_USEDEP}]
		dev-python/scipy[${PYTHON_USEDEP}]
	)
"

DOCS=( README.rst CHANGES.rst )

distutils_enable_tests pytest

python_prepare_all() {
	use doc && { cat "${FILESDIR}/${P}-setup.cfg" >> "${S}"/setup.cfg || die ; }

	distutils-r1_python_prepare_all
}

python_configure_all() {
	append-flags -std=gnu17
}

python_compile_all() {
	if use doc; then
		VARTEXFONTS="${T}"/fonts MPLCONFIGDIR="${T}" PYTHONPATH="${BUILD_DIR}"/install/$(python_get_sitedir) \
			emake "SPHINXOPTS=$(usex intersphinx '' '-D disable_intersphinx=1')" -C docs html
		HTML_DOCS=( docs/_build/html/. )
	fi
}

python_test() {
	epytest "${BUILD_DIR}"
}
