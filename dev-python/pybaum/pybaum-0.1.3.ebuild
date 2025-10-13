# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1

DESCRIPTION="A HTTP and FTP parallel file downloader"
HOMEPAGE="https://pybaum.readthedocs.io"
SRC_URI="https://github.com/OpenSourceEconomics/pybaum/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

BDEPEND=">=dev-python/setuptools-scm-6.0[${PYTHON_USEDEP}]
	test? (	dev-python/pandas[${PYTHON_USEDEP}] )
"

distutils_enable_tests pytest
distutils_enable_sphinx docs/source dev-python/sphinx-autoapi dev-python/sphinx-panels dev-python/pydata-sphinx-theme

export SETUPTOOLS_SCM_PRETEND_VERSION=${PV}

#python_prepare_all() {
#	use doc && { sed -i "/language\ = /s/None/'en'/" docs/source/conf.py || die ; }
#
#	distutils-r1_python_prepare_all
#}
