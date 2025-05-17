# Copyright 2022-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1 optfeature pypi virtualx

DESCRIPTION="Modeling and fitting package for scientific data analysis"
HOMEPAGE="https://sherpa.readthedocs.io"
SRC_URI+=" https://github.com/sherpa/sherpa/raw/refs/tags/${PV}/setup.cfg -> ${P}-setup.cfg
	test? ( https://github.com/sherpa/sherpa-test-data/archive/refs/tags/${PV}.tar.gz -> ${P}-testdata.tar.gz )
"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64" # ds9 no x86 KEYWORD
IUSE="doc intersphinx examples"
PROPERTIES="test_network"
RESTRICT="test
	intersphinx? ( network-sandbox )"
REQUIRED_USE="intersphinx? ( doc )"

DEPEND=">=dev-python/numpy-1.21:=[${PYTHON_USEDEP}]
	sci-libs/fftw:3.0=
"
RDEPEND="${DEPEND}"
BDEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
	$(python_gen_cond_dep 'dev-python/tomli[${PYTHON_USEDEP}]' python3_10)
	doc? (
		${RDEPEND}
		dev-python/sphinx-astropy[${PYTHON_USEDEP}]
		dev-python/sphinx-rtd-theme[${PYTHON_USEDEP}]
		dev-python/nbsphinx[${PYTHON_USEDEP}]
		dev-python/arviz[${PYTHON_USEDEP}]
		>=dev-python/bokeh-3[${PYTHON_USEDEP}]
		media-gfx/graphviz
		sci-geosciences/xyzservices[${PYTHON_USEDEP}]
		virtual/pandoc
	)
	test? (
		dev-python/arviz[${PYTHON_USEDEP}]
		dev-python/astropy[${PYTHON_USEDEP}]
		>=dev-python/bokeh-3[${PYTHON_USEDEP}]
		dev-python/matplotlib[${PYTHON_USEDEP}]
		dev-python/pandas[${PYTHON_USEDEP}]
		dev-python/typing-extensions[${PYTHON_USEDEP}]
		dev-libs/libxml2:2
		sci-astronomy/ds9-bin
		sci-geosciences/xyzservices[${PYTHON_USEDEP}]
	)
"

EPYTEST_XDIST=1
distutils_enable_tests pytest
#distutils_enable_sphinx docs dev-python/sphinx-astropy dev-python/sphinx-rtd-theme dev-python/nbsphinx

python_prepare_all() {
	rm -r extern/fftw-* || die
	mv setup.cfg pypi-setup.cfg || die
	cp {"${DISTDIR}"/${P}-,}setup.cfg || die
	sed -n '/egg_info/,$p' pypi-setup.cfg >> setup.cfg || die

	sed -e "s|#fftw=local|fftw=local|" -e "s|#fftw_include[-_]dirs.*$|fftw_include_dirs=/usr/include|" \
		-e "s|#fftw_lib_dirs.*$|fftw_lib_dirs=/usr/$(get_libdir)|" -e "s|#fftw_libraries|fftw_libraries|" \
		-e "/group_location/a group_location=extern/grplib-4.9/python/.libs/group.so" \
		-e "/stk_location/a stk_location=extern/stklib-4.11/src/.libs/stk.so" -i setup.cfg || die
#	# Fix python3.12 and numpy>1.23
#	sed -e '/^import\ setuptools/c from setuptools import setup' -e '/distutils/d' -i setup.py || die
#	sed -e '/setuptools.command/s/^#\ //' -e '/distutils/d' -i helpers/__init__.py || die
#	sed -e "/^sherpa_inc/s/]/, numpy.get_include()]/" -e '/^from/a import numpy' -i helpers/extensions/__init__.py || die

	distutils-r1_python_prepare_all
}

#python_compile() {
#	distutils-r1_python_compile
#	cp "${S}"/extern/grplib-4.9/python/.libs/group.so "${BUILD_DIR}"/install/$(python_get_sitedir) || die
#	cp "${S}"/extern/stklib-4.11/src/.libs/stk.so "${BUILD_DIR}"/install/$(python_get_sitedir) || die
#}

python_compile_all() {
	if use doc; then
		VARTEXFONTS="${T}"/fonts MPLCONFIGDIR="${T}" PYTHONPATH="${BUILD_DIR}"/install/$(python_get_sitedir) \
			emake "SPHINXOPTS=$(usex intersphinx '' '-D disable_intersphinx=1')" -C docs html
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
#	rm "${ED/%}"/usr/*.so || die
}

python_test() {
	PYTHONPATH="${WORKDIR}/sherpa-test-data-${PV}" virtx epytest --pyargs \
		"${BUILD_DIR}/install/$(python_get_sitedir)/${PN}" --runslow --runzenodo
}

pkg_postinst() {
	optfeature "reading and writing files in FITS format" dev-python/astropy
	optfeature "visualisation of one-dimensional data or models, one- or two- dimensional error analysis, and the results of Monte-Carlo Markov Chain runs" dev-python/matplotlib
	optfeature "interactive display and manipulation of two-dimensional images" sci-astronomy/ds9-bin
}
