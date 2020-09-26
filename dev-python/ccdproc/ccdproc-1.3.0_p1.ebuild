# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

MY_PV=$(ver_cut 1-3).post$(ver_cut 5)
MY_P=${PN}-${MY_PV}

DISTUTILS_USE_SETUPTOOLS=rdepend
PYTHON_COMPAT=( python3_{5,6,7,8} )

inherit distutils-r1

DESCRIPTION="Astropy affiliated package for reducing optical/IR CCD data"
HOMEPAGE="https://ccdproc.readthedocs.io"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${MY_P}.tar.gz"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"

LICENSE="BSD"
SLOT="0"
IUSE="doc"
RESTRICT="!test? ( test )"

RDEPEND=">=dev-python/astropy-1.0[${PYTHON_USEDEP}]
	sci-libs/scikits_image[${PYTHON_USEDEP}]
	dev-python/astroscrappy[${PYTHON_USEDEP}]
	dev-python/reproject[${PYTHON_USEDEP}]
	dev-python/scipy[${PYTHON_USEDEP}]
"
DEPEND="${RDEPEND}
	<dev-python/astropy-helpers-3.2[${PYTHON_USEDEP}]
	doc? (
		dev-python/sphinx-astropy[${PYTHON_USEDEP}]
		media-gfx/graphviz
	)
	test? ( dev-python/pytest-astropy[${PYTHON_USEDEP}] )
"

S="${WORKDIR}/${MY_P}"

distutils_enable_tests setup.py

python_prepare_all() {
	sed -i -e '/auto_use/s/True/False/' setup.cfg || die
	sed -i -e '/[pytest]/s/pytest/tool:pytest/' setup.cfg || die
	export mydistutilsargs=( --offline )
	distutils-r1_python_prepare_all
}

python_compile() {
	distutils-r1_python_compile --use-system-libraries
}

python_compile_all() {
	use doc && esetup.py build_docs
}

python_install_all() {
	use doc && local HTML_DOCS=( docs/_build/html/. )
	distutils-r1_python_install_all
}
