# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{{11..14},{13..14}t} )
#PYTHON_COMPAT=( python3_{{11..12},{13..14}{,t}} )

inherit distutils-r1 pypi

DESCRIPTION="A python wrapper of the C library 'Google CRC32C'"
HOMEPAGE="https://github.com/googleapis/python-crc32c"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="dev-libs/crc32c"
RDEPEND="${DEPEND}"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest
