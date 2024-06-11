# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1

DESCRIPTION="Pytest plugin for testing examples in docstrings and markdown files"
HOMEPAGE="https://github.com/pydantic/pytest-examples"
SRC_URI="https://github.com/pydantic/pytest-examples/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RDEPEND=">=dev-python/pytest-7[${PYTHON_USEDEP}]
	>=dev-python/black-23[${PYTHON_USEDEP}]
	>=dev-util/ruff-0.0.258
"

PATCHES=(
	"${FILESDIR}/${P}-fix-test-ruff.patch"
	"${FILESDIR}/${P}-fix-python-3.12.patch"
)

distutils_enable_tests pytest
