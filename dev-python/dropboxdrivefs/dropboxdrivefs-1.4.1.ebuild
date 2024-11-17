# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..13} )

inherit distutils-r1 pypi

DESCRIPTION="Dropbox implementation for fsspec module"
HOMEPAGE="https://github.com/fsspec/dropboxdrivefs"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
PROPERTIES="test_network"
RESTRICT="test"	# invalid_access_token

RDEPEND="dev-python/fsspec[${PYTHON_USEDEP}]
	dev-python/dropbox[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
"

distutils_enable_tests pytest
