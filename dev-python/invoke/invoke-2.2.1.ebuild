# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1 pypi

DESCRIPTION="Pythonic task management & command execution"
HOMEPAGE="http://pyinvoke.org"
SRC_URI+=" test? ( https://github.com/pyinvoke/invoke/raw/refs/tags/${PV}/pytest.ini -> ${P}-pytest.ini )"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
#RESTRICT="test"	# Test phase runs with fails

RDEPEND="dev-python/fluidity[${PYTHON_USEDEP}]
	dev-python/lexicon[${PYTHON_USEDEP}]
	dev-python/pyyaml[${PYTHON_USEDEP}]
"
BDEPEND="test? ( dev-python/icecream[${PYTHON_USEDEP}] )"

EPYTEST_PLUGINS=( pytest-relaxed )
distutils_enable_tests pytest
distutils_enable_sphinx sites/docs

python_prepare_all() {
	rm -r "${S}"/invoke/vendor || die
	use test && { cp {"${DISTDIR}"/${P}-,"${S}"/}pytest.ini || die ; }

	distutils-r1_python_prepare_all
}

EPYTEST_DESELECT=(
	# https://gitlab.archlinux.org/archlinux/packaging/packages/python-invoke/-/blob/main/PKGBUILD
	tests/runners.py::Local_::env::uses_execve_for_pty_True
	tests/runners.py::Local_::pty
	tests/runners.py::Local_::shell::defaults_to_bash_or_cmdexe_when_pty_True
	tests/runners.py::Local_::shell::may_be_overridden_when_pty_True
)

python_test() {
	epytest -s #-k 'not pty'
}
