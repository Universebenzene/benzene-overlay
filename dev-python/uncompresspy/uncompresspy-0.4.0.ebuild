# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{{11..14},{13..14}t} )
#PYTHON_COMPAT=( python3_{{11..12},{13..14}{,t}} )

inherit distutils-r1 pypi

DESCRIPTION="Pure Python package for uncompressing LZW files (.Z)"
HOMEPAGE="https://github.com/kYwzor/uncompresspy"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="test"	# No usable test phases

#distutils_enable_tests nose

python_prepare_all() {
	sed -i "1 i\[build-system]\nbuild-backend = \"setuptools.build_meta\"" pyproject.toml || die

	distutils-r1_python_prepare_all
}
