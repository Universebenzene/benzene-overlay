# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

#DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..13} )

inherit distutils-r1 pypi

DESCRIPTION="The Official API Spec Language for Dropbox API V2"
HOMEPAGE="https://www.dropbox.com/developers https://github.com/dropbox/stone"
SRC_URI+=" https://github.com/dropbox/stone/raw/refs/tags/v${PV}/requirements.txt -> ${P}-requirements.txt
	test? ( https://github.com/dropbox/stone/raw/refs/tags/v${PV}/test/backend_test_util.py -> ${P}-backend_test_util.py )
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND=">=dev-python/packaging-21.0[${PYTHON_USEDEP}]
	>=dev-python/ply-3.4[${PYTHON_USEDEP}]
	>=dev-python/six-1.12.0[${PYTHON_USEDEP}]
"

distutils_enable_tests pytest

python_prepare_all() {
	cp {"${DISTDIR}"/${P}-,"${S}"/}requirements.txt || die
	sed -i '/pytest-runner/d' setup.py || die
	use test && { cp {"${DISTDIR}"/${P}-,"${S}"/test/}backend_test_util.py || die ; }

	distutils-r1_python_prepare_all
}

python_test() {
	touch test/__init__.py || die
	epytest
}
