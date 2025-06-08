# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYPI_NO_NORMALIZE=1
PYTHON_COMPAT=( python3_{{11..14},{13..14}t} )
#PYTHON_COMPAT=( python3_{{11..12},{13..14}{,t}} )

inherit distutils-r1 pypi #xdg-utils

DESCRIPTION="Helpers for Astropy and Affiliated packages"
HOMEPAGE="https://astropy-helpers.readthedocs.io"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"

PATCHES=( "${FILESDIR}/${P}-fix-importlib.patch" )

#python_prepare() {
#	DISTUTILS_IN_SOURCE_BUILD is not supported in PEP517 mode
#	sed -e "/astropy_helpers/s:astropy_helpers:$(python_get_sitedir)/astropy_helpers:" \
#		-i "astropy_helpers/commands/build_sphinx.py" || die
#	xdg_environment_reset
#}

python_compile() {
	distutils-r1_python_compile
	sed -e "/astropy_helpers/s:astropy_helpers:$(python_get_sitedir)/astropy_helpers:" \
		-i "${BUILD_DIR}/install/$(python_get_sitedir)/astropy_helpers/commands/build_sphinx.py" || die
}
