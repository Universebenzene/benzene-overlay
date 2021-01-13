# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DISTUTILS_USE_SETUPTOOLS=rdepend
PYTHON_COMPAT=( python3_{6,7,8,9} )

inherit distutils-r1 virtualx optfeature

MY_PN=APLpy
MY_P=${MY_PN}-${PV}

DESCRIPTION="Astronomical Plotting Library in Python"
HOMEPAGE="https://aplpy.github.com/"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="doc test"
#RESTRICT="network-sandbox"

RDEPEND=">=dev-python/astropy-3.1[${PYTHON_USEDEP}]
	>=dev-python/numpy-1.11[${PYTHON_USEDEP}]
	>=dev-python/matplotlib-2.0[${PYTHON_USEDEP}]
	>=dev-python/reproject-0.4[${PYTHON_USEDEP}]
	>=dev-python/pyavm-0.9.4[${PYTHON_USEDEP}]
	>=dev-python/pyregion-2.0[${PYTHON_USEDEP}]
	>=dev-python/pillow-4.0[${PYTHON_USEDEP}]
	>=sci-libs/scikit-image-0.14[${PYTHON_USEDEP}]
	dev-python/imageio[${PYTHON_USEDEP}]
	>=sci-libs/Shapely-1.6[${PYTHON_USEDEP}]
"
BDEPEND="dev-python/astropy-helpers[${PYTHON_USEDEP}]
	doc? (
		dev-python/sphinx-astropy[${PYTHON_USEDEP}]
		dev-python/astropy[${PYTHON_USEDEP}]
		dev-python/reproject[${PYTHON_USEDEP}]
	)
	test? (
		${RDEPEND}
		dev-python/pytest-astropy[${PYTHON_USEDEP}]
	)
"

S="${WORKDIR}/${MY_P}"

PATCHES=( "${FILESDIR}/${P}-test-pyavm-detection.patch" )

#distutils_enable_tests setup.py

python_prepare_all() {
	sed -i -e '/auto_use/s/True/False/' setup.cfg || die
	export mydistutilsargs=( --offline )
	distutils-r1_python_prepare_all
}

python_compile() {
	distutils-r1_python_compile --use-system-libraries
}

python_compile_all() {
	use doc && esetup.py build_docs
}

python_test() {
	distutils_install_for_testing
	cd "${TEST_DIR}" || die
	echo "backend: Agg" > matplotlibrc
	virtx "${EPYTHON}" -c "import aplpy, sys;r = aplpy.test();sys.exit(r)"
}

python_install_all() {
	use doc && local HTML_DOCS=( docs/_build/html/. )
	distutils-r1_python_install_all
}
