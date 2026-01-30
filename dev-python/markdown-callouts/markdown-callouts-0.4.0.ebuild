# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{11..14} )

inherit distutils-r1 pypi

DESCRIPTION="Markdown extension: a classier syntax for admonitions"
HOMEPAGE="https://oprypin.github.io/markdown-callouts"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"	# pytest-golden no x86

RDEPEND=">=dev-python/markdown-3.3.3[${PYTHON_USEDEP}]"
BDEPEND="test? ( dev-python/beautifulsoup4[${PYTHON_USEDEP}] )"

EPYTEST_PLUGINS=( pytest-golden )
distutils_enable_tests pytest
