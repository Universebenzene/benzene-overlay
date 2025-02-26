# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{{10..13},13t} pypy3 )

inherit distutils-r1 pypi

DESCRIPTION="The fastest markdown parser in pure Python"
HOMEPAGE="https://pypi.org/project/mistune/ https://github.com/lepture/mistune"

SLOT="0"
LICENSE="BSD"
KEYWORDS="~alpha amd64 arm arm64 hppa ~loong ~m68k ~mips ppc ppc64 ~riscv ~s390 sparc x86 ~amd64-linux ~x86-linux ~x64-macos"

distutils_enable_tests pytest
