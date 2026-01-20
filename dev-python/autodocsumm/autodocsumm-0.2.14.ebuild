# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..14} )

inherit distutils-r1

DESCRIPTION="Extended sphinx autodoc including automatic autosummaries"
HOMEPAGE="https://autodocsumm.readthedocs.io"
SRC_URI="https://github.com/Chilipp/autodocsumm/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND=">=dev-python/sphinx-4.0[${PYTHON_USEDEP}]"
BDEPEND="dev-python/versioneer[${PYTHON_USEDEP}]
	test? ( dev-python/beautifulsoup4[${PYTHON_USEDEP}] )
"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest
distutils_enable_sphinx docs dev-python/sphinx-rtd-theme

#python_prepare_all() {
#	use doc && { sed -i "/language\ = /s/None/'en'/" docs/conf.py || die ; }
#
#	distutils-r1_python_prepare_all
#}
