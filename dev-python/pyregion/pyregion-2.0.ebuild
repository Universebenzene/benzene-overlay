# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6..10} )

inherit distutils-r1 xdg-utils

DESCRIPTION="Python module to parse ds9 region file"
HOMEPAGE="http://pyregion.readthedocs.org/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
LICENSE="MIT"

IUSE="doc"
RESTRICT="!test? ( test )"

DEPEND="dev-python/numpy[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}
	>=dev-python/astropy-1.0[${PYTHON_USEDEP}]
	>=dev-python/pyparsing-2.0[${PYTHON_USEDEP}]
	dev-python/cython[${PYTHON_USEDEP}]
"
BDEPEND="${DEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]
	dev-python/astropy-helpers[${PYTHON_USEDEP}]
	doc? (
		dev-python/sphinx-astropy[${PYTHON_USEDEP}]
		dev-python/astropy[${PYTHON_USEDEP}]
	)
	test? (
		dev-python/pytest-astropy[${PYTHON_USEDEP}]
		dev-python/cython[${PYTHON_USEDEP}]
		<dev-python/astropy-3.2[${PYTHON_USEDEP}]
		dev-python/matplotlib[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests setup.py

python_prepare_all() {
	# use astropy-helpers from system
	sed -i -e '/auto_use/s/True/False/' setup.cfg || die
	xdg_environment_reset
	export mydistutilsargs=( --offline )
	distutils-r1_python_prepare_all
}

python_compile() {
	distutils-r1_python_compile --use-system-libraries
}

python_compile_all() {
	if use doc; then
		python_setup
		VARTEXFONTS="${T}"/fonts \
			MPLCONFIGDIR="${BUILD_DIR}" \
			PYTHONPATH="${BUILD_DIR}"/lib \
			esetup.py build_docs
	fi
}

python_install_all() {
	use doc && local HTML_DOCS=( docs/_build/html/. )
	distutils-r1_python_install_all
}
