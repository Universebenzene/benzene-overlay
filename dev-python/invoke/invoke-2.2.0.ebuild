# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..11} )

inherit distutils-r1 pypi

DESCRIPTION="Pythonic task management & command execution"
HOMEPAGE="http://pyinvoke.org"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="test"	# Test phase runs with fails

RDEPEND="dev-python/fluidity[${PYTHON_USEDEP}]
	dev-python/lexicon[${PYTHON_USEDEP}]
	dev-python/pyyaml[${PYTHON_USEDEP}]
"
BDEPEND="test? (
		dev-python/pytest-relaxed[${PYTHON_USEDEP}]
		dev-python/icecream[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest
distutils_enable_sphinx sites/docs

python_prepare_all() {
	rm -r "${S}"/invoke/vendor || die

	distutils-r1_python_prepare_all
}

python_test() {
	epytest -s tests -k 'not pty'
}
