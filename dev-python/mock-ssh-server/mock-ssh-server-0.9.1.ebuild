# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYPI_NO_NORMALIZE=1
PYTHON_COMPAT=( python3_{10..13} )

inherit distutils-r1 pypi

DESCRIPTION="Mock SSH server for testing purposes"
HOMEPAGE="https://github.com/carletes/mock-ssh-server"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-python/paramiko[${PYTHON_USEDEP},server]"
BDEPEND="test? ( virtual/openssh )"

distutils_enable_tests pytest
