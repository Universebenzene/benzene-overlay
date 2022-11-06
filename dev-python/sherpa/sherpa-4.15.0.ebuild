# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

#DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{8..10} )

inherit distutils-r1 optfeature virtualx

DESCRIPTION="Modeling and fitting package for scientific data analysis"
HOMEPAGE="https://sherpa.readthedocs.io"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64" # ds9 no x86 KEYWORD
IUSE="doc intersphinx examples"
RESTRICT="intersphinx? ( network-sandbox )"
REQUIRED_USE="intersphinx? ( doc )"

DEPEND=">=dev-python/numpy-1.20[${PYTHON_USEDEP}]
	sci-libs/fftw:3.0=
"
RDEPEND="${DEPEND}"
BDEPEND="doc? (
		${RDEPEND}
		dev-python/sphinx-astropy[${PYTHON_USEDEP}]
		dev-python/sphinx_rtd_theme[${PYTHON_USEDEP}]
		dev-python/nbsphinx[${PYTHON_USEDEP}]
		media-gfx/graphviz
		virtual/pandoc
	)
	test? (
		dev-python/pytest-xvfb[${PYTHON_USEDEP}]
		dev-python/astropy[${PYTHON_USEDEP}]
		dev-python/matplotlib[${PYTHON_USEDEP}]
		sci-astronomy/ds9-bin
	)
"

distutils_enable_tests pytest
#distutils_enable_sphinx docs dev-python/sphinx-astropy dev-python/sphinx_rtd_theme dev-python/nbsphinx

python_prepare_all() {
	sed -e "s|#fftw=local|fftw=local|" -e "s|#fftw-include[-_]dirs.*$|fftw-include_dirs=/usr/include|" \
		-e "s|#fftw-lib-dirs.*$|fftw-lib-dirs=/usr/$(get_libdir)|" -e "s|#fftw-libraries|fftw-libraries|" -i setup.cfg || die

	distutils-r1_python_prepare_all
}

python_compile_all() {
	if use doc; then
		pushd docs || die
#		VARTEXFONTS="${T}"/fonts MPLCONFIGDIR="${T}" PYTHONPATH="${BUILD_DIR}"/install/$(python_get_sitedir) \
		VARTEXFONTS="${T}"/fonts MPLCONFIGDIR="${T}" PYTHONPATH="${BUILD_DIR}"/lib \
			emake "SPHINXOPTS=$(usex intersphinx '' '-D disable_intersphinx=1')" html
		popd || die
		HTML_DOCS=( docs/_build/html/. )
	fi
}

python_install_all() {
	if use examples; then
		docompress -x "/usr/share/doc/${PF}/notebooks"
		docinto notebooks
		dodoc -r notebooks/.
	fi

	distutils-r1_python_install_all
}

python_test() {
	virtx epytest "${BUILD_DIR}/lib"
}

pkg_postinst() {
	optfeature "reading and writing files in FITS format" dev-python/astropy
	optfeature "visualisation of one-dimensional data or models, one- or two- dimensional error analysis, and the results of Monte-Carlo Markov Chain runs" dev-python/matplotlib
	optfeature "interactive display and manipulation of two-dimensional images" sci-astronomy/ds9-bin
}
