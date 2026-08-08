# Copyright 2022-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{{11..15},{13..15}t} )
#PYTHON_COMPAT=( python3_{{11..12},{13..15}{,t}} )

inherit distutils-r1 pypi

DESCRIPTION="Fast random access to bzip2 files in Python"
HOMEPAGE="https://github.com/mxmlnkn/indexed_bzip2"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="test"	# No usable test phases

BDEPEND=">=dev-python/cython-0.29.24[${PYTHON_USEDEP}]"

#distutils_enable_tests nose
