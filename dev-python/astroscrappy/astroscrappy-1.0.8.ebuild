# Copyright 2020-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
DISTUTILS_USE_SETUPTOOLS=rdepend
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1 pypi

DESCRIPTION="Optimized cosmic ray annihilation astropy python module"
HOMEPAGE="https://astroscrappy.readthedocs.io"
#KEYWORDS="~amd64 ~x86"

LICENSE="BSD"
SLOT="0"
IUSE="doc +openmp"

RDEPEND="dev-python/astropy[${PYTHON_USEDEP}]"
BDEPEND="dev-python/cython[${PYTHON_USEDEP}]
	dev-python/astropy-helpers[${PYTHON_USEDEP}]
	dev-python/numpy[${PYTHON_USEDEP}]
	doc? (
		${RDEPEND}
		<dev-python/astropy-helpers-3[${PYTHON_USEDEP}]
		dev-python/sphinx[${PYTHON_USEDEP}]
	)
	test? ( dev-python/pytest-astropy[${PYTHON_USEDEP}] )
"

DOCS=( README.rst CHANGES.rst )

PATCHES=( "${FILESDIR}/${P}-respect-user-flag.patch" )

distutils_enable_tests setup.py

python_prepare_all() {
	# use astropy-helpers from system
	sed -i -e '/auto_use/s/True/False/' setup.cfg || die
	# if the user explicitely does not want openmp, do not forcefully use it
	if ! use openmp; then
		sed -e 's/if has_openmp/if False/' \
			-i astroscrappy/utils/setup_package.py || die
	fi
	export DISTUTILS_ARGS=( --offline )
	distutils-r1_python_prepare_all
}

python_compile() {
	distutils-r1_python_compile --use-system-libraries
}

python_compile_all() {
	use doc && esetup.py build_docs --no-intersphinx
}

python_install_all() {
	use doc && local HTML_DOCS=( docs/_build/html/. )
	distutils-r1_python_install_all
}
