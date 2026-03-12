# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYPI_VERIFY_REPO=https://github.com/pytest-cython/pytest-cython
PYTHON_COMPAT=( python3_{11..14} )

inherit distutils-r1 pypi

DESCRIPTION="A plugin for testing Cython extension modules"
HOMEPAGE="https://github.com/pytest-cython/pytest-cython"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND=">=dev-python/pytest-8[${PYTHON_USEDEP}]"
BDEPEND="test? (
		dev-python/cython[${PYTHON_USEDEP}]
		dev-python/build[${PYTHON_USEDEP}]
	)
"

EPYTEST_PLUGIN_LOAD_VIA_ENV=1
EPYTEST_PLUGINS=( "${PN}" )
distutils_enable_tests pytest

python_test() {
	${EPYTHON} -m build -wn tests/example-project || die
	cp tests/example-project/{build/lib*/pypackage/*-gnu.so,src/pypackage} || die
	PYTHONPATH="tests/example-project/src" epytest
	rm -r tests/example-project/{build,dist,.pytest_cache,src/{*.egg-info,pypackage/*-gnu.so}} || die
}
