# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python{2_7,3_{9..10}} )

inherit distutils-r1 virtualx xdg-utils optfeature

MY_PN=APLpy
MY_P=${MY_PN}-${PV}

DESCRIPTION="Astronomical Plotting Library in Python"
HOMEPAGE="https://aplpy.github.com/"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="doc test"

RDEPEND=">=dev-python/astropy-0.2.0[${PYTHON_USEDEP}]
	>=dev-python/numpy-1.4.1[${PYTHON_USEDEP}]
	>=dev-python/matplotlib-1.0.0[${PYTHON_USEDEP}]
"
BDEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
	dev-python/astropy-helpers[${PYTHON_USEDEP}]
	doc? (
		dev-python/sphinx-astropy[${PYTHON_USEDEP}]
		<dev-python/astropy-3.2[${PYTHON_USEDEP}]
	)
	test? (
		<dev-python/astropy-3[${PYTHON_USEDEP}]
		dev-python/matplotlib[${PYTHON_USEDEP}]
		dev-python/pytest-mpl[${PYTHON_USEDEP}]
		<dev-python/pytest-3.7[${PYTHON_USEDEP}]
	)
"

S="${WORKDIR}/${MY_P}"

PATCHES=( "${FILESDIR}/${PN}-1.0-fix-dependencies.patch" )

python_prepare_all() {
	sed -i -e '/auto_use/s/True/False/' setup.cfg || die
	sed -i -e '/[pytest]/s/pytest/tool:pytest/' setup.cfg || die
	xdg_environment_reset
	export mydistutilsargs=( --offline )
	distutils-r1_python_prepare_all
}

python_compile() {
	distutils-r1_python_compile --use-system-libraries
}

python_compile_all() {
	use doc && esetup.py build_docs --no-intersphinx
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

pkg_postinst() {
	optfeature "Interact with Montage"						dev-python/montage-wrapper
	optfeature "Read DS9 regions files"						dev-python/pyregion
	optfeature "Extend image i/o formats"					dev-python/pillow
	optfeature "Astronomy Visualization Metadata tagging"	dev-python/pyavm
}
