# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1 pypi

DESCRIPTION="Add source, edit, history, annotate links to GitHub or BitBucket"
HOMEPAGE="https://github.com/westurner/sphinxcontrib-srclinks"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"	# tree-sitter-languages, textual no x86
RESTRICT="test"	# No usable test phases

RDEPEND=">=dev-python/pytest-8.0.0[${PYTHON_USEDEP}]
	>=dev-python/jinja2-3.0.0[${PYTHON_USEDEP}]
	>=dev-python/rich-12.0.0[${PYTHON_USEDEP}]
	>=dev-python/syrupy-4.0.0[${PYTHON_USEDEP}]
	>=dev-python/textual-0.28.0[${PYTHON_USEDEP}]
"

#distutils_enable_tests nose
