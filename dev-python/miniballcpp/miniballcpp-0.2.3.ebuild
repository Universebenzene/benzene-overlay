# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=setuptools
PYPI_NO_NORMALIZE=1
PYPI_PN="MiniballCpp"
PYTHON_COMPAT=( python3_{{11..14},{13..14}t} )
#PYTHON_COMPAT=( python3_{{11..12},{13..14}{,t}} )

inherit distutils-r1 pypi

DESCRIPTION="Smallest Enclosing Balls of Points"
HOMEPAGE="https://github.com/weddige/miniball"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

distutils_enable_tests pytest

python_test() {
	[[ -d miniball ]] && { mv {,_}miniball || die ; }
	epytest
	[[ -d _miniball ]] && { mv {_,}miniball || die ; }
}
