# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DISTUTILS_USE_SETUPTOOLS=rdepend
PYTHON_COMPAT=( python3_{6,7,8,9} )

inherit distutils-r1

DESCRIPTION="Python for managing the World Coordinate System"
HOMEPAGE="http://gwcs.readthedocs.org"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="doc"
RESTRICT="!test? ( test )"

RDEPEND="
	dev-python/astropy[${PYTHON_USEDEP}]
	dev-python/asdf[${PYTHON_USEDEP}]
"
BDEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
	>=dev-python/astropy-helpers-3.1[${PYTHON_USEDEP}]
	doc? (
		${RDEPEND}
		dev-python/sphinx-astropy[${PYTHON_USEDEP}]
	)
	test? (
		${RDEPEND}
		dev-python/pytest-astropy[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests setup.py

python_prepare_all() {
	# use system astropy-helpers instead of bundled one
	sed -i -e '/auto_use/s/True/False/' setup.cfg || die
	export mydistutilsargs=( --offline )
	distutils-r1_python_prepare_all
}

python_compile() {
	distutils-r1_python_compile --use-system-libraries
}

python_compile_all() {
	if use doc; then
		python_setup
		PYTHONPATH="${BUILD_DIR}"/lib \
			esetup.py build_docs --no-intersphinx
	fi
}

python_install_all() {
	use doc && local HTML_DOCS=( docs/_build/html/. )
	distutils-r1_python_install_all
}
