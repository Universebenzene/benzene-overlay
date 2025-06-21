# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..14} )

inherit distutils-r1 pypi

DESCRIPTION="Click params for commmand line interfaces to GeoJSON"
HOMEPAGE="https://github.com/mapbox/cligj"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RDEPEND=">=dev-python/click-4.0[${PYTHON_USEDEP}]"

distutils_enable_tests pytest
