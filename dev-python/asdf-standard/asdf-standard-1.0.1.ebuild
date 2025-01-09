# Copyright 2022-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1 pypi

DESCRIPTION="Standards document describing ASDF, Advanced Scientific Data Format"
HOMEPAGE="https://asdf-standard.readthedocs.io"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="$(python_gen_cond_dep '
		>=dev-python/importlib-resources-3[${PYTHON_USEDEP}]
	' python3_8)"
BDEPEND="dev-python/setuptools-scm[${PYTHON_USEDEP}]
	doc? ( media-gfx/graphviz )
	test? ( <dev-python/jsonschema-4[${PYTHON_USEDEP}] )
"
PDEPEND="test? ( dev-python/asdf[${PYTHON_USEDEP}] )"

distutils_enable_tests pytest
distutils_enable_sphinx docs/source dev-python/sphinx-asdf
