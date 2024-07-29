# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYPI_NO_NORMALIZE=1
PYTHON_COMPAT=( python3_{10..13} )

inherit distutils-r1 pypi

DESCRIPTION="Sphinx global substitutions extension"
HOMEPAGE="https://github.com/missinglinkelectronics/sphinxcontrib-globalsubs"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="test"	# No usable test phases

RDEPEND=">=dev-python/sphinx-1.6[${PYTHON_USEDEP}]"

#distutils_enable_tests nose

#python_install() {
#	distutils-r1_python_install
#	rm -r "${ED%/}"/$(python_get_sitedir)/*-nspkg.pth || die
#}
