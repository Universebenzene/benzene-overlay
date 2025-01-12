# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_{10..13} )

inherit distutils-r1 pypi

DESCRIPTION="Plugin for Poetry to enable dynamic versioning based on VCS tags"
HOMEPAGE="https://github.com/mtkennerly/poetry-dynamic-versioning"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="plugin"
PROPERTIES="test_network"
RESTRICT="test"
RDEPEND=">=dev-python/dunamai-1.21.0[${PYTHON_USEDEP}]
	>=dev-python/jinja2-2.11.0[${PYTHON_USEDEP}]
	>=dev-python/tomlkit-0.4[${PYTHON_USEDEP}]
	plugin? ( >=dev-python/poetry-1.2.0[${PYTHON_USEDEP}] )
"
BDEPEND="test? (
		dev-python/certifi[${PYTHON_USEDEP}]
		dev-python/cryptography[${PYTHON_USEDEP}]
		dev-python/more-itertools[${PYTHON_USEDEP}]
		dev-python/poetry[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest
