# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1 pypi

DESCRIPTION="ASDF schemas for transforms"
HOMEPAGE="https://github.com/asdf-format/asdf-transform-schemas"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RDEPEND=">=dev-python/asdf-standard-1.0.1[${PYTHON_USEDEP}]
	$(python_gen_cond_dep '
		>=dev-python/importlib-resources-3[${PYTHON_USEDEP}]
	' python3_8)"
PDEPEND="dev-python/asdf[${PYTHON_USEDEP}]"

distutils_enable_tests pytest
