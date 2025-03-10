# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYPI_NO_NORMALIZE=1
PYTHON_COMPAT=( python3_{{10..13},13t} pypy3 )

inherit distutils-r1 pypi

DESCRIPTION="Enhanced Sphinx theme (based on Python 3 docs)"
HOMEPAGE="
	https://github.com/ionelmc/sphinx-py3doc-enhanced-theme/
	https://pypi.org/project/sphinx_py3doc_enhanced_theme/
"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha amd64 arm arm64 ~hppa ~m68k ~mips ppc ppc64 ~riscv ~s390 sparc x86"

PATCHES=( "${FILESDIR}/${P}-fix-pytest.patch" )

distutils_enable_tests pytest

python_test() {
	EXTRASTYLING="true" epytest
}
