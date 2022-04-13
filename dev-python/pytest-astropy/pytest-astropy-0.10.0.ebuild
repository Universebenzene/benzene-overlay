# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{8..10} )

inherit distutils-r1

DESCRIPTION="Metapackage for all the testing machinery used by the Astropy Project"
HOMEPAGE="https://github.com/astropy/pytest-astropy"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RDEPEND=">=dev-python/hypothesis-5.1[${PYTHON_USEDEP}]
	>=dev-python/pytest-astropy-header-0.1.2[${PYTHON_USEDEP}]
	>=dev-python/pytest-arraydiff-0.1[${PYTHON_USEDEP}]
	>=dev-python/pytest-doctestplus-0.11.0[${PYTHON_USEDEP}]
	>=dev-python/pytest-openfiles-0.3.1[${PYTHON_USEDEP}]
	>=dev-python/pytest-remotedata-0.3.1[${PYTHON_USEDEP}]
	>=dev-python/pytest-filter-subpackage-0.1[${PYTHON_USEDEP}]
	>=dev-python/pytest-cov-2.3.1[${PYTHON_USEDEP}]
	>=dev-python/pytest-mock-2.0[${PYTHON_USEDEP}]
	>=dev-python/pytest-4.6[${PYTHON_USEDEP}]
"
# attrs already satisfied by pytest
BDEPEND="dev-python/setuptools_scm[${PYTHON_USEDEP}]"

distutils_enable_tests setup.py
