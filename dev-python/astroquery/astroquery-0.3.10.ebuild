# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DISTUTILS_USE_SETUPTOOLS=rdepend
PYTHON_COMPAT=( python{2_7,3_{5,6,7,8}} )

inherit distutils-r1 eutils

DESCRIPTION="Collection of packages to access online astronomical resources"
HOMEPAGE="https://github.com/astropy/astroquery"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="doc"
#RESTRICT="network-sandbox"
RESTRICT="!test? ( test )"

PYTHON_REQ_USE="test? ( tk )"

RDEPEND=">=dev-python/astropy-2.0[${PYTHON_USEDEP}]
	>=dev-python/beautifulsoup-4.3.2:4[${PYTHON_USEDEP}]
	>=dev-python/html5lib-0.999[${PYTHON_USEDEP}]
	>=dev-python/keyring-4.0[${PYTHON_USEDEP}]
	>=dev-python/requests-2.4.3[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]
"
BDEPEND=">=dev-python/astropy-helpers-2.0.10[${PYTHON_USEDEP}]
	doc? (
		dev-python/sphinx-astropy[${PYTHON_USEDEP}]
		<dev-python/astropy-4[${PYTHON_USEDEP}]
		media-gfx/graphviz
	)
	test? (
		${RDEPEND}
		dev-python/pytest-astropy[${PYTHON_USEDEP}]
		dev-python/aplpy[${PYTHON_USEDEP}]
		dev-python/pyregion[${PYTHON_USEDEP}]
	)
"

REQUIRED_USE="test? ( || ( $(python_gen_useflags 'python3*') ) )"

distutils_enable_tests setup.py

python_prepare_all() {
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

pkg_postinst() {
	optfeature "running the tests"							dev-python/pytest-astropy
	optfeature "the full functionality of the alma module"	dev-python/aplpy dev/pyregion
	optfeature "the full functionality of the cds module"	dev-python/astropy-healpix dev/regions
}
