# Copyright 2022-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{{11..14},{13..14}t} )
#PYTHON_COMPAT=( python3_{{11..12},{13..14}{,t}} )

inherit distutils-r1 pypi

DESCRIPTION="C implementation of Python 3 functools.lru_cache"
HOMEPAGE="https://github.com/pbrady/fastcache"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

distutils_enable_tests pytest

python_test() {
	epytest "${BUILD_DIR}"
}
