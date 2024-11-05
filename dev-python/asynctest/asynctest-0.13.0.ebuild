# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

#DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{{10..13},13t} )

inherit distutils-r1 pypi

DESCRIPTION="Enhance standard unittest package with features for testing asyncio libraries"
HOMEPAGE="https://asynctest.readthedocs.io"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"
RESTRICT="test" # test fail with python>3.7

distutils_enable_tests pytest
