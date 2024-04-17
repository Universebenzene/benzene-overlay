# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1 pypi

DESCRIPTION="Fast 1D and 2D histogram functions in Python"
HOMEPAGE="https://github.com/astrofrog/fast-histogram"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="examples"

DEPEND="dev-python/numpy[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}"
BDEPEND="${DEPEND}
	dev-python/setuptools-scm[${PYTHON_USEDEP}]
	test? ( dev-python/hypothesis[${PYTHON_USEDEP}] )
"

distutils_enable_tests pytest

python_install_all() {
	if use examples; then
		docompress -x "/usr/share/doc/${PF}/comparison"/{benchmark,plot}.py
		docinto comparison
		dodoc -r comparison/.
	fi

	distutils-r1_python_install_all
}

python_test() {
	epytest "${BUILD_DIR}"
}
