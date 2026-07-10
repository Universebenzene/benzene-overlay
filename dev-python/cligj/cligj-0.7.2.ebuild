# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{{11..15},{13..15}t} )
#PYTHON_COMPAT=( python3_{{11..12},{13..15}{,t}} )

inherit distutils-r1 pypi

DESCRIPTION="Click params for commmand line interfaces to GeoJSON"
HOMEPAGE="https://github.com/mapbox/cligj"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RDEPEND=">=dev-python/click-4.0[${PYTHON_USEDEP}]"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest
