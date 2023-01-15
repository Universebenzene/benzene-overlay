# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{9..10} )

inherit distutils-r1

DESCRIPTION="Observation planning package for astronomers"
HOMEPAGE="https://astroplan.readthedocs.org"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

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
		dev-python/matplotlib[${PYTHON_USEDEP}]
	)
"
BDEPEND="dev-python/setuptools_scm[${PYTHON_USEDEP}]
	doc? (
		${RDEPEND}
		dev-python/sphinx-astropy[${PYTHON_USEDEP}]
		dev-python/astroquery[${PYTHON_USEDEP}]
		media-gfx/graphviz
	)
	test? (
		${RDEPEND}
		dev-python/pytest-doctestplus[${PYTHON_USEDEP}]
		dev-python/pytest-remotedata[${PYTHON_USEDEP}]
		dev-python/pytest-astropy-header[${PYTHON_USEDEP}]
		dev-python/pytest-mpl[${PYTHON_USEDEP}]
		dev-python/matplotlib[${PYTHON_USEDEP}]
	)"

distutils_enable_tests pytest
#distutils_enable_sphinx docs dev-python/sphinx-astropy dev-python/astroquery

python_prepare_all() {
	sed -e "/nasa_exoplanet_archive/s/nasa_exoplanet_archive/ipac.nexsci.nasa_exoplanet_archive/g" \
		-i docs/tutorials/periodic.rst || die

	distutils-r1_python_prepare_all
}

python_compile_all() {
	if use doc; then
		pushd docs || die
		VARTEXFONTS="${T}"/fonts MPLCONFIGDIR="${T}" PYTHONPATH="${BUILD_DIR}"/install/$(python_get_sitedir) \
			emake "SPHINXOPTS=$(usex intersphinx '' '-D disable_intersphinx=1')" html
		popd || die
		HTML_DOCS=( docs/_build/html/. )
	fi
}
